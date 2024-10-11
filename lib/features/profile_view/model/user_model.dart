class UserModel {
  String name;
  String photoURL;
  String email;
  String phone1;
  String phone2;
  bool company;
  String uid;
  String address;
  List<dynamic> favorites;
  String password;
  String latitude;
  String longitude;
  String isVerified;
  UserModel({
    required this.favorites,
    required this.address,
    required this.name,
    required this.photoURL,
    required this.email,
    required this.phone1,
    required this.phone2,
    required this.company,
    required this.uid,
    required this.password,
    required this.latitude,
    required this.longitude,
    required this.isVerified,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      favorites: json['favorites'] ?? [],
      address: json['address'] ?? '',
      name: json['name'] ?? '',
      photoURL: json['photoURL'] ?? '',
      email: json['email'] ?? '',
      phone1: json['phone1'] ?? '',
      phone2: json['phone2'] ?? '',
      company: json['company'] ?? '',
      uid: json['uid'] ?? '',
      password: json['password'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      isVerified: json['isVerified'] ?? '',
    );
  }
}
