// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:connect_friends/model/friend_request_manager.dart';

// class Requests extends StatefulWidget {
//   const Requests({super.key});

//   @override
//   State<Requests> createState() => _RequestsState();
// }

// class _RequestsState extends State<Requests> {
//   late FriendRequestManager _friendRequestManager;
//   late String? _userId;

//   @override
//   void initState() {
//     super.initState();
//     _friendRequestManager =
//         Provider.of<FriendRequestManager>(context, listen: false);
//     _userId = FirebaseAuth.instance.currentUser?.uid;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Friend Requests'),
//         backgroundColor: const Color.fromARGB(255, 64, 190, 195),
//       ),
//       body: _userId == null
//           ? Center(child: Text('User not logged in'))
//           : FutureBuilder<List<FriendRequest>>(
//               future: _friendRequestManager.fetchFriendRequests(_userId!),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Error loading friend requests.'));
//                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Center(child: Text('No friend requests available.'));
//                 } else {
//                   final friendRequests = snapshot.data!;
//                   return ListView.builder(
//                     itemCount: friendRequests.length,
//                     itemBuilder: (context, index) {
//                       final request = friendRequests[index];
//                       return Card(
//                         child: ListTile(
//                           leading: const Icon(Icons.person_rounded),
//                           title: Text(
//                               '${request.requesterName} ${request.requesterSurname}'),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const SizedBox(height: 4.0),
//                               Row(
//                                 children: [
//                                   ElevatedButton(
//                                     onPressed: () {
//                                       // Handle accept request
//                                     },
//                                     child: const Text(
//                                       'Accept request',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 8.0),
//                                   ElevatedButton(
//                                     onPressed: () {
//                                       // Handle decline request
//                                     },
//                                     child: const Text(
//                                       'Decline request',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//     );
//   }
// }
