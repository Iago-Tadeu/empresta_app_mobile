import 'package:json_annotation/json_annotation.dart';

part 'loan_offer_model.g.dart';

@JsonSerializable()
class LoanOfferModel {
  final double rate;
  final int installments;
  final double simulatedAmount;
  final double installmentAmount;
  final String agreement;
  final String bank;

  LoanOfferModel({
    required this.rate,
    required this.installments,
    required this.simulatedAmount,
    required this.installmentAmount,
    required this.agreement,
    required this.bank,
  });

  factory LoanOfferModel.fromJson(Map<String, dynamic> json) =>
      _$LoanOfferModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoanOfferModelToJson(this);
}
