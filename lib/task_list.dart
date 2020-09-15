
import 'dart:async';

import 'package:flutter/services.dart';

class TaskList {
  static const MethodChannel _channel =
      const MethodChannel('task_list');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
