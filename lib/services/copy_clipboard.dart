import 'package:flutter/services.dart';

import 'custom_toast.dart';

class CopyToClipBoard {
  static void copyToClipBoard(String data) async {
    await Clipboard.setData(
      ClipboardData(text: data),
    ).then((value) async {
      await CustomToast.showCustomToast('Copied to clipboard');
    });
  }
}
