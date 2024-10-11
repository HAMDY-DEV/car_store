class ChatModel {
  String key;
  String idCompany;
  String idBuyer;
  String time;
  String message;
  String Sender;
  bool seen;
  bool sent;

  ChatModel({
   required this.key,
   required this.idCompany,
   required this.idBuyer,
   required this.time,
   required this.message,
   required this.Sender,
   required this.seen,
   required this.sent,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      key: json['key'],
      idCompany: json['idCompany'],
      idBuyer: json['idBuyer'],
      time: json['time'],
      message: json['message'],
      Sender: json['Sender'],
      seen: json['seen'],
      sent: json['sent'],
    );
  }
}
