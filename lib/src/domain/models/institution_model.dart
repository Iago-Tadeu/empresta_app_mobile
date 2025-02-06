import "package:empresta_app_mobile/src/domain/models/loan_model.dart";
import "package:json_annotation/json_annotation.dart";

part "institution_model.g.dart";

@JsonSerializable()
class InstitutionModel extends LoanModel {
  late String id;
  late String? image;

  InstitutionModel({
    required this.id,
    required super.name,
    required super.type,
    this.image,
  });

  @override
  factory InstitutionModel.fromJson(Map<String, dynamic> json) =>
      _$InstitutionModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$InstitutionModelToJson(this);
}
