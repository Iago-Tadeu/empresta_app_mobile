import 'package:dio/dio.dart';
import 'package:empresta_app_mobile/src/core/helpers/response_status_helper.dart';
import 'package:empresta_app_mobile/src/domain/constants/app_constants.dart';
import 'package:empresta_app_mobile/src/domain/models/agreement_model.dart';
import 'package:empresta_app_mobile/src/domain/models/institution_model.dart';

class LoanRepository {
  final Dio _dio = Dio();

  Future<ResponseStatusHelper> simulationRequest(
    double value,
    List<String> institution,
    List<String> agreement,
    int installment,
  ) async {
    late ResponseStatusHelper response = Loading();

    final String uri = "$kBaseApiUrl/api/simular";
    final Map<String, dynamic> payload = {
      "valor": value,
      "instituicoes": institution,
      "convenios": agreement,
      "parcela": installment,
    };

    try {
      final result = await _dio.post(uri, data: payload);
      response = Success(result.data);
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

  Future<(ResponseStatusHelper, InstitutionModel)> getInstitutions() async {
    late ResponseStatusHelper response = Loading();
    late InstitutionModel institutions = InstitutionModel();

    final String uri = "$kBaseApiUrl/api/instituicao";

    try {
      final result = await _dio.get(uri);
      response = Success(institutions = result.data);
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
    return (response, institutions);
  }

  Future<(ResponseStatusHelper, AgreementModel)> getAgreements() async {
    late ResponseStatusHelper response = Loading();
    late AgreementModel agreements = AgreementModel();

    final String uri = "$kBaseApiUrl/api/convenio";

    try {
      final result = await _dio.get(uri);
      response = Success(
          agreements = result.data);
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
