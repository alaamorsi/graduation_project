class AttachmentModel {
  late String file;
  late String description;

  AttachmentModel.fromJson(Map<String, dynamic> json) {
    file = json["url"]??'';
    description = json["description"]??'';
  }
}