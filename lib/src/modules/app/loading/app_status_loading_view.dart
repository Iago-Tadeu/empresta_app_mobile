import 'package:empresta_app_mobile/src/domain/enums/cubit_state_status_enum.dart';
import 'package:empresta_app_mobile/src/modules/app/bloc/app_cubit.dart';
import 'package:empresta_app_mobile/src/modules/app/bloc/app_cubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;

class AppStatusLoadingView extends StatefulWidget {
  const AppStatusLoadingView({super.key});

  @override
  State<AppStatusLoadingView> createState() => _AppStatusLoadingViewState();
}

class _AppStatusLoadingViewState extends State<AppStatusLoadingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: BlocListener<AppCubit, AppCubitState>(
        listener: (context, state) {
          if (state.status == CubitStateStatusEnum.processed) {
            Modular.to.pushReplacementNamed("/app/home");
            // context.read<AppCubit>().resetState();
          }
        },
        child: Center(
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
                Colors.orange.withValues(alpha: 0.3), BlendMode.plus),
            child: Image.asset(
              "assets/images/like.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
