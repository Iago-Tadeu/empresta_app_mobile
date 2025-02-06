import 'package:json_annotation/json_annotation.dart';

part "loan_model.g.dart";

@JsonSerializable()
class LoanModel {
  late String name;
  late String type;

  LoanModel({
    required this.name,
    required this.type,
  });

  factory LoanModel.fromJson(Map<String, dynamic> json) =>
      _$LoanModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoanModelToJson(this);
}
