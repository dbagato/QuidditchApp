import 'package:flutter/material.dart';

class MantenimentView extends StatelessWidget {
  const MantenimentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'This page is under maintenance, please wait for the administrators to correct this page...',
          textAlign: TextAlign.center,
          style: Theme.of(context).primaryTextTheme.bodyLarge,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
