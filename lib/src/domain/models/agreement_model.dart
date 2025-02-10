import 'package:empresta_app_mobile/src/domain/models/loan_model.dart';

class AgreementModel extends LoanModel {
  String id;

  AgreementModel({required this.id, required super.name, required super.type});
}
