import "package:json_annotation/json_annotation.dart";

part "agreement_model.g.dart";

@JsonSerializable()
class AgreementModel {
  late String id;
  late String name;
  late String type;
  late String? image;

  AgreementModel({
    this.id = "",
    this.name = "",
    this.type = "",
  });

  factory AgreementModel.fromJson(Map<String, dynamic> json) =>
      _$AgreementModelFromJson(json);

  Map<String, dynamic> toJson() => _$AgreementModelToJson(this);
}
