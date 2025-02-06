import 'package:empresta_app_mobile/src/domain/models/agreement_model.dart';
import 'package:empresta_app_mobile/src/domain/models/institution_model.dart';
import 'package:empresta_app_mobile/src/domain/models/loan_offer_model.dart';

abstract class LoanAdapter {
  static List<LoanOfferModel> getOffersFromJson(
      Map<String, dynamic> json, double simulatedAmount) {
    final List<LoanOfferModel> offers = [];

    json.forEach((bank, offersList) {
      for (final offerData in offersList) {
        offers.add(getOfferFromMap(offerData, bank, simulatedAmount));
      }
    });

    return offers;
  }

  static LoanOfferModel getOfferFromMap(
      Map<String, dynamic> data, String bank, double simulatedAmount) {
    final offer = LoanOfferModel.fromJson(data);
    return LoanOfferModel(
      rate: offer.rate,
      installments: offer.installments,
      installmentAmount: offer.installmentAmount,
      simulatedAmount: simulatedAmount,
      agreement: offer.agreement,
      bank: bank,
    );
  }

  static List<InstitutionModel> getInstitutionsFromList(
      List<Map<String, dynamic>> jsonList) {
    return jsonList.asMap().entries.map((json) {
      return InstitutionModel(
        id: "${json.key + 1}",
        name: json.value['chave'],
        type: json.value['valor'],
        // image: null,
      );
    }).toList();

    // final List<InstitutionModel> institutions = [];
    // for (final payload in jsonList){
    //   try{
    //     institutions.add(InstitutionModel.fromJson(
    //
    //         id: payload.index;
    //         name: data["chave"];
    //         type: data["valor"];
    //         image: ImageAdapter(data[""]);
    //
    //         );
    //     );
    //   }
    // }
    // return institutions;
  }

  static List<AgreementModel> getAgreementsFromList(List<String> jsonList) {
    return jsonList.map((json) {
      final data = json as Map<String, dynamic>;
      return AgreementModel(
        id: json.hashCode.toString(),
        name: data['chave'] as String,
        type: data['valor'] as String,
        // image: null,
      );
    }).toList();
  }
// static List<InstitutionModel> getInstitutionFromJson(List<String> jsonList) {
// final List<InstitutionModel> institutions = [];
// for (final payload in jsonList){
//   try{
//     institutions.add(InstitutionModel.fromJson(
//
//         id: payload.index;
//         name: data["chave"];
//         type: data["valor"];
//         image: ImageAdapter(data[""]);
//
//         );
//     );
//   }
// }
// return institutions;
// }

//
// static List<Map<String, dynamic>> _parseList(List data) {
//   final List<Map<String, dynamic>> parsedData = [];
//
//   for (final e in data) {
//     parsedData.add(jsonDecode(jsonEncode(e)));
//   }
//
//   return parsedData;
// }
}
