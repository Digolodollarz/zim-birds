import 'package:flutter/material.dart';
import 'package:zim_birds/src/models/bird_model.dart';
import 'package:just_audio/just_audio.dart';

class AudioPage extends StatefulWidget {
  final List<Recording> files;

  const AudioPage({Key? key, required this.files}) : super(key: key);

  @override
  _AudioPageState createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  late AudioPlayer player;
  Recording? playing;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: player.playerStateStream,
        builder: (context, AsyncSnapshot<PlayerState> snapshot) {
          final playerState = snapshot.data;
          return Container(
            child: ListView.builder(
              itemBuilder: (context, pos) => AudioCard(
                recording: widget.files[pos],
                audioPlayer: player,
                onPlay: () => this.playing = widget.files[pos],
                isPlaying: this.playing == widget.files[pos]
                    ? playerState?.playing
                    : false,
                isLoading: this.playing == widget.files[pos]
                    ? playerState?.processingState == ProcessingState.loading ||
                        playerState?.processingState ==
                            ProcessingState.buffering
                    : false,
              ),
              itemCount: widget.files.length,
            ),
          );
        });
  }
}

class AudioCard extends StatefulWidget {
  final Recording recording;
  final AudioPlayer audioPlayer;

  final Function onPlay;
  final bool? isLoading;
  final bool? isPlaying;

  const AudioCard({
    Key? key,
    required this.recording,
    required this.audioPlayer,
    required this.onPlay,
    this.isLoading,
    this.isPlaying,
  }) : super(key: key);

  @override
  _AudioCardState createState() => _AudioCardState();
}

class _AudioCardState extends State<AudioCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.red,
      onTap: (widget.isPlaying ?? false)
          ? () => widget.audioPlayer.pause()
          : () async {
              widget.onPlay();
              await widget.audioPlayer
                  .setUrl('https:${widget.recording.url}/download');
              widget.audioPlayer.play();
            },
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Theme.of(context).primaryColor)),
            child: (widget.isPlaying ?? false)
                ? Icon(Icons.pause_outlined)
                : (widget.isLoading ?? false)
                    ? CircularProgressIndicator()
                    : Icon(Icons.play_arrow_outlined),
            width: 48,
            height: 48,
          ),
        ],
      ),
      title: Image.network(
        'https:${widget.recording.sono?.med}',
        height: 64,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
