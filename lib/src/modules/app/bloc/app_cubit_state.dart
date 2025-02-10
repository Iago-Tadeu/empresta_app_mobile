import 'package:empresta_app_mobile/src/domain/enums/cubit_state_status_enum.dart';
import 'package:empresta_app_mobile/src/domain/models/agreement_model.dart';
import 'package:empresta_app_mobile/src/domain/models/institution_model.dart';
import 'package:empresta_app_mobile/src/domain/models/loan_model.dart';
import 'package:empresta_app_mobile/src/domain/models/loan_offer_model.dart';
import 'package:equatable/equatable.dart';

class AppCubitState extends Equatable {
  final CubitStateStatusEnum status;
  final List<InstitutionModel>? institutions;
  final List<AgreementModel>? agreements;
  final List<LoanOfferModel>? offers;
  final List<LoanModel>? selectedInstitutions;
  final List<LoanModel>? selectedAgreements;
  final bool refresh;

  const AppCubitState({
    this.status = CubitStateStatusEnum.initial,
    this.institutions,
    this.agreements,
    this.offers,
    this.selectedInstitutions,
    this.selectedAgreements,
    this.refresh = false,
  });

  AppCubitState copyWith({
    CubitStateStatusEnum? status,
    List<InstitutionModel>? institutions,
    List<AgreementModel>? agreements,
    List<LoanOfferModel>? offers,
    List<LoanModel>? selectedInstitutions,
    List<LoanModel>? selectedAgreements,
  }) {
    return AppCubitState(
      status: status ?? this.status,
      institutions: institutions ?? this.institutions ?? [],
      agreements: agreements ?? this.agreements ?? [],
      offers: offers ?? this.offers ?? [],
      selectedInstitutions:
          selectedInstitutions ?? this.selectedInstitutions ?? [],
      selectedAgreements: selectedAgreements ?? this.selectedAgreements ?? [],
      refresh: !refresh,
    );
  }

  @override
  List<Object?> get props => [
        status,
        institutions,
        agreements,
        offers,
        selectedInstitutions,
        selectedAgreements,
        refresh,
      ];
}
