import 'dart:async';

import 'package:empresta_app_mobile/src/core/helpers/response_status_helper.dart';
import 'package:empresta_app_mobile/src/core/repositories/loan_repository.dart';
import 'package:empresta_app_mobile/src/domain/models/agreement_model.dart';
import 'package:empresta_app_mobile/src/domain/models/institution_model.dart';
import 'package:empresta_app_mobile/src/domain/models/loan_offer_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  final StreamController<void> _streamControllerEntities =
      StreamController<void>.broadcast();

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

  Stream<void> get streamEntities => _streamControllerEntities.stream;

  static Future<void> init() async {
    if (!_hasInit) {
      _hasInit = true;
      _instance._init();
    }
  }

  Future<ResponseStatusHelper> getInstitutions() async {
    final ResponseStatusHelper response =
        await _loanRepository.getInstitutions();

    switch (response) {
      case Success():
        _institutions = response.data;
      case Failure():
        Fluttertoast.showToast(
          msg: "Falha ao recuperar dados",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        break;
      case Loading():
        break;
    }
    _updateStream();
    return response;
  }

  Future<ResponseStatusHelper> getAgreements() async {
    final ResponseStatusHelper response = await _loanRepository.getAgreements();

    switch (response) {
      case Success():
        _agreements = response.data;
      case Failure():
        Fluttertoast.showToast(
          msg: "Falha ao recuperar dados",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        break;
      case Loading():
        break;
    }
    _updateStream();
    return response;
  }

  Future<ResponseStatusHelper> requestSimulation(
    double value,
    List<String> institutions,
    List<String> agreements,
    int installments,
  ) async {
    final ResponseStatusHelper response =
        await _loanRepository.simulationRequest(
      value,
      institutions,
      agreements,
      installments,
    );

    switch (response) {
      case Success():
        _offers = response.data;
        Fluttertoast.showToast(
          msg: "Sucesso",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.deepOrange,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        break;
      case Failure():
        Fluttertoast.showToast(
          msg: "Falha ao recuperar dados",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        break;
      case Loading():
        break;
    }
    _updateStream();
    return response;
  }

  Future<void> _init() async {
    await getInstitutions();
    await getAgreements();
    _streamControllerEntities.sink.add(null);
  }

  void _updateStream() {
    _streamControllerInstitutions.sink.add(_institutions);
    _streamControllerAgreements.sink.add(_agreements);
    _streamControllerOffers.sink.add(_offers);
  }
}
