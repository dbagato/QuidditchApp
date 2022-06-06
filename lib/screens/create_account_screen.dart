import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quidditch_app/services/auth_cubit.dart';
import 'package:email_validator/email_validator.dart';

class CreateAccountScreen extends StatefulWidget {
  CreateAccountScreen({Key? key}) : super(key: key);
  static Widget create(BuildContext context) => CreateAccountScreen();
  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();
  final _repeatPwdController = TextEditingController();

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "This is a required field.";
    }
    bool isValid = EmailValidator.validate(_emailController.text);
    if (!isValid) {
      return "This email is not valid.";
    }
  }

  String? pwdValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "This is a required field.";
    }
    if (value.length < 6) {
      return "Password should be at least 6 letters";
    }
    if (_pwdController.text != _repeatPwdController.text) {
      return "Password do not match";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (_, state) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  if (state is AuthSigningIn)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  if (state is AuthError)
                    Text(
                      state.message,
                      style: const TextStyle(color: Colors.red, fontSize: 24),
                    ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "Email...",
                    ),
                    validator: emailValidator,
                    style: Theme.of(context).primaryTextTheme.bodyText2,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _pwdController,
                    decoration: const InputDecoration(
                      labelText: "Password...",
                    ),
                    validator: pwdValidator,
                    style: Theme.of(context).primaryTextTheme.bodyText2,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _repeatPwdController,
                    decoration: const InputDecoration(
                      labelText: "Repeat your Password...",
                    ),
                    validator: pwdValidator,
                    style: Theme.of(context).primaryTextTheme.bodyText2,
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      child: const Text("Create"),
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          context.read<AuthCubit>().createUserWithEmailPwd(
                              _emailController.text, _pwdController.text);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
