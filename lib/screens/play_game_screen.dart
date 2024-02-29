import 'package:flutter/material.dart';
import 'package:quadball_manager/widgets/widgets.dart';

class PlayGameScreen extends StatelessWidget {
  const PlayGameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MantenimentView(),
    );
  }
}
