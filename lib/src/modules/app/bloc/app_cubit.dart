import 'package:empresta_app_mobile/src/core/services/loan_service.dart';
import 'package:empresta_app_mobile/src/domain/enums/cubit_state_status_enum.dart';
import 'package:empresta_app_mobile/src/domain/models/agreement_model.dart';
import 'package:empresta_app_mobile/src/domain/models/institution_model.dart';
import 'package:empresta_app_mobile/src/domain/models/loan_offer_model.dart';
import 'package:empresta_app_mobile/src/modules/app/bloc/app_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppCubitState> {
  AppCubit() : super(const AppCubitState()) {
    _update();
  }

  final LoanService _loanService = LoanService.instance;

  late List<InstitutionModel> _institutions = _loanService.institutions;
  late List<AgreementModel> _agreements = _loanService.agreements;
  late final List<LoanOfferModel> _offers = _loanService.offers;

  /// region Public methods

  void simulate(
    double value,
    List<String> institution,
    List<String> agreement,
    int? installment,
  ) async {
    _setLoading();
    final installmentValue = installment ?? 0;

    await _loanService.requestSimulation(
        value, institution, agreement, installmentValue);
    handleEntities();
  }

  void handleEntities() async {
    _setLoading();
    _agreements = await _loanService.getAgreements();
    _update();
  }

  /// endregion Public methods

  /// region Private methods

  void _update() {
    emit(state.copyWith(
      status: CubitStateStatusEnum.initial,
      institutions: _institutions,
      agreements: _agreements,
      offers: _offers,
    ));
  }

  void _setLoading() {
    emit(state.copyWith(
      status: CubitStateStatusEnum.loading,
    ));
  }

  /// endregion Private methods
}
