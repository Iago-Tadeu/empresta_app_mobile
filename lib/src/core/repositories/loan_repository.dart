import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:empresta_app_mobile/src/core/adapters/loan_adapter.dart';
import 'package:empresta_app_mobile/src/core/helpers/response_status_helper.dart';
import 'package:empresta_app_mobile/src/domain/constants/app_constants.dart';
import 'package:empresta_app_mobile/src/domain/models/agreement_model.dart';
import 'package:empresta_app_mobile/src/domain/models/institution_model.dart';
import 'package:empresta_app_mobile/src/domain/models/loan_offer_model.dart';

class LoanRepository {
  final Dio _dio = Dio();

  Future<(ResponseStatusHelper, List<LoanOfferModel>)> simulationRequest(
    double value,
    List<String> institution,
    List<String> agreement,
    int installment,
  ) async {
    late ResponseStatusHelper response = Loading();
    late List<LoanOfferModel> offers = [];

    final String uri = "$kBaseApiUrl/api/simular";
    final Map<String, dynamic> payload = {
      "valor_emprestimo": value,
      "instituicoes": institution,
      "convenios": agreement,
      "parcela": installment,
    };
    print("Aqui o payload");
    print(payload);
    try {
      final result = await _dio.post(uri, data: payload);
      response =
          Success(offers = LoanAdapter.getOffersFromJson(result.data, value));
    } on DioException catch (e) {
      response = Failure(
        message: e.response?.statusMessage ?? "Erro desconhecido",
        statusCode: e.response?.statusCode,
        error: e.error,
      );
    } catch (e) {
      response = Failure(
        message: "Erro inesperado",
        error: e,
      );
    }
    return (response, offers);
  }

  Future<ResponseStatusHelper> getInstitutions() async {
    late ResponseStatusHelper response = Loading();

    final String uri = "$kBaseApiUrl/api/instituicao";

    try {
      final result = await _dio.get(uri);
      print("${result.data is String} OU ${result.data is List}");
      print(result.data);
      final List<Map<String, dynamic>> jsonList =
          List<Map<String, dynamic>>.from(jsonDecode(result.data));
      response = Success(LoanAdapter.getInstitutionsFromList(jsonList));
      // response = Success(LoanAdapter.getInstitutionsFromList(result));
    } on DioException catch (e) {
      response = Failure(
        message: e.response?.statusMessage ?? "Erro desconhecido",
        statusCode: e.response?.statusCode,
        error: e.error,
      );
    } catch (e) {
      response = Failure(
        message: "Erro inesperado",
        error: e,
      );
    }
    return response;
  }

  Future<(ResponseStatusHelper, List<AgreementModel>)> getAgreements() async {
    late ResponseStatusHelper response = Loading();
    late List<AgreementModel> agreements = [];

    final String uri = "$kBaseApiUrl/api/convenio";

    try {
      final result = await _dio.get(uri);
      response =
          Success(agreements = LoanAdapter.getAgreementsFromList(result.data));
    } on DioException catch (e) {
      response = Failure(
        message: e.response?.statusMessage ?? "Erro desconhecido",
        statusCode: e.response?.statusCode,
        error: e.error,
      );
    } catch (e) {
      response = Failure(
        message: "Erro inesperado",
        error: e,
      );
    }
    return (response, agreements);
  }
}
