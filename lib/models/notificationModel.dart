
class notificationModel {

  final String notificationId;
  final String parentId;
  final String childId;
  final String type;
  final String title;
  final String description;
  final String status;
  final String createdAt;

  notificationModel({
    required this.notificationId,
    required this.parentId,
    required this.childId,
    required this.type,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt
  });

}