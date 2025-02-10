import 'package:empresta_app_mobile/src/domain/models/loan_model.dart';

class InstitutionModel extends LoanModel {
  late String id;

  InstitutionModel(
      {required this.id, required super.name, required super.type});
}
