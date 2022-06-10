import 'package:flutter/material.dart';

class DescriptionView extends StatelessWidget {
  final String textView;
  final String imagePath;
  final double heightImage;
  final double widthImage;
  const DescriptionView(
      {Key? key,
      required this.textView,
      required this.imagePath,
      required this.heightImage,
      required this.widthImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: heightImage,
            width: widthImage,
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
