import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadball_manager/services/auth_cubit.dart';
import 'package:email_validator/email_validator.dart';
import 'package:quadball_manager/widgets/widgets.dart';

class EmailSigninScreen extends StatefulWidget {
  EmailSigninScreen({Key? key}) : super(key: key);
  static Widget create(BuildContext context) => EmailSigninScreen();
  @override
  State<EmailSigninScreen> createState() => _EmailSigninScreenState();
}

class _EmailSigninScreenState extends State<EmailSigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "This is a required field.";
    }
    bool isValid = EmailValidator.validate(_emailController.text);
    if (!isValid) {
      return "This email not is valid.";
    }
  }

  String? pwdValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "This is a required field.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sing In Account"),
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
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Center(
                      child: ButtonLogin(
                        textButton: "Login",
                        iconButton: Icons.login,
                        colorButton: Theme.of(context).primaryColor,
                        colorText: Colors.white,
                        onTap: () {
                          if (_formKey.currentState?.validate() == true) {
                            context.read<AuthCubit>().signInUserWithEmailPwd(
                                _emailController.text, _pwdController.text);
                          }
                        },
                      ),
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
