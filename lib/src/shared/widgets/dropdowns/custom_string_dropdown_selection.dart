import 'package:flutter/material.dart';

class CustomStringDropdownSelection extends StatefulWidget {
  final String title;
  final String value;
  final List<String> values;
  final void Function(String) onChanged;

  const CustomStringDropdownSelection({
    required this.title,
    required this.value,
    required this.values,
    required this.onChanged,
    super.key,
  });

  @override
  State<CustomStringDropdownSelection> createState() =>
      _CustomStringDropdownSelectionState();
}

class _CustomStringDropdownSelectionState extends State<CustomStringDropdownSelection> {
  late String _currentValue;

  @override
  void initState() {
    _currentValue = widget.value;

    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomStringDropdownSelection oldWidget) {
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
      child: DropdownButtonFormField<String>(
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
        value: _currentValue.isNotEmpty ? _currentValue : null,
        items: widget.values.map((String valueOption) {
          return DropdownMenuItem<String>(
            value: valueOption,
            child: Text(
              valueOption,
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          if (newValue != null) {
            setState(() {
              _currentValue = newValue;
            });
            widget.onChanged(newValue);
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
