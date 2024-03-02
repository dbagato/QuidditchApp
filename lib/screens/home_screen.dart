import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadball_manager/services/userLoc_cubit.dart';
import 'package:quadball_manager/services/userloc_repository.dart';
import 'package:quadball_manager/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static Widget create(BuildContext context) {
    return BlocProvider(
      create: (_) => UserLocCubit(UserLocRepository())..getUserLoc(),
      child: const HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarType1(),
      body: const FooterNavBar(),
    );
  }
}
