import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:noisie/controller/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with WidgetsBindingObserver {
  final controller = Get.put(PlayerController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("AppLifecycleState: $state");
  }

  // Yêu cầu quyền truy cập bộ nhớ
  Future<PermissionStatus> requestPermission() async {
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    AndroidDeviceInfo android = await plugin.androidInfo;
    final status = await Permission.storage.request();

    print("Android SDK Version: ${android.version.sdkInt}");
    print("Storage Permission Status: $status");

    if (android.version.sdkInt < 33) {
      if (status.isGranted) {
        return PermissionStatus.granted;
      } else if (status.isPermanentlyDenied) {
        print(
            "Storage permission is permanently denied. Opening app settings.");
        await openAppSettings();
      }
    } else {
      return PermissionStatus.granted; // Giả định quyền được cấp cho SDK >= 33
    }
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<PermissionStatus>(
        future: requestPermission(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print("Error requesting permission: ${snapshot.error}");
            return Center(
                child: Text('Lỗi khi yêu cầu quyền: ${snapshot.error}'));
          } else {
            final permissionStatus = snapshot.data;
            print("Final Permission Status: $permissionStatus");
            if (permissionStatus == PermissionStatus.granted) {
              return FutureBuilder<List<SongModel>>(
                future: controller.audioQuery.querySongs(
                  ignoreCase: true,
                  orderType: OrderType.ASC_OR_SMALLER,
                  sortType: null,
                  uriType: UriType.EXTERNAL,
                ),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    print("Error fetching songs: ${snapshot.error}");
                    return Center(
                        child: Text(
                            'Lỗi khi truy vấn bài hát: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    print("No songs found!");
                    return const Center(
                        child: Text("Không tìm thấy bài hát nào!"));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, index) {
                        final song = snapshot.data![index];
                        return FutureBuilder<Uint8List?>(
                          future: controller.audioQuery
                              .queryArtwork(song.id, ArtworkType.AUDIO),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return ListTile(
                                leading: CircularProgressIndicator(),
                                title: Text(song.title ?? ''),
                                subtitle: Text(song.artist ?? ''),
                              );
                            } else if (snapshot.hasError) {
                              return Row(
                                children: [
                                  Icon(Icons.music_note_rounded),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.03,
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                          width: (MediaQuery.of(context)
                                                  .size
                                                  .width) -
                                              50 -
                                              (MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  song.title,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  song.artist ?? '',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.start,
                                                ),
                                              ]))
                                    ],
                                  )
                                ],
                              );
                            } else if (snapshot.hasData &&
                                snapshot.data != null) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.memory(snapshot.data!,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                              width: (MediaQuery.of(context)
                                                      .size
                                                      .width) -
                                                  50 -
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.03),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      song.title,
                                                      style: const TextStyle(
                                                        fontFamily: "Spotify",
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                    Text(
                                                      song.artist ?? '',
                                                      style: const TextStyle(
                                                        fontFamily: "Spotify",
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ]))
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset('assets/images/noise.jpg',
                                          width: 50, height: 50),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: (MediaQuery.of(context)
                                                    .size
                                                    .width) -
                                                50 -
                                                (MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  song.title,
                                                  style: const TextStyle(
                                                    fontFamily: "Spotify",
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.start,
                                                ),
                                                const Text(
                                                  'Unknown Artist',
                                                  style: const TextStyle(
                                                    fontFamily: "Spotify",
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                ],
                              );
                            }
                          },
                        );
                      },
                    );
                  }
                },
              );
            } else if (permissionStatus == PermissionStatus.denied) {
              print("Storage permission denied");
              return Center(child: Text("Quyền truy cập bộ nhớ bị từ chối"));
            } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
              print("Storage permission permanently denied");
              return Center(
                  child: Text(
                      "Quyền truy cập bộ nhớ bị từ chối vĩnh viễn. Vui lòng bật trong cài đặt."));
            }
            return Center(child: Text('Trạng thái quyền: $permissionStatus'));
          }
        },
      ),
    );
  }
}
