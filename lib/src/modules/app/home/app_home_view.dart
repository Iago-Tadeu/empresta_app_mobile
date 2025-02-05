import 'package:empresta_app_mobile/src/app_module.dart';
import 'package:empresta_app_mobile/src/modules/app/bloc/app_cubit.dart';
import 'package:empresta_app_mobile/src/modules/app/bloc/app_cubit_state.dart';
import 'package:empresta_app_mobile/src/shared/widgets/buttons/custom_simple_text_button.dart';
import 'package:empresta_app_mobile/src/shared/widgets/dropdowns/custom_string_dropdown_selection.dart';
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
  late TextEditingController valueController = TextEditingController();
  late ValueNotifier installmentController = ValueNotifier(36);
  late TextEditingController institutionController = TextEditingController();
  late TextEditingController agreementController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppCubitState>(buildWhen: (previous, current) {
      return Modular.to.path == routeHome;
    }, builder: (context, state) {
      return Scaffold(
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
            Column(
              children: [
                CustomInputField(
                  value: valueController,
                ),
                CustomNumberDropdownSelection(
                  title: "Quantidade de parcelas",
                  onChanged: (installment) {
                    setState(() {
                      installmentController.value = installment;
                    });
                  },
                  value: installmentController.value,
                  values: [36, 48, 60, 72, 84],
                ),
                CustomStringDropdownSelection(
                  title: "Instituições",
                  onChanged: (institution) {
                    institutionController.text = institution;
                  },
                  value: institutionController.text,
                  values: ["Um", "Dois"],
                ),
                CustomStringDropdownSelection(
                  title: "Convênios",
                  onChanged: (agreement) {
                    agreementController.text = agreement;
                  },
                  value: agreementController.text,
                  values: ["Novo", "Velho"],
                ),
                CustomSimpleTextButton(text: "SIMULAR", onPressed: () {})
              ],
            ),
          ],
        ),
      );
    });
  }
}
