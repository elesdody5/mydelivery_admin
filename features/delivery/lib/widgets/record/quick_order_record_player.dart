import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class QuickOrderRecordPlayer extends StatefulWidget {
  final String audioUrl;

  const QuickOrderRecordPlayer({Key? key, required this.audioUrl})
      : super(key: key);

  @override
  State<QuickOrderRecordPlayer> createState() => _QuickOrderRecordPlayerState();
}

class _QuickOrderRecordPlayerState extends State<QuickOrderRecordPlayer> {
  final AudioPlayer player = AudioPlayer();
  int position = 0;
  int duration = 0;

  Widget _buildTimer(int recordDuration) {
    final String minutes = _formatNumber(recordDuration ~/ 60);
    final String seconds = _formatNumber(recordDuration % 60);

    return Text(
      '$minutes:$seconds',
      textDirection: TextDirection.ltr,
      style: const TextStyle(fontSize: 12),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }

    return numberStr;
  }

  @override
  void initState() {
    super.initState();
    player.onPositionChanged.listen((position) {
      setState(() {
        this.position = position.inSeconds;
      });
    });
    player.onDurationChanged.listen((duration) {
      setState(() {
        this.duration = duration.inSeconds;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    player.stop();
  }

  @override
  Widget build(BuildContext context) {
    player.play(UrlSource(widget.audioUrl));
    return AlertDialog(
      content: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildTimer(position),
          SizedBox(
            height: 10,
            child: Slider(
                min: 0,
                value: position.toDouble(),
                max: duration.toDouble(),
                onChanged: (_) {}),
          ),
          _buildTimer(duration)
        ],
      ),
    );
  }
}
