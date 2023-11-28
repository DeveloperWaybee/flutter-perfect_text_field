#include "include/perfect_text_field/perfect_text_field_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "perfect_text_field_plugin.h"

void PerfectTextFieldPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  perfect_text_field::PerfectTextFieldPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
