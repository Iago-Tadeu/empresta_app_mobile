import 'package:Empresta_app_mobile/src/domain/models/loan_model.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class CustomDropdownSelection extends StatefulWidget {
  final String title;
  final List<LoanModel> values;
  final void Function(List<LoanModel>) onChanged;

  const CustomDropdownSelection({
    required this.title,
    required this.values,
    required this.onChanged,
    super.key,
  });

  @override
  State<CustomDropdownSelection> createState() =>
      _CustomDropdownSelectionState();
}

class _CustomDropdownSelectionState extends State<CustomDropdownSelection> {
  late List<DropdownItem<LoanModel>> loanItems = widget.values.map((loan) {
    return DropdownItem<LoanModel>(label: loan.name, value: loan);
  }).toList();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MultiDropdown(
        items: loanItems,
        controller: MultiSelectController<LoanModel>(),
        chipDecoration: ChipDecoration(
          borderRadius: BorderRadius.zero,
          labelStyle: TextStyle(color: Colors.orange),
          backgroundColor: Colors.white,
          wrap: true,
        ),
        fieldDecoration: FieldDecoration(
          labelText: widget.title,
          labelStyle: TextStyle(color: Colors.orange),
          hintText: "",
          padding: EdgeInsets.all(8),
          showClearIcon: false,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black),
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
          print("Itens selecionados: $selectedItems");
        },
      ),
    );
  }
}
