import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  final String textButton;
  final IconData iconButton;
  final Color colorButton;
  final Color colorText;
  final VoidCallback? onTap;

  const ButtonLogin(
      {Key? key,
      required this.textButton,
      required this.iconButton,
      required this.colorButton,
      required this.colorText,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colorButton,
      elevation: 5,
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(iconButton),
              const SizedBox(width: 15),
              Text(
                textButton,
                style: TextStyle(color: colorText, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
