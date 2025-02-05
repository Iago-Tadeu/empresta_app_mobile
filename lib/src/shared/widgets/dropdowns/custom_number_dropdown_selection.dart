import 'package:flutter/material.dart';

class CustomNumberDropdownSelection extends StatefulWidget {
  final String title;
  final List<int> values;
  final void Function(int) onChanged;
  final int? value;

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
  late int? _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant CustomNumberDropdownSelection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _currentValue) {
      setState(() {
        _currentValue = widget.value;
      });
    }
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
        value: _currentValue,
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
              _currentValue = newNumber;
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
