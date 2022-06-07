import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quidditch_app/services/auth_cubit.dart';

class SettingsUserScreen extends StatelessWidget {
  const SettingsUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () => context.read<AuthCubit>().signOut(),
                    child: const Text("Logout"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
