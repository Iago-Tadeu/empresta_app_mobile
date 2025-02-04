import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class CustomInputField extends StatefulWidget {
  final TextEditingController? value;

  const CustomInputField({this.value, super.key});

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  final TextEditingController valueController =
      MoneyMaskedTextController(leftSymbol: "R\$ ", decimalSeparator: ",");

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Flexible(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(
                Radius.circular(2),
              ),
              border: Border.all(color: Colors.red)),
          child: Focus(
              onFocusChange: (focus) {
                setState(() {
                  // onFocus = focus;
                });
              },
              child: Theme(
                  data: ThemeData(
                      inputDecorationTheme: InputDecorationTheme(
                          // labelStyle:
                          )),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: valueController,
                  ))),
        ),
      )),
    );
  }
}
