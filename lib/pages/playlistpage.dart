import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({Key? key}) : super(key: key);

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  late List<bool> isPlayingList;

  List<Audio> playlist = [
    Audio(
      'assets/1.mp3',
      metas: Metas(
        title: 'Song 1',
      ),
    ),
    Audio(
      'assets/2.mp3',
      metas: Metas(
        title: 'Song 2',
      ),
    ),
    Audio(
      'assets/3.mp3',
      metas: Metas(
        title: 'Song 3',
      ),
    ),
    Audio(
      'assets/4.mp3',
      metas: Metas(
        title: 'Song 4',
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    isPlayingList = List.generate(playlist.length, (index) => false);
  }

  @override
  void dispose() {
    assetsAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playlist'),
      ),
      body: ListView.builder(
        itemCount: playlist.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              title: Text(
                playlist[index].metas.title ?? '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: IconButton(
                icon: Icon(
                  isPlayingList[index] ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () {
                  togglePlayPause(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void playSong(int index) {
    assetsAudioPlayer.stop();
    assetsAudioPlayer.open(
      Playlist(
        audios: playlist,
        startIndex: index,
      ),
      autoStart: true,
      loopMode: LoopMode.playlist,
    );
  }

  void togglePlayPause(int index) {
    if (assetsAudioPlayer.isPlaying.value &&
        assetsAudioPlayer.current.value?.audio == playlist[index]) {
      assetsAudioPlayer.pause();
    } else {
      assetsAudioPlayer.stop();
      assetsAudioPlayer.open(
        Playlist(
          audios: playlist,
          startIndex: index,
        ),
        autoStart: true,
        loopMode: LoopMode.playlist,
      );
    }

    setState(() {
      isPlayingList[index] = !isPlayingList[index];
    });
  }
}
