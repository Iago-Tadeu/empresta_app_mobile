import 'package:flutter/material.dart';

class CustomNumberDropdownSelection extends StatefulWidget {
  final String title;
  final List<int> values;
  final void Function(int?) onChanged;
  final ValueNotifier? value;

  const CustomNumberDropdownSelection({
    required this.title,
    required this.values,
    required this.onChanged,
    this.value,
    super.key,
  });

  @override
  State<CustomNumberDropdownSelection> createState() =>
      _CustomNumberDropdownSelectionState();
}

class _CustomNumberDropdownSelectionState
    extends State<CustomNumberDropdownSelection> {
  late ValueNotifier valueController;
  late bool _isExternalNotifier;

  @override
  void initState() {
    super.initState();
    _isExternalNotifier = widget.value != null;
    valueController =
        widget.value ?? ValueNotifier<int?>(null);

    valueController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    if (!_isExternalNotifier) {
      valueController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<int>(
        decoration: InputDecoration(
          labelText: widget.title,
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
        value: valueController.value,
        items: widget.values.toSet().map((int number) {
          return DropdownMenuItem<int>(
            value: number,
            child: Text(
              number.toString(),
            ),
          );
        }).toList(),
        onChanged: (newNumber) {
          if (newNumber != null) {
            setState(() {
              valueController.value = newNumber;
            });
            widget.onChanged(newNumber);
          }
        },
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.orange,
        ),
        dropdownColor: Colors.white,
      ),
    );
  }
}
