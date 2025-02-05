import 'dart:async';

import 'package:empresta_app_mobile/src/core/helpers/response_status_helper.dart';
import 'package:empresta_app_mobile/src/core/repositories/loan_repository.dart';
import 'package:empresta_app_mobile/src/domain/models/agreement_model.dart';
import 'package:empresta_app_mobile/src/domain/models/institution_model.dart';

class LoanService {
  LoanService._internal();

  static final LoanService _instance = LoanService._internal();

  static LoanService get instance => _instance;
  static bool _hasInit = false;
  final LoanRepository _loanRepository = LoanRepository();

  // final StreamController<>

  static void init() {
    if (!_hasInit) {
      _hasInit = true;
    }
  }

  Future<(ResponseStatusHelper, InstitutionModel)> getInstitutions() async {
    final (ResponseStatusHelper, InstitutionModel) data =
        await _loanRepository.getInstitutions();

    switch (data.$1) {
      case Success():
        print("Simulação bem-sucedida.");
      case Failure():
        print("Erro: ${data.$1}");
        break;
      case Loading():
        print("Carregando...");
        break;
    }
    return data;
  }

  Future<(ResponseStatusHelper, AgreementModel)> getAgreements() async {
    final (ResponseStatusHelper, AgreementModel) data =
        await _loanRepository.getAgreements();

    switch (data.$1) {
      case Success():
        print("Simulação bem-sucedida.");
      case Failure():
        print("Erro: ${data.$1}");
        break;
      case Loading():
        print("Carregando...");
        break;
    }
    return data;
  }

  Future<ResponseStatusHelper> requestSimulation(
    double value,
    List<String> institution,
    List<String> agreement,
    int installment,
  ) async {
    final ResponseStatusHelper response =
        await _loanRepository.simulationRequest(
      value,
      institution,
      agreement,
      installment,
    );

    switch (response) {
      case Success():
        print("Simulação bem-sucedida: ${response.data}");
        break;
      case Failure():
        print("Erro: ${response.message}");
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

    return response;
  }
}
