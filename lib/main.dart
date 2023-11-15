import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<int> soundIndices = List.generate(10, (index) => index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Sounds'),
      ),
      body: ListView.builder(
        itemCount: soundIndices.length,
        itemBuilder: (context, index) {
          return CardTile(index: soundIndices[index]);
        },
      ),
    );
  }
}

class CardTile extends StatefulWidget {
  final int index;

  const CardTile({required this.index, Key? key}) : super(key: key);

  @override
  _CardTileState createState() => _CardTileState();
}

class _CardTileState extends State<CardTile> {
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  bool isPlaying = false;

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Tile ${widget.index}'),
        trailing: _buildPlayButton(),
        onTap: () => _playSound(),
      ),
    );
  }

  Widget _buildPlayButton() {
    return isPlaying
        ? IconButton(
            icon: Icon(Icons.stop),
            onPressed: () {
              _assetsAudioPlayer.stop();
              setState(() {
                isPlaying = false;
              });
            },
          )
        : IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () => _playSound(),
          );
  }

  void _playSound() {
    final audioPath = 'assests/music${widget.index}.mp3';

    if (_assetsAudioPlayer.isPlaying.value) {
      _assetsAudioPlayer.stop();
    }

    _assetsAudioPlayer.open(
      Audio(audioPath),
      autoStart: true,
      showNotification: true,
    );

    setState(() {
      isPlaying = true;
    });
  }
}
