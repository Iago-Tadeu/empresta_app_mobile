import 'dart:async';

import 'package:empresta_app_mobile/src/core/services/loan_service.dart';
import 'package:empresta_app_mobile/src/domain/enums/cubit_state_status_enum.dart';
import 'package:empresta_app_mobile/src/domain/models/agreement_model.dart';
import 'package:empresta_app_mobile/src/domain/models/institution_model.dart';
import 'package:empresta_app_mobile/src/domain/models/loan_offer_model.dart';
import 'package:empresta_app_mobile/src/modules/app/bloc/app_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppCubit extends Cubit<AppCubitState> implements Disposable {
  AppCubit() : super(const AppCubitState()) {
    _init();
  }

  final LoanService _loanService = LoanService.instance;

  late StreamSubscription<List<InstitutionModel>> _institutions;
  late StreamSubscription<List<AgreementModel>> _agreements;
  late StreamSubscription<List<LoanOfferModel>> _offers;

  @override
  void dispose() {
    unawaited(_institutions.cancel());
    unawaited(_agreements.cancel());
    unawaited(_offers.cancel());
  }

  /// region Public methods

  void simulate(
    double value,
    List<String> institution,
    List<String> agreement,
    int? installment,
  ) async {
    final installmentValue = installment ?? 0;
    _setLoading();
    await _loanService.requestSimulation(
        value, institution, agreement, installmentValue);
    _update();
    print("Aqui no cubit");
    print(_offers);
  }

  /// endregion Public methods

  /// region Private methods

  void _startListeners() {
    _institutions = _loanService.streamInstitutions.listen((institutions) {
      _update();
    });
    _agreements = _loanService.streamAgreements.listen((agreements) {
      _update();
    });
    _offers = _loanService.streamOffers.listen((offers) {
      _update();
    });
  }

  void _update() {
    emit(state.copyWith(
      status: CubitStateStatusEnum.initial,
      institutions: _loanService.institutions,
      agreements: _loanService.agreements,
      offers: _loanService.offers,
    ));
  }

  void _setLoading() {
    emit(state.copyWith(
      status: CubitStateStatusEnum.loading,
    ));
  }

  void _init() {
    _startListeners();
    _update();
  }

  /// endregion Private methods
}
