import 'package:flutter/material.dart';
import 'package:noisie/controller/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongList extends StatelessWidget {
  final PlayerController controller;
  final Future<List<SongModel>> songListFuture;

  const SongList(
      {Key? key, required this.controller, required this.songListFuture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
      future: songListFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          print(snapshot.error);
          return Center(child: Text("Error fetching songs!"));
        }

        if (snapshot.data!.isEmpty) {
          return Center(child: Text("No songs found!"));
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final song = snapshot.data![index];
            return ListTile(
              leading: Icon(Icons.music_note_outlined),
              title: Text(song.displayNameWOExt ?? ''),
              subtitle: Text("${song.artist ?? ''}"),
              // onTap: () => controller.playSong(song), // Handle song playing on tap
            );
          },
        );
      },
    );
  }
}
