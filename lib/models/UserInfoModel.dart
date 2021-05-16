class UserInfoModel {
  String userName = "";
  String image = "";
  int id = 1;

  UserInfoModel({this.userName, this.image});

  Map<String, dynamic> toMap() {
    return {'userName': userName, 'image': image, 'id': 1};
  }
}
