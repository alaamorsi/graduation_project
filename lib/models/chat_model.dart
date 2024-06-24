class MessageModel {
  late String userName;
  late String sentAt;
  late String content;

  MessageModel.fromJson(Map<String, dynamic> json) {
    userName = json["userName"];
    sentAt = json["sentAt"];
    content = json["message"]??'';
  }
  MessageModel(this.userName, this.sentAt, this.content);
}