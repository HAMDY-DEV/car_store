class AuctionModel {
  String title;
  String creatorUid;
  List<String> subscribers;
  List<String> photoUrl;
  String condition;
  String model;
  String description;
  String price;
  String key;
  String highestPrice;
  String selectedDate;
  bool alarm;
  bool cruiseControl;
  bool bluetooth;
  bool frontParkingSensor;

  AuctionModel({
    required this.title,
    required this.highestPrice,
    required this.creatorUid,
    required this.subscribers,
    required this.photoUrl,
    required this.condition,
    required this.model,
    required this.description,
    required this.price,
    required this.key,
    required this.selectedDate,
    required this.alarm,
    required this.cruiseControl,
    required this.bluetooth,
    required this.frontParkingSensor,
  });

  factory AuctionModel.fromJson(Map<String, dynamic> data) {
    return AuctionModel(
      title: data['title'] ?? '',
      highestPrice: data['highestPrice'] ?? '',
      creatorUid: data['creatorUid'] ?? '',
      subscribers: List<String>.from(data['subscribers'] ?? []),
      photoUrl: List<String>.from(data['photoUrl'] ?? []),
      condition: data['condition'] ?? '',
      model: data['model'] ?? '',
      description: data['description'] ?? '',
      price: data['price'] ?? '',
      key: data['key'] ?? '',
      selectedDate: data['selectedDate'] ?? '',
      alarm: data['alarm'] ?? false,
      cruiseControl: data['cruiseControl'] ?? false,
      bluetooth: data['bluetooth'] ?? false,
      frontParkingSensor: data['frontParkingSensor'] ?? false,
    );
  }
}
