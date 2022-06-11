import 'package:flutter/material.dart';
import 'package:quidditch_app/models/models.dart';
import 'package:quidditch_app/screens/profile_screen.dart';

class UsersScreenView extends StatelessWidget {
  final UserLoc userLoc;
  const UsersScreenView({Key? key, required this.userLoc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text("${userLoc.name} ${userLoc.lastName}"),
              subtitle: Text('Age: ${userLoc.age}, Gender: ${userLoc.gender}'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('Delete User'),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
