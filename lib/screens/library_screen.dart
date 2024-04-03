import 'dart:io';
import 'package:flutter/material.dart';
import 'package:noisie/screen_models/song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final _audioQuery = new OnAudioQuery();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
      future: _audioQuery.querySongs(
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true),
      builder: (context, item) {
        if (item.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (item.data!.isEmpty) {
          return const Center(
            child: Text('No song found!'),
          );
        }
        return ListView.builder(
          itemCount: item.data!.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.music_note_outlined),
              title: Text(item.data![index].displayNameWOExt),
              subtitle: Text(
                item.data![index].artist.toString(),
              ),
            );
          },
        );
      },
    );
  }
}
