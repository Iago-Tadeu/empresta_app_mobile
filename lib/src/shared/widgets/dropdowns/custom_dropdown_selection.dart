import 'package:empresta_app_mobile/src/domain/models/loan_model.dart';
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
        enabled: true,
        chipDecoration: const ChipDecoration(
          backgroundColor: Colors.grey,
          wrap: true,
        ),
        // searchEnabled: true,
        fieldDecoration: FieldDecoration(
          hintText: widget.title,
          hintStyle: const TextStyle(color: Colors.black),
          showClearIcon: false,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
        ),
        dropdownItemDecoration: const DropdownItemDecoration(
          selectedIcon: Icon(Icons.check_box, color: Colors.black),
        ),
        onSelectionChange: (selectedItems) {
          widget.onChanged(selectedItems);
          print("Itens selecionados: $selectedItems");
        },
      ),
    );

    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: DropdownButtonFormField(
    //     decoration: InputDecoration(
    //       labelText: widget.title,
    //       labelStyle: TextStyle(color: Colors.orange),
    //       border: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(8),
    //         borderSide: BorderSide(color: Colors.orange),
    //       ),
    //       focusedBorder: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(8),
    //         borderSide: BorderSide(color: Colors.orange, width: 2),
    //       ),
    //     ),
    //     value: _currentValue,
    //     items: widget.values.map((LoanModel item) {
    //       return DropdownMenuItem(
    //         value: item,
    //         child: Text(item.name),
    //       );
    //     }).toList(),
    //     onChanged: (newValue) {
    //       if (newValue != null) {
    //         setState(() {
    //           _currentValue = newValue;
    //         });
    //         widget.onChanged(newValue);
    //       }
    //     },
    //     icon: Icon(
    //       Icons.arrow_drop_down,
    //       color: Colors.orange,
    //     ),
    //     dropdownColor: Colors.white,
    //   ),
    // );
  }
}
