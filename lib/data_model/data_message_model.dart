class DataMessageModel {
  DataMessageModel({
    this.id,
    this.userId,
    this.message,
    this.seen,
    this.type,
    this.date,
    this.time,
    this.sendImageByMe=false
  });

  int id;
  int userId;
  dynamic message;
  bool seen;
  String type;
  String date;
  String time;
  bool sendImageByMe;


  factory DataMessageModel.fromJson(Map<String, dynamic> json) => DataMessageModel(
    id: json["id"],
    userId: json["user_id"],
    message: json["message"],
    seen: json["seen"],
    type: json["type"],
    date: json["date"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "message": message,
    "seen": seen,
    "type": type,
    "date": date,
    "time": time,
  };
}

