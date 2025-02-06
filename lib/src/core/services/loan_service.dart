import 'dart:async';

import 'package:empresta_app_mobile/src/core/helpers/response_status_helper.dart';
import 'package:empresta_app_mobile/src/core/repositories/loan_repository.dart';
import 'package:empresta_app_mobile/src/domain/models/agreement_model.dart';
import 'package:empresta_app_mobile/src/domain/models/institution_model.dart';
import 'package:empresta_app_mobile/src/domain/models/loan_offer_model.dart';

class LoanService {
  LoanService._internal();

  static final LoanService _instance = LoanService._internal();

  static LoanService get instance => _instance;
  static bool _hasInit = false;

  final LoanRepository _loanRepository = LoanRepository();

  final StreamController<List<InstitutionModel>> _streamControllerInstitutions =
      StreamController<List<InstitutionModel>>.broadcast();

  late List<InstitutionModel> _institutions = [];
  late List<AgreementModel> _agreements = [];
  late List<LoanOfferModel> _offers = [];

  List<InstitutionModel> get institutions => _institutions;

  List<AgreementModel> get agreements => _agreements;

  List<LoanOfferModel> get offers => _offers;

  Stream<List<InstitutionModel>> get streamInstitution =>
      _streamControllerInstitutions.stream;

  static Future<void> init() async {
    if (!_hasInit) {
      _hasInit = true;
      _instance._init();
    }
  }

  Future<void> getInstitutions() async {
    final ResponseStatusHelper payload =
        await _loanRepository.getInstitutions();

    switch (payload) {
      case Success():
        _institutions = payload.data;
        print("Simulação bem-sucedida.");
      case Failure():
        print("Erro: ${payload.error}");
        break;
      case Loading():
        print("Carregando...");
        break;
    }
    _updateStream();
  }

  Future<List<AgreementModel>> getAgreements() async {
    final (ResponseStatusHelper, List<AgreementModel>) data =
        await _loanRepository.getAgreements();

    switch (data.$1) {
      case Success():
        _agreements = data.$2;
        print("Simulação bem-sucedida.");
      case Failure():
        print("Erro: ${data.$1}");
        break;
      case Loading():
        print("Carregando...");
        break;
    }
    return data.$2;
  }

  Future<(ResponseStatusHelper, List<LoanOfferModel>)> requestSimulation(
    double value,
    List<String> institution,
    List<String> agreement,
    int installment,
  ) async {
    final (ResponseStatusHelper, List<LoanOfferModel>) data =
        await _loanRepository.simulationRequest(
      value,
      institution,
      agreement,
      installment,
    );

    switch (data.$1) {
      case Success():
        _offers = data.$2;
        print("Simulação bem-sucedida: ${data.$1}");
        break;
      case Failure():
        print("Erro: ${data.$1}");
        break;
      case Loading():
        print("Carregando...");
        break;
    }

    // if (response.$1.status == ResponseStatusEnum.failed) {
    //   NotificationController.alert(response: response.$1);
    // }
    //
    // if (response.$1.status == ResponseStatusEnum.success) {
    // }

    return data;
  }

  void _init() {
    getAgreements();
    getInstitutions();
  }

  void _updateStream() {
    _streamControllerInstitutions.sink.add(_institutions);
  }
}
