import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'record_widget_provider.dart';

class RecordWidget extends StatelessWidget {
  const RecordWidget({Key? key}) : super(key: key);

  IconButton getIcon(RecordProvider provider) {
    if (provider.isRecording) {
      return IconButton(
        icon: const Icon(
          Icons.stop,
          color: Colors.red,
        ),
        onPressed: provider.stopRecord,
      );
    }
    if (provider.quickOrder.recordFile != null && !provider.isPlaying) {
      return IconButton(
        icon: const Icon(
          Icons.play_arrow_rounded,
          color: Colors.green,
        ),
        onPressed: provider.startPlayer,
      );
    }
    if (provider.isPlaying) {
      return IconButton(
        icon: const Icon(
          Icons.pause,
        ),
        onPressed: provider.pausePlayer,
      );
    }
    return IconButton(
      icon: const Icon(
        Icons.mic,
      ),
      onPressed: provider.startRecord,
    );
  }

  Widget _buildTimer(int recordDuration) {
    final String minutes = _formatNumber(recordDuration ~/ 60);
    final String seconds = _formatNumber(recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      textDirection: TextDirection.ltr,
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }

    return numberStr;
  }

  void _showDeleteAlert(RecordProvider provider) {
    if (provider.quickOrder.recordFile != null) {
      Get.defaultDialog(
        title: "are_you_sure".tr,
        middleText: "want_delete_record".tr,
        confirm: TextButton(
            onPressed: () {
              provider.deleteRecord();
              Get.back();
            },
            child: Text("confirm".tr)),
        cancel:
            TextButton(onPressed: () => Get.back(), child: Text("cancel".tr)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecordProvider>(builder: (_, provider, child) {
      return ListTile(
          leading: getIcon(provider),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTimer(provider.recordDuration),
              IconButton(
                  onPressed: () => _showDeleteAlert(provider),
                  icon: const Icon(Icons.delete))
            ],
          ));
    });
  }
}
