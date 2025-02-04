import 'package:empresta_app_mobile/src/domain/enums/cubit_state_status_enum.dart';
import 'package:equatable/equatable.dart';

class AppCubitState extends Equatable {
  final CubitStateStatusEnum status;
  final bool refresh;

  const AppCubitState({
    this.status = CubitStateStatusEnum.initial,
    this.refresh = false,
});

  AppCubitState copyWith({
    CubitStateStatusEnum? status,

}){
    return AppCubitState(status: status ?? this.status,
    refresh: !refresh,);

  }

  @override
  List<Object?> get props => [
    status,
    refresh,
  ];
}