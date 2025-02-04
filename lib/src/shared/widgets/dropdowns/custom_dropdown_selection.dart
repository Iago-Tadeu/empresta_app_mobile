import 'package:flutter/material.dart';

class CustomDropdownSelection extends StatefulWidget {
  final int? value;
  final List<int> values;

  const CustomDropdownSelection({
    super.key,
    this.value,
    required this.values,
  });

  @override
  State<CustomDropdownSelection> createState() =>
      _CustomDropdownSelectionState();
}

class _CustomDropdownSelectionState extends State<CustomDropdownSelection> {
  late int? _currentValue;

  @override
  void initState() {
    if(widget.values.contains(widget.value)){
    _currentValue = widget.value;

    }else{_currentValue = null;}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      decoration: InputDecoration(
        labelText: "Quantidade de parcelas",
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
      value: _currentValue,
      items: widget.values.toSet().map((int installment) {
        return DropdownMenuItem<int>(
          value: installment,
          child: Text(
            installment.toString(),
          ),
        );
      }).toList(),
      onChanged: (newInstallment) {
        setState(() {
          _currentValue = newInstallment!;
        });
      },
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.orange,
      ),
      dropdownColor: Colors.white,
    );
  }
}
