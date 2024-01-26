import 'package:connect_friends/model/users_.dart';
import 'package:flutter/material.dart';

class OtherUserProfile extends StatefulWidget {
  
  final Users selectedUser;
  const OtherUserProfile({Key? key, required this.selectedUser}) : super(key: key);

  @override
  State<OtherUserProfile> createState() => _OtherUserProfileState();
}

class _OtherUserProfileState extends State<OtherUserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        backgroundColor: Color.fromARGB(255, 64, 190, 195),
      ),
      body:  ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    const CircleAvatar(
                      radius: 60.0,
                      child: Icon(Icons.person, size: 20.0,),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      '${widget.selectedUser.name} ${widget.selectedUser.surname}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      widget.selectedUser.email,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        
                      },
                      child: const Text('Add friend'),
                    ),
                  ],
                ),
              ),
            ],
          ),
    );
    
  }
}