import 'package:empresta_app_mobile/src/app_module.dart';
import 'package:empresta_app_mobile/src/modules/app/bloc/app_cubit.dart';
import 'package:empresta_app_mobile/src/modules/app/bloc/app_cubit_state.dart';
import 'package:empresta_app_mobile/src/shared/widgets/dropdowns/custom_dropdown_selection.dart';
import 'package:empresta_app_mobile/src/shared/widgets/forms/custom_check_selection_field.dart';
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
  final TextEditingController valueController = TextEditingController();

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
                CustomInputField(value: valueController,),
                // CustomCheckSelectionField(value: "1", values: ["1", "2", "3"]),
                CustomDropdownSelection(value: 0, values: [12,36]),
                // SizedBox(
                //   height: 70,
                //   child: Flexible(
                //       child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: DecoratedBox(
                //       decoration: BoxDecoration(
                //           color: Colors.transparent,
                //           borderRadius: BorderRadius.all(
                //             Radius.circular(2),
                //           ),
                //           border: Border.all(color: Colors.red)),
                //       child: Focus(
                //           onFocusChange: (focus) {
                //             setState(() {
                //               // onFocus = focus;
                //             });
                //           },
                //           child: Theme(
                //               data: ThemeData(
                //                   inputDecorationTheme:
                //                       InputDecorationTheme(
                //                           // labelStyle:
                //                           )),
                //               child: TextFormField(
                //                 keyboardType: TextInputType.number,
                //                 controller: valueController,
                //               ))),
                //     ),
                //   )),
                // ),
                SizedBox(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                            Colors.orange),
                      ),
                      child: const Text("Simular"),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );
    });
  }
}
