import 'package:empresta_app_mobile/src/app_module.dart';
import 'package:empresta_app_mobile/src/modules/app/bloc/app_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

const String _initial = "/app";

class MainModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<AppCubit>(() => AppCubit());
  }

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
          ModuleRoute(_initial, module: AppModule()),
        ]);
  }
}
