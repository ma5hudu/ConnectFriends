// import 'package:connect_friends/model/user_view_model.dart';
// import 'package:connect_friends/model/users_.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class SearchUsers extends StatefulWidget {
//   const SearchUsers({Key? key}) : super(key: key);

//   @override
//   State<SearchUsers> createState() => _SearchUsersState();
// }

// class _SearchUsersState extends State<SearchUsers> {
//   TextEditingController _searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Global users",
//           style: Theme.of(context).textTheme.displaySmall,
//         ),
//         backgroundColor: Colors.cyan,
//       ),
//       body: Consumer<UserViewMode>(
//         builder: (context, userModel, child) {
//           if (userModel.users.isEmpty) {
//             userModel.loadUserDetails();
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             List<Users> otherUsers = userModel.users
//                 .where((user) =>
//                     user.uid != FirebaseAuth.instance.currentUser!.uid)
//                 .toList();

//             return Center(
//               child: Column(
//                 children: <Widget>[
//                   SizedBox(
//                     width: 400,
//                     child: TextField(
//                       controller: _searchController,
//                       decoration: const InputDecoration(
//                         hintText: "Search for global user",
//                         prefixIcon: Icon(Icons.person),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20.0),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: otherUsers.length,
//                       itemBuilder: (context, index) {
//                         Users user = otherUsers[index];
//                         return ListTile(
//                           title: Text("${user.name} ${user.surname}"),
//                           // Add other information or actions as needed
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
