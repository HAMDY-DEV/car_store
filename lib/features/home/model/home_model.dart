class HomeModel {
  bool alarm;
  bool bluetooth;
  String condition;
  bool cruiseControl;
  bool frontParkingSensor;
  String description;
  String phone;
  String key;
  String model;
  String price;
  String title;
  String userUid;
  List<String> photoUrl;

  HomeModel({
    required this.alarm,
    required this.bluetooth,
    required this.condition,
    required this.cruiseControl,
    required this.frontParkingSensor,
    required this.description,
    required this.key,
    required this.phone,
    required this.model,
    required this.price,
    required this.title,
    required this.userUid,
    required this.photoUrl,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      alarm: json['alarm'],
      bluetooth: json['bluetooth'],
      condition: json['condition'],
      cruiseControl: json['cruiseControl'],
      frontParkingSensor: json['frontParkingSensor'],
      description: json['description'],
      key: json['key'],
      phone: json['phone'],
      model: json['model'],
      price: json['price'],
      title: json['title'],
      userUid: json['userUid'],
      photoUrl: List<String>.from(json['photoUrl']),
    );
  }
}
