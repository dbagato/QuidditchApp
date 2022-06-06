import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quidditch_app/services/auth_cubit.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static Widget create(BuildContext context) => HomeScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
        elevation: 5,
      ),
      body: Center(
        child: Column(
          children: [
            BlocBuilder<AuthCubit, AuthState>(
              buildWhen: (previous, current) => current is AuthSignedIn,
              builder: (_, state) {
                final authUser = (state as AuthSignedIn).user;
                return Center(
                  child: Column(
                    children: [
                      const Text("user ID"),
                      const SizedBox(height: 30),
                      ElevatedButton(
                          onPressed: () => context.read<AuthCubit>().signOut(),
                          child: const Text("Logout"))
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: FooterNavBar(),
    );
  }
}
