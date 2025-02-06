import "package:flutter/material.dart";
import "package:flutter_masked_text2/flutter_masked_text2.dart";

class CustomInputField extends StatefulWidget {
  final ValueNotifier valueAmount;

  const CustomInputField({
    required this.valueAmount,
    super.key,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late MoneyMaskedTextController valueController;

  @override
  void initState() {
    super.initState();
    valueController = MoneyMaskedTextController(
      leftSymbol: "R\$ ",
      decimalSeparator: ",",
      initialValue: widget.valueAmount.value ?? 0.0,
    );

    widget.valueAmount.addListener(() {
      if (widget.valueAmount.value != valueController.numberValue) {
        valueController.updateValue(widget.valueAmount.value ?? 0.0);
      }
    });
  }

  @override
  void dispose() {
    valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: valueController,
        onChanged: (newValue) {
          String cleanedValue =
              newValue.replaceAll(RegExp(r"[^\d,]"), "").replaceAll(",", ".");
          double? parsedValue = double.tryParse(cleanedValue);
          if (parsedValue != null) {
            widget.valueAmount.value = parsedValue;
          }
        },
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
