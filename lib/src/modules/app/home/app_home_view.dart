import 'package:empresta_app_mobile/src/app_module.dart';
import 'package:empresta_app_mobile/src/core/services/loan_service.dart';
import 'package:empresta_app_mobile/src/domain/models/loan_model.dart';
import 'package:empresta_app_mobile/src/modules/app/bloc/app_cubit.dart';
import 'package:empresta_app_mobile/src/modules/app/bloc/app_cubit_state.dart';
import 'package:empresta_app_mobile/src/shared/widgets/buttons/custom_simple_text_button.dart';
import 'package:empresta_app_mobile/src/shared/widgets/dropdowns/custom_dropdown_selection.dart';
import 'package:empresta_app_mobile/src/shared/widgets/dropdowns/custom_number_dropdown_selection.dart';
import 'package:empresta_app_mobile/src/shared/widgets/forms/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

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

  List<LoanModel>? selectedInstitutions;
  List<LoanModel>? selectedAgreements;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppCubitState>(buildWhen: (previous, current) {
      return Modular.to.path == routeHome;
    }, builder: (context, state) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            // systemNavigationBarColor: Colors.black,
            statusBarColor: Colors.orange,
          ),
          title: Text(
            "Simulador App",
            style: TextStyle(color: Colors.white),
          ),
          // centerTitle: true,
          backgroundColor: Colors.orange,
          surfaceTintColor: Colors.blueGrey,
        ),
        body: Column(
          children: [
            Form(
              key: simulationFormKey,
              child: Column(
                children: [
                  CustomInputField(
                    valueAmount: valueController,
                  ),
                  CustomNumberDropdownSelection(
                    title: "Quantidade de parcelas",
                    onChanged: (installment) =>
                        installmentController.value = installment,
                    value: installmentController,
                    values: [36, 48, 60, 72, 84],
                  ),
                  CustomDropdownSelection(
                    title: "Instituições",
                    onChanged: (institutions) =>
                        selectedInstitutions = institutions,
                    values: state.institutions as List<LoanModel>,
                  ),
                  CustomDropdownSelection(
                    title: "Convênios",
                    onChanged: (agreements) => selectedAgreements = agreements,
                    values: state.agreements as List<LoanModel>,
                  ),
                  CustomSimpleTextButton(
                      text: "SIMULAR",
                      onPressed: () {
                        LoanService.instance.getInstitutions();
                        // handleSimulation();
                      }),
                  SingleChildScrollView(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: state.offers?.length,
                          itemBuilder: (context, index) {
                            final offer = state.offers?[index];
                            return Card(
                              elevation: 2,
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: ListTile(
                                // leading: Image.asset(
                                //   'assets/images/${offer.banco.toLowerCase()}.png',
                                //   width: 40,
                                // ),
                                title: Text(
                                  "R\$ ${offer?.simulatedAmount.toStringAsFixed(2)} - ${offer?.installments}x R\$ ${offer?.installmentAmount.toStringAsFixed(2)}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                    "${offer?.bank} (${offer?.agreement}) - ${offer?.rate}%"),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  void handleSimulation() {
    if (!simulationFormKey.currentState!.validate() ||
        valueController.value == 0.0) {
      print("Preencha o valor solicitado");
      return;
    }
    late List<String> institutionNames =
        selectedInstitutions?.map((institution) => institution.name).toList() ??
            [];

    late List<String> agreementNames =
        selectedAgreements?.map((agreement) => agreement.name).toList() ?? [];

    Modular.get<AppCubit>().simulate(
      valueController.value,
      institutionNames,
      agreementNames,
      installmentController.value,
    );
  }
}
