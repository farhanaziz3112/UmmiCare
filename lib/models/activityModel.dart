class activityModel {
  final String activityId;
  final String parentId;
  final String childId;
  final String activityTitle;
  final String activityDescription;
  final String type;
  final String createdAt;

  activityModel(
      {required this.activityId,
      required this.parentId,
      required this.childId,
      required this.activityTitle,
      required this.activityDescription,
      required this.type,
      required this.createdAt});
}
