import "dart:convert";

import "package:empresta_app_mobile/src/domain/models/agreement_model.dart";
import "package:empresta_app_mobile/src/domain/models/institution_model.dart";
import "package:empresta_app_mobile/src/domain/models/loan_offer_model.dart";

abstract class LoanAdapter {
  static List<LoanOfferModel> getOffersFromJson(
      Map<String, dynamic> json, double simulatedAmount) {
    final List<LoanOfferModel> offers = [];

    json.forEach((String bank, offersList) {
      if (offersList is Map<String, dynamic>) {
        offersList.forEach((_, offerData) {
          offers.add(getOfferFromMap(offerData, bank, simulatedAmount));
        });
      } else if (offersList is List<Map<String, dynamic>>) {
        offers.addAll(
            getFilteredOffersFromList(offersList, bank, simulatedAmount));
      } else {
        for (dynamic offerData in offersList) {
          offerData is Map<String, dynamic>
              ? offers.add(getOfferFromMap(offerData, bank, simulatedAmount))
              : offers.addAll(
                  getFilteredOffersFromList(offersList, bank, simulatedAmount));
        }
      }
    });

    return offers;
  }

  static LoanOfferModel getOfferFromMap(
      Map<String, dynamic> data, String bank, double simulatedAmount) {
    return LoanOfferModel(
      rate: data["taxa"].toDouble(),
      installments: data["parcelas"].toInt(),
      installmentAmount: data["valor_parcela"].toDouble(),
      simulatedAmount: simulatedAmount,
      agreement: data["convenio"].toString(),
      bank: bank,
    );
  }

  static List<LoanOfferModel> getFilteredOffersFromList(
      List<Map<String, dynamic>> listOffers,
      String bank,
      double simulatedAmount) {
    return listOffers.map((json) {
      return LoanOfferModel(
        rate: json["taxa"],
        installments: json["parcelas"],
        installmentAmount: json["valor_parcela"],
        simulatedAmount: simulatedAmount,
        agreement: json["convenio"],
        bank: bank,
      );
    }).toList();
  }

  static List<InstitutionModel> getInstitutionsFromData(dynamic data) {
    final List<Map<String, dynamic>> jsonList;

    data is String
        ? jsonList = List<Map<String, dynamic>>.from(jsonDecode(data))
        : jsonList = data;

    return jsonList.asMap().entries.map((json) {
      return InstitutionModel(
        id: "${json.key + 1}",
        name: json.value["chave"],
        type: json.value["valor"],
      );
    }).toList();
  }

  static List<AgreementModel> getAgreementsFromList(dynamic data) {
    final List<Map<String, dynamic>> jsonList;
    data is String
        ? jsonList = List<Map<String, dynamic>>.from(jsonDecode(data))
        : jsonList = data;

    return jsonList.asMap().entries.map((json) {
      return AgreementModel(
        id: "${json.key + 1}",
        name: json.value["chave"],
        type: json.value["valor"],
      );
    }).toList();
  }
}
