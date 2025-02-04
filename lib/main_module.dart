import 'package:empresta_app_mobile/src/app_module.dart';
import 'package:empresta_app_mobile/src/modules/app_status/app_status_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

const String _status = "/status";
const String _initial = "/app";

class MainModule extends Module {
  @override
  void routes(r) {
    r.child("/",
        child: (_) => Column(
              children: [
                Expanded(child: Stack(children: [const RouterOutlet()])),
              ],
            ),
        transition: TransitionType.rightToLeft,
        children: [
          ModuleRoute(_status, module: AppStatusModule()),
          ModuleRoute(_initial, module: AppModule()),
        ]);
    // r.redirect("/", to: _status);
  }
}
