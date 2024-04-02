import 'package:flutter/material.dart';

class RecentlyPlayedCell extends StatelessWidget {
  final Map mObj;
  const RecentlyPlayedCell({super.key, required this.mObj});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 170,
      // margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Image.asset(mObj["image"],
                width: 150, height: 150, fit: BoxFit.cover),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Text(
            mObj["name"],
            maxLines: 1,
            style: TextStyle(
              fontFamily: "Spotify",
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            mObj["artists"],
            maxLines: 1,
            style: TextStyle(
              fontFamily: "Spotify",
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
    ;
  }
}
