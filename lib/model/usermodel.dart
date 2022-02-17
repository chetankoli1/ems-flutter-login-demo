class UserModel {
  String? name, email, uid, imgUrl, gender;

  UserModel({this.name, this.email, this.uid, this.imgUrl, this.gender});

//sending data
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'gender': gender,
      'uid': uid,
      'imgUrl': imgUrl
    };
  }


//receving data
  factory UserModel.fromMap(map) {
    return UserModel(
      name: map['name'],
      email: map['email'],
      gender: map['gender'],
      imgUrl: map['imgUrl'],
      uid: map['uid'],
    );
  }
}
