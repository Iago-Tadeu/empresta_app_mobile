import 'package:empresta_app_mobile/src/domain/enums/cubit_state_status_enum.dart';
import 'package:empresta_app_mobile/src/modules/app/bloc/app_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppCubitState> {
  AppCubit() : super(const AppCubitState()) {
    _update();
  }

  void _update() {
    emit(state.copyWith(
      status: CubitStateStatusEnum.initial,
    ));
  }
}