import 'package:dio/dio.dart';
import 'package:empresta_app_mobile/src/core/adapters/loan_adapter.dart';
import 'package:empresta_app_mobile/src/core/helpers/response_status_helper.dart';
import 'package:empresta_app_mobile/src/domain/constants/app_constants.dart';

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
          Success( LoanAdapter.getOffersFromJson(result.data, value));
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
