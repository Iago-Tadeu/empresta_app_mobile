import 'package:empresta_app_mobile/src/modules/app/bloc/app_cubit.dart';
import 'package:empresta_app_mobile/src/modules/app/home/app_home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppHomePage extends StatefulWidget {
  const AppHomePage({super.key});

  @override
  State<AppHomePage> createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  final AppCubit cubit = Modular.get<AppCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: cubit,child: const AppHomeView(),);
  }
}
