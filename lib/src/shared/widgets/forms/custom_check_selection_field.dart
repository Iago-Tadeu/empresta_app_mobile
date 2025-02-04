import 'package:flutter/material.dart';

class CustomCheckSelectionField extends StatefulWidget {
  final String title;
  final String value;
  final List<String> values;
  final Function(String)? onChange;
  final double height;

  const CustomCheckSelectionField({
    super.key,
    this.title = "",
    required this.value,
    required this.values,
    this.onChange,
    this.height = 70,
  });

  @override
  State<CustomCheckSelectionField> createState() =>
      _CustomCheckSelectionFieldState();
}

class _CustomCheckSelectionFieldState extends State<CustomCheckSelectionField> {
  late String selected = widget.values.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: widget.height),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.height / 2),
        border: Border.all(color: Colors.blueGrey, width: 1),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: buildValuesSection(),
          ),
        ],
      ),
    );
  }

  Widget buildValuesSection() {
    final List<Widget> widgets = [];
    for (final option in widget.values) {
      widgets.add(buildValue(option));
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.height / 2),
        border: Border.all(
          color: Colors.purple,
          width: 1,
        ),
        color: Colors.lightGreenAccent,
      ),
      child: Row(
        children: widgets,
      ),
    );
  }

  Widget buildValue(String status) {
    final bool isSelected = widget.value == status;
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(widget.height / 2),
            onTap: () {
              onChange(status);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: widget.height / 4),
              decoration: isSelected
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.height / 2),
                      border: Border.all(color: Colors.red, width: 1),
                      color: Colors.blueGrey,
                    )
                  : null,
              child: Text(
                status,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onChange(String status) {
    if (widget.onChange != null) {
      setState(() {
        selected = status;
      });
      widget.onChange!(selected);
    }
  }
}
