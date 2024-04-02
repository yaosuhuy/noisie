import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:noisie/screen_models/home_screen_model.dart';
import 'package:noisie/widgets/label_section.dart';
import 'package:noisie/widgets/newly_added_cell.dart';
import 'package:noisie/widgets/recently_played_cell.dart';
import 'package:noisie/widgets/title_section.dart';
import 'package:noisie/widgets/view_all_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeScreenModel = Get.put(HomeScreenModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: false,
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Welcome back, Huy!",
                textAlign: TextAlign.left,
                style: GoogleFonts.lato(fontSize: 13),
              ),
              background: const Image(
                image: AssetImage(
                  'assets/images/welcome_background.png',
                ),
                fit: BoxFit.cover,
                alignment: Alignment(2, -0.2),
              ),
            ),
          ),
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.black,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.cast),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.upload_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.mail_outline_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications_outlined),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            0), // Điều chỉnh giá trị để thay đổi độ cong của góc
                      ),
                      elevation: 20,
                      color: HexColor('#3e3e3e'),
                      child: const Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image(
                            width: 50,
                            height: 50,
                            image: AssetImage('assets/images/liked-songs.png'),
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Liked Songs',
                              style: TextStyle(
                                  fontFamily: 'Spotify',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            0), // Điều chỉnh giá trị để thay đổi độ cong của góc
                      ),
                      elevation: 20,
                      color: HexColor('#3e3e3e'),
                      child: const Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image(
                            width: 50,
                            height: 50,
                            image: AssetImage('assets/images/playlists.png'),
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Playlists',
                              style: TextStyle(
                                  fontFamily: 'Spotify',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                )),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ViewAllSection(title: "Recently Played", onPressed: () {}),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.03,
                      height: MediaQuery.of(context).size.width * 0.05),
                  Column(
                    children: [
                      SizedBox(
                        height: 210,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: homeScreenModel.recentlyPlayedArr.length,
                          itemBuilder: ((context, index) {
                            var mObj = homeScreenModel.recentlyPlayedArr[index];
                            return RecentlyPlayedCell(mObj: mObj);
                          }),
                        ),
                      ),
                      // Divider(
                      //   color: Colors.white,
                      //   indent: 20,
                      //   endIndent: 20,
                      // )
                    ],
                  ),
                  LabelSection(title: "Newly Added"),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.03,
                      height: MediaQuery.of(context).size.width * 0.05),
                  Column(
                    children: [
                      SizedBox(
                        height: 210,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: homeScreenModel.newlyAddedArr.length,
                          itemBuilder: ((context, index) {
                            var mObj = homeScreenModel.newlyAddedArr[index];
                            return NewlyAddedCell(mObj: mObj);
                          }),
                        ),
                      ),
                      // Divider(
                      //   color: Colors.white,
                      //   indent: 20,
                      //   endIndent: 20,
                      // )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
