import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_list/task_list.dart';

void main() {
  const MethodChannel channel = MethodChannel('task_list');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await TaskList.platformVersion, '42');
  });
}
