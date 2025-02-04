import 'package:empresta_app_mobile/src/modules/app_status/loading/app_status_loading_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

const String _loading = "/loading";
const String routeAppLoading = "/status$_loading";

class AppStatusModule extends Module {
  @override
  void routes(r) {
    r.child(
      _loading,
      child: (context) => const AppStatusLoadingPage(),
      transition: TransitionType.noTransition,
    );
  }
}
