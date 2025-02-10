import 'package:dio/dio.dart';
import 'package:empresta_app_mobile/src/core/adapters/loan_adapter.dart';
import 'package:empresta_app_mobile/src/core/helpers/response_status_helper.dart';
import 'package:empresta_app_mobile/src/domain/constants/app_constants.dart';
import 'package:empresta_app_mobile/src/domain/models/loan_offer_model.dart';

class LoanRepository {
  final Dio _dio = Dio();

  Future<ResponseStatusHelper> simulationRequest(
    double value,
    List<String> institutions,
    List<String> agreements,
    int installments,
  ) async {
    late ResponseStatusHelper response = Loading();

    final String uri = "$kBaseApiUrl/api/simular";
    final Map<String, dynamic> payload = {
      "valor_emprestimo": value,
      "instituicoes": institutions,
      "convenios": agreements,
      "parcelas": installments,
    };
    try {
      final result = await _dio.post(uri, data: payload);
      if (result.data != null && result.data.isNotEmpty) {
        response = Success(LoanAdapter.getOffersFromJson(result.data, value));
      } else {
        final List<LoanOfferModel> emptyOffers = [];
        response = Success(emptyOffers);
      }
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

  Future<ResponseStatusHelper> getInstitutions() async {
    late ResponseStatusHelper response = Loading();

    final String uri = "$kBaseApiUrl/api/instituicao";

    try {
      final result = await _dio.get(uri);
      response = Success(LoanAdapter.getInstitutionsFromData(result.data));
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

  Future<ResponseStatusHelper> getAgreements() async {
    late ResponseStatusHelper response = Loading();

    final String uri = "$kBaseApiUrl/api/convenio";

    try {
      final result = await _dio.get(uri);
      response = Success(LoanAdapter.getAgreementsFromList(result.data));
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
}
