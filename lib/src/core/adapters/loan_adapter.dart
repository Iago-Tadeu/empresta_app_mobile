import 'dart:convert';

import 'package:empresta_app_mobile/src/domain/models/agreement_model.dart';
import 'package:empresta_app_mobile/src/domain/models/institution_model.dart';
import 'package:empresta_app_mobile/src/domain/models/loan_offer_model.dart';

abstract class LoanAdapter {
  static List<LoanOfferModel> getOffersFromJson(
      Map<String, dynamic> json, double simulatedAmount) {
    final List<LoanOfferModel> offers = [];

    json.forEach((bank, offersList) {
      for (final Map<String, dynamic> offerData in offersList) {
        offers.add(getOfferFromMap(offerData, bank, simulatedAmount));
      }
    });

    return offers;
  }

  static LoanOfferModel getOfferFromMap(
      Map<String, dynamic> data, String bank, double simulatedAmount) {
    return LoanOfferModel(
      rate: data["taxa"],
      installments: data["parcelas"],
      installmentAmount: data["valor_parcela"],
      simulatedAmount: simulatedAmount,
      agreement: data["convenio"],
      bank: bank,
    );
  }

  static List<InstitutionModel> getInstitutionsFromData(dynamic data) {
    final List<Map<String, dynamic>> jsonList;
    if (data is String) {
      jsonList = List<Map<String, dynamic>>.from(jsonDecode(data));
    } else {
      jsonList = data;
    }
    return jsonList.asMap().entries.map((json) {
      return InstitutionModel(
        id: "${json.key + 1}",
        name: json.value['chave'],
        type: json.value['valor'],
      );
    }).toList();
  }

  static List<AgreementModel> getAgreementsFromList(dynamic data) {
    final List<Map<String, dynamic>> jsonList;
    if (data is String) {
      jsonList = List<Map<String, dynamic>>.from(jsonDecode(data));
    } else {
      jsonList = data;
    }
    return jsonList.asMap().entries.map((json) {
      return AgreementModel(
        id: "${json.key + 1}",
        name: json.value['chave'],
        type: json.value['valor'],
      );
    }).toList();
  }
}
