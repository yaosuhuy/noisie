import 'package:flutter/material.dart';

class LabelSection extends StatelessWidget {
  final String title;
  const LabelSection({
    super.key,
    required this.title,
  });

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
      ],
    );
  }
}
