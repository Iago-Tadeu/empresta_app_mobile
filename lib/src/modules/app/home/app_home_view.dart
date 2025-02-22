import 'package:empresta_app_mobile/src/domain/enums/cubit_state_status_enum.dart';
import 'package:empresta_app_mobile/src/domain/models/loan_model.dart';
import 'package:empresta_app_mobile/src/domain/models/loan_offer_model.dart';
import 'package:empresta_app_mobile/src/modules/app/bloc/app_cubit.dart';
import 'package:empresta_app_mobile/src/modules/app/bloc/app_cubit_state.dart';
import 'package:empresta_app_mobile/src/shared/widgets/buttons/custom_simple_text_button.dart';
import 'package:empresta_app_mobile/src/shared/widgets/dialog/custom_dialog.dart';
import 'package:empresta_app_mobile/src/shared/widgets/dropdowns/custom_dropdown_selection.dart';
import 'package:empresta_app_mobile/src/shared/widgets/dropdowns/custom_number_dropdown_selection.dart';
import 'package:empresta_app_mobile/src/shared/widgets/forms/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:gap/gap.dart';

class AppHomeView extends StatefulWidget {
  const AppHomeView({super.key});

  @override
  State<AppHomeView> createState() => _AppHomeViewState();
}

class _AppHomeViewState extends State<AppHomeView> {
  late ValueNotifier valueController = ValueNotifier(null);
  late ValueNotifier<int?> installmentController = ValueNotifier(null);
  final GlobalKey<FormState> simulationFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    installmentController.dispose();
    valueController.dispose();
    super.dispose();
  }

  late List<LoanOfferModel> offers = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppCubitState>(builder: (context, state) {
      handleState(state);
      return Stack(children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.orange,
            ),
            title: Text(
              "Simulador App",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.orange,
          ),
          body: ColoredBox(
            color: Colors.white,
            child: Column(
              children: [
                Form(
                  key: simulationFormKey,
                  child: Column(
                    children: [
                      Gap(12),
                      CustomInputField(
                        valueAmount: valueController,
                      ),
                      CustomNumberDropdownSelection(
                        title: "Quantidade de parcelas",
                        onChanged: (installment) =>
                            installmentController.value = installment,
                        value: installmentController,
                        values: [0, 36, 48, 60, 72, 84],
                      ),
                      CustomDropdownSelection(
                        title: "Instituições",
                        onChanged: (institutions) => context
                            .read<AppCubit>()
                            .updateSelectedInstitutions(institutions),
                        values: state.institutions as List<LoanModel>,
                        selectedValues: state.selectedInstitutions,
                      ),
                      CustomDropdownSelection(
                        title: "Convênios",
                        onChanged: (agreements) => context
                            .read<AppCubit>()
                            .updateSelectedAgreements(agreements),
                        values: state.agreements as List<LoanModel>,
                        selectedValues: state.selectedAgreements,
                      ),
                      CustomSimpleTextButton(
                          text: "SIMULAR",
                          onPressed: () {
                            handleSimulation(state.selectedInstitutions,
                                state.selectedAgreements);
                          }),
                    ],
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: offers.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 2,
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: ListTile(
                                  leading: Image.asset(
                                    'assets/images/${offers[index].bank.toLowerCase()}.png',
                                    width: 40,
                                  ),
                                  title: Text(
                                    "R\$ ${offers[index].simulatedAmount.toStringAsFixed(2)} - ${offers[index].installments}x R\$ ${offers[index].installmentAmount.toStringAsFixed(2)}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                      "${offers[index].bank} (${offers[index].agreement}) - ${offers[index].rate}%"),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        if (state.status == CubitStateStatusEnum.loading)
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.5),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
      ]);
    });
  }

  void handleSimulation(List<LoanModel>? filteredInstitutions,
      List<LoanModel>? filteredAgreements) {
    if (!simulationFormKey.currentState!.validate() ||
        valueController.value == 0.0 ||
        valueController.value == null) {
      customDialog(
          context, "Preencha um valor", "Insira um valor para simular.");
      return;
    }

    late List<String> institutionNames = filteredInstitutions != null
        ? filteredInstitutions.map((institution) => institution.name).toList()
        : [];

    late List<String> agreementNames = filteredAgreements != null
        ? filteredAgreements.map((agreement) => agreement.name).toList()
        : [];

    Modular.get<AppCubit>().simulate(
      valueController.value,
      institutionNames,
      agreementNames,
      installmentController.value,
    );
    setState(() {});
  }

  void handleState(AppCubitState state) {
    offers = state.offers ?? offers;
  }
}
