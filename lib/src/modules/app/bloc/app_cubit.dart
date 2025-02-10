import 'dart:async';

import 'package:empresta_app_mobile/src/core/services/loan_service.dart';
import 'package:empresta_app_mobile/src/domain/enums/cubit_state_status_enum.dart';
import 'package:empresta_app_mobile/src/domain/models/agreement_model.dart';
import 'package:empresta_app_mobile/src/domain/models/institution_model.dart';
import 'package:empresta_app_mobile/src/domain/models/loan_offer_model.dart';
import 'package:empresta_app_mobile/src/modules/app/bloc/app_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppCubitState> {
  AppCubit() : super(const AppCubitState()) {
    _init();
  }

  final LoanService _loanService = LoanService.instance;

  late final StreamSubscription<List<InstitutionModel>> _institutionsSubscription;
  late final StreamSubscription<List<AgreementModel>> _agreementsSubscription;
  late final StreamSubscription<List<LoanOfferModel>> _offersSubscription;
  late final StreamSubscription<void> _loadedEntitiesSubscription;

  @override
  Future<void> close() {
    _institutionsSubscription.cancel();
    _agreementsSubscription.cancel();
    _offersSubscription.cancel();
    _loadedEntitiesSubscription.cancel();
    return super.close();
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
  }

  /// endregion Public methods

  /// region Private methods

  void _startListeners() {
    _institutionsSubscription = _loanService.streamInstitutions.listen((institutions) {
      _update();
    });
    _agreementsSubscription = _loanService.streamAgreements.listen((agreements) {
      _update();
    });
    _offersSubscription = _loanService.streamOffers.listen((offers) {
      _update();
    });
    _loadedEntitiesSubscription = _loanService.streamEntities.listen((_) {
      _setProcessed();
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

  void _setProcessed() {
    emit(state.copyWith(
      status: CubitStateStatusEnum.processed,
    ));
  }

  void _init() {
    _startListeners();
    _update();
  }

  /// endregion Private methods
}
