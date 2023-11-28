import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'perfect_text_field_method_channel.dart';

abstract class PerfectTextFieldPlatform extends PlatformInterface {
  /// Constructs a PerfectTextFieldPlatform.
  PerfectTextFieldPlatform() : super(token: _token);

  static final Object _token = Object();

  static PerfectTextFieldPlatform _instance = MethodChannelPerfectTextField();

  /// The default instance of [PerfectTextFieldPlatform] to use.
  ///
  /// Defaults to [MethodChannelPerfectTextField].
  static PerfectTextFieldPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PerfectTextFieldPlatform] when
  /// they register themselves.
  static set instance(PerfectTextFieldPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
