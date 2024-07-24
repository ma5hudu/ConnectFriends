

class FriendRequest{

  final String requesterUid;
  final String requesterName;
  final String requesterSurname;
  final String requesterProfilePicture;
  final String receiverUid;
  final String status; // e.g., 'pending', 'accepted', 'rejected'

  FriendRequest({
    required this.requesterUid,
    required this.requesterName,
    required this.requesterSurname,
    required this.requesterProfilePicture,
    required this.receiverUid,
    this.status = 'pending',
  });

   Map<String, Object?> toJson() {
    return {
      'requesterUid': requesterUid,
      'requesterName': requesterName,
      'requesterSurname': requesterSurname,
      'requesterProfilePicture': requesterProfilePicture,
      'receiverUid': receiverUid,
      'status': status,
    };
  }

}