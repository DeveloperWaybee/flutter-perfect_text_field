import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'perfect_text_field_platform_interface.dart';

/// An implementation of [PerfectTextFieldPlatform] that uses method channels.
class MethodChannelPerfectTextField extends PerfectTextFieldPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('perfect_text_field');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
