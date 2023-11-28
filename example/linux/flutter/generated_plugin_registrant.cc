//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <perfect_text_field/perfect_text_field_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) perfect_text_field_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "PerfectTextFieldPlugin");
  perfect_text_field_plugin_register_with_registrar(perfect_text_field_registrar);
}
