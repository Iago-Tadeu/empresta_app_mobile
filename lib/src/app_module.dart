import 'package:empresta_app_mobile/src/modules/app/bloc/app_cubit.dart';
import 'package:empresta_app_mobile/src/modules/app/home/app_home_page.dart';
import 'package:empresta_app_mobile/src/modules/app/loading/app_status_loading_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

const String routeAppLoading = "app$_loading";
const String routeHome = "app$_home";

const String _loading = "/loading";
const String _home = "/home";

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<AppCubit>(() => AppCubit());
  }

  @override
  void routes(r) {
    r.child(
      _loading,
      child: (context) => const AppStatusLoadingPage(),
      transition: TransitionType.noTransition,
    );
    r.child(_home, child: (_) => const AppHomePage());
  }
}