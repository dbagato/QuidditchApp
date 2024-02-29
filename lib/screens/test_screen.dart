import 'package:flutter/material.dart';
import 'package:quadball_manager/widgets/widgets.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MantenimentView(),
    );
  }
}
