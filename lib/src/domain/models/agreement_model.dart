import "package:empresta_app_mobile/src/domain/models/loan_model.dart";
import "package:json_annotation/json_annotation.dart";

part "agreement_model.g.dart";

@JsonSerializable()
class AgreementModel extends LoanModel {
  String id;

  AgreementModel({required this.id, required super.name, required super.type});

  @override
  factory AgreementModel.fromJson(Map<String, dynamic> json) =>
      _$AgreementModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AgreementModelToJson(this);
}
