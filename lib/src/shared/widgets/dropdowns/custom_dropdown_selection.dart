import 'package:empresta_app_mobile/src/domain/models/loan_model.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class CustomDropdownSelection extends StatefulWidget {
  final String title;
  final List<LoanModel> values;
  final void Function(List<LoanModel>) onChanged;
  final List<LoanModel>? selectedValues;

  const CustomDropdownSelection({
    required this.title,
    required this.values,
    required this.onChanged,
    this.selectedValues,
    super.key,
  });

  @override
  State<CustomDropdownSelection> createState() =>
      _CustomDropdownSelectionState();
}

class _CustomDropdownSelectionState extends State<CustomDropdownSelection> {
  late MultiSelectController<LoanModel> controller;
  late List<DropdownItem<LoanModel>> loanItems;

  @override
  void initState() {
    super.initState();
    loanItems = widget.values.map((loan) {
      return DropdownItem<LoanModel>(label: loan.name, value: loan);
    }).toList();

    controller = MultiSelectController<LoanModel>();
    if (widget.selectedValues != null) {
      controller
          .selectWhere((item) => widget.selectedValues!.contains(item.value));
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MultiDropdown(
        items: loanItems,
        controller: controller,
        chipDecoration: ChipDecoration(
          deleteIcon: Icon(null),
          borderRadius: BorderRadius.circular(8),
          labelStyle: TextStyle(color: Colors.orange),
          backgroundColor: Colors.white,
          wrap: true,
        ),
        fieldDecoration: FieldDecoration(
          labelText: widget.title,
          labelStyle: TextStyle(color: Colors.orange),
          hintText: "",
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          showClearIcon: false,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black54),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.orange),
          ),
        ),
        dropdownItemDecoration: DropdownItemDecoration(
          selectedBackgroundColor: Colors.orange,
          selectedTextColor: Colors.white,
          backgroundColor: Colors.white,
        ),
        onSelectionChange: (selectedItems) {
          widget.onChanged(selectedItems);
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
    );
  }
}
