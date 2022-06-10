import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quidditch_app/services/auth_cubit.dart';
import 'package:quidditch_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static Widget create(BuildContext context) => HomeScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarType1(),
      body: FooterNavBar(),
    );
  }
}
