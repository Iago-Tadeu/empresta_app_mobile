import "package:json_annotation/json_annotation.dart";

part "institution_model.g.dart";

@JsonSerializable()
class InstitutionModel {
  late String id;
  late String name;
  late String type;
  late String? image;

  InstitutionModel({
    this.id = "",
    this.name = "",
    this.type = "",
  });

  factory InstitutionModel.fromJson(Map<String, dynamic> json) =>
      _$InstitutionModelFromJson(json);

  Map<String, dynamic> toJson() => _$InstitutionModelToJson(this);
}
