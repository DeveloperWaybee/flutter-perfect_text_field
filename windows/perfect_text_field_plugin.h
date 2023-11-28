#ifndef FLUTTER_PLUGIN_PERFECT_TEXT_FIELD_PLUGIN_H_
#define FLUTTER_PLUGIN_PERFECT_TEXT_FIELD_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace perfect_text_field {

class PerfectTextFieldPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  PerfectTextFieldPlugin();

  virtual ~PerfectTextFieldPlugin();

  // Disallow copy and assign.
  PerfectTextFieldPlugin(const PerfectTextFieldPlugin&) = delete;
  PerfectTextFieldPlugin& operator=(const PerfectTextFieldPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace perfect_text_field

#endif  // FLUTTER_PLUGIN_PERFECT_TEXT_FIELD_PLUGIN_H_
