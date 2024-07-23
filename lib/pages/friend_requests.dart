import 'package:connect_friends/model/friend_request_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Requests extends StatefulWidget {
  const Requests({super.key});

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
 

  @override
  void initState(){
    super.initState();
  
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friend Requests'),
        backgroundColor: const Color.fromARGB(255, 64, 190, 195),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: const Icon(Icons.person_rounded),
              title: const Text('Mashudu Mphaphuli'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Accept request',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Decline request',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
