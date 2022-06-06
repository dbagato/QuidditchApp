import 'package:flutter/material.dart';

class DescriptionView extends StatelessWidget {
  final String textView;
  final String imagePath;

  const DescriptionView(
      {Key? key, required this.textView, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: 200,
            width: 200,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                textView,
                textAlign: TextAlign.center,
                style: Theme.of(context).primaryTextTheme.bodyText1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
