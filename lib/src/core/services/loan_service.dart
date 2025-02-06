import 'dart:async';

import 'package:Empresta_app_mobile/src/core/helpers/response_status_helper.dart';
import 'package:Empresta_app_mobile/src/core/repositories/loan_repository.dart';
import 'package:Empresta_app_mobile/src/domain/models/agreement_model.dart';
import 'package:Empresta_app_mobile/src/domain/models/institution_model.dart';
import 'package:Empresta_app_mobile/src/domain/models/loan_offer_model.dart';


class LoanService {
  LoanService._internal();

  static final LoanService _instance = LoanService._internal();

  static LoanService get instance => _instance;

  static bool _hasInit = false;

  final LoanRepository _loanRepository = LoanRepository();

  final StreamController<List<InstitutionModel>> _streamControllerInstitutions =
      StreamController<List<InstitutionModel>>.broadcast();
  final StreamController<List<AgreementModel>> _streamControllerAgreements =
      StreamController<List<AgreementModel>>.broadcast();
  final StreamController<List<LoanOfferModel>> _streamControllerOffers =
      StreamController<List<LoanOfferModel>>.broadcast();

  late List<InstitutionModel> _institutions = [];
  late List<AgreementModel> _agreements = [];
  late List<LoanOfferModel> _offers = [];

  List<InstitutionModel> get institutions => _institutions;
  List<AgreementModel> get agreements => _agreements;
  List<LoanOfferModel> get offers => _offers;

  Stream<List<InstitutionModel>> get streamInstitutions =>
      _streamControllerInstitutions.stream;
  Stream<List<AgreementModel>> get streamAgreements =>
      _streamControllerAgreements.stream;
  Stream<List<LoanOfferModel>> get streamOffers =>
      _streamControllerOffers.stream;

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

  Future<void> getAgreements() async {
    final ResponseStatusHelper payload = await _loanRepository.getAgreements();

    switch (payload) {
      case Success():
        _agreements = payload.data;
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

  Future<void> requestSimulation(
    double value,
    List<String> institution,
    List<String> agreement,
    int installment,
  ) async {
    final ResponseStatusHelper data = await _loanRepository.simulationRequest(
      value,
      institution,
      agreement,
      installment,
    );

    switch (data) {
      case Success():
        _offers = data.data;
        print("Simulação bem-sucedida: ${data.data}");
        break;
      case Failure():
        print("Erro: ${data.error}");
        break;
      case Loading():
        print("Carregando...");
        break;
    }
    _updateStream();
    print("Passou aqui no update stream ${_offers.length}");
  }

  void _init() {
    getAgreements();
    getInstitutions();
  }

  void _updateStream() {
    _streamControllerInstitutions.sink.add(_institutions);
    _streamControllerAgreements.sink.add(_agreements);
    _streamControllerOffers.sink.add(_offers);
  }
}
