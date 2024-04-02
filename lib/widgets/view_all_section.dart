import 'package:flutter/material.dart';

class ViewAllSection extends StatelessWidget {
  final String title;
  final String buttonTitle;
  final VoidCallback onPressed;
  const ViewAllSection(
      {super.key,
      this.buttonTitle = "View All",
      required this.title,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Spotify',
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonTitle,
            style: TextStyle(
              fontFamily: "Spotify",
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
