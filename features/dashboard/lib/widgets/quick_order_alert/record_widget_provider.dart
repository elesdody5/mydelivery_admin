import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:core/domain/quick_order.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class RecordProvider with ChangeNotifier {
  final record = Record();
  final AudioPlayer player = AudioPlayer();
  bool isRecording = false;
  bool isPlaying = false;
  int recordDuration = 0;
  Timer? _timer;
  final QuickOrder quickOrder;

  RecordProvider({required this.quickOrder}) {
    player.onPositionChanged.listen((duration) {
      recordDuration = duration.inSeconds;
      notifyListeners();
    });
  }

  void startRecord() async {
    if (await record.hasPermission()) {
      final file = await _createLevelFile();
      await record.start(path: file.path);
      recordDuration = 0;
      _startTimer();
      isRecording = true;
      notifyListeners();
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      recordDuration++;
      notifyListeners();
    });
  }

  void stopRecord() async {
    _timer?.cancel();
    String? path = await record.stop();
    if (path != null) {
      print(path);
      quickOrder.recordFile = File(path);
    }
    isRecording = false;
    notifyListeners();
  }

  void startPlayer() {
    if (quickOrder.recordFile?.path != null) {
      player.play(DeviceFileSource(quickOrder.recordFile!.path));
      isPlaying = true;
      notifyListeners();
    }
  }

  void pausePlayer() {
    player.pause();
    isPlaying = false;
    notifyListeners();
  }

  void deleteRecord() {
    quickOrder.recordFile = null;
    recordDuration = 0;
    notifyListeners();
  }

  Future<File> _createLevelFile() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    File file = File('$appDocPath/audio.mp3');
    return await file.create();
  }
}
