import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:note_illustrator/models/NotesModel.dart';
import 'package:note_illustrator/pages/DashBoardPage.dart';
import 'package:note_illustrator/services/DataBase.dart';
import 'package:note_illustrator/widgets/NoteList.dart';
import 'package:note_illustrator/widgets/NotesPage.dart';
import 'package:note_illustrator/widgets/BottomAppBar.dart';
import 'package:note_illustrator/widgets/UserAppBar.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

List<NotesModel> noteSearchedList;

class _SearchBarState extends State<SearchBar> {
  static const historyLength = 5;

// The "raw" history that we don't access from the UI, prefilled with values
  List<String> _searchHistory = [];
// The filtered & ordered history that's accessed from the UI
  List<String> filteredSearchHistory;

// The currently searched-for term
  String selectedTerm;

  List<String> filterSearchTerms({
    @required String filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
      // Reversed because we want the last added items to appear first in the UI
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  Future getNoteSearched(String filter) async {
    List<NotesModel> noteList = await DataBase().notesSearched(filter);
    noteSearchedList = noteList;
    return noteList;
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      // This method will be implemented soon
      putSearchTermFirst(term);
      return;
    }
    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }
    // Changes in _searchHistory mean that we have to update the filteredSearchHistory
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  FloatingSearchBarController controller;

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBarWidget(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: UserAppBarWidget(saveEditable: false),
      ),
      body: FloatingSearchBar(
        automaticallyImplyBackButton: false,
        backgroundColor: Colors.white,
        builder: (context, transition) {
          return ClipRRect(
            // Navigator.pushReplacementNamed
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 4,
              child: Builder(
                builder: (context) {
                  if (filteredSearchHistory.isEmpty &&
                      controller.query.isEmpty) {
                    return Container(
                      height: 56,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'Start searching',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    );
                  } else if (filteredSearchHistory.isEmpty) {
                    return ListTile(
                      title: Text(controller.query),
                      leading: const Icon(Icons.search),
                      onTap: () {
                        setState(() {
                          addSearchTerm(controller.query);
                          selectedTerm = controller.query;
                        });
                        controller.close();
                      },
                    );
                  } else {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: filteredSearchHistory
                          .map(
                            (term) => ListTile(
                              title: Text(
                                term,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              leading: const Icon(Icons.history),
                              trailing: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  setState(() {
                                    deleteSearchTerm(term);
                                  });
                                },
                              ),
                              onTap: () {
                                setState(() {
                                  putSearchTermFirst(term);
                                  selectedTerm = term;
                                  getNoteSearched(term);
                                });
                                controller.close();
                              },
                            ),
                          )
                          .toList(),
                    );
                  }
                },
              ),
            ),
          );
        },
        transition: CircularFloatingSearchBarTransition(),
        // Bouncing physics for the search history
        physics: BouncingScrollPhysics(),
        // Title is displayed on an unopened (inactive) search bar
        title: Text(
          selectedTerm ?? 'Search note',
          style: Theme.of(context).textTheme.headline6,
        ),
        // Hint gets displayed once the search bar is tapped and opened
        hint: 'Search and find out...',
        actions: [
          FloatingSearchBarAction.searchToClear(),
        ],
        onQueryChanged: (query) {
          setState(() {
            filteredSearchHistory = filterSearchTerms(filter: query);
            // getNoteSearched(query);
          });
        },
        onSubmitted: (query) {
          setState(() {
            if (query != "") {
              addSearchTerm(query);
              getNoteSearched(query);
            } else {
              Navigator.of(context).pushNamed('/dashboard');
            }
            selectedTerm = query;
          });
          controller.close();
        },
        controller: controller,
        body: SearchResultsListView(
          searchTerm: selectedTerm,
        ),
      ),
    );
  }
}

class SearchResultsListView extends StatelessWidget {
  final String searchTerm;

  const SearchResultsListView({
    Key key,
    @required this.searchTerm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (searchTerm == null || searchTerm == "") {
      return Column(
        children: [
          SizedBox(height: 60.0),
          Expanded(
            child: SizedBox(
                height: MediaQuery.of(context).size.height - 220,
                child: DashBoardPage()),
          ),
        ],
      );
    }

    // final fsb = FloatingSearchBar.of(context);
    if (noteSearchedList != null && noteSearchedList.isNotEmpty) {
      return Column(
        children: [
          SizedBox(
            height: 55,
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            children: List.generate(noteSearchedList.length, (index) {
              return Center(
                child:
                    NoteListWidget(note: noteSearchedList[index], index: index),
              );
            }),
          ),
        ],
      );
    } else
      return Center(
          child: Text(
              "It look like there aren't many great matches for your search",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              textAlign: TextAlign.center));
  }
}
