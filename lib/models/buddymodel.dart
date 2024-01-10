class buddyProfileModel {
  final String buddyProfileId;
  final String buddyProfileUsername;
  final String isPrivate;
  final String buddyProfileImageURL;

  buddyProfileModel(
      {required this.buddyProfileId,
      required this.buddyProfileUsername,
      required this.isPrivate,
      required this.buddyProfileImageURL});
}

class friendModel {
  final String friendModelId;
  final String friendStatus;

  friendModel({
    required this.friendModelId,
    required this.friendStatus
  });

}

class buddyPostModel {
  final String buddyPostId;
  final String buddyProfileId;
  final String buddyPostImageURL;
  final String buddyPostCaption;
  final String isPrivate;
  final String createdAt;

  buddyPostModel(
      {required this.buddyPostId,
      required this.buddyProfileId,
      required this.buddyPostImageURL,
      required this.buddyPostCaption,
      required this.isPrivate,
      required this.createdAt});
}

class friendRequestModel {
  final String friendRequestId;
  final String senderId;
  final String receiverId;
  final String status;

  friendRequestModel(
      {required this.friendRequestId,
      required this.senderId,
      required this.receiverId,
      required this.status});
}
