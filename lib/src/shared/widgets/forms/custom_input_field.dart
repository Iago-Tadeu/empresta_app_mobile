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
    return Padding(
          padding: const EdgeInsets.all(8.0),
          child:
          TextFormField(
            keyboardType: TextInputType.number,
            controller: valueController,
            decoration: InputDecoration(
              labelText: "valor do empréstimo",
              labelStyle: TextStyle(color: Colors.orange),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.orange),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.orange, width: 2),
              ),
            ),
          ),
        );
  }
}
