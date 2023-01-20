import 'package:flutter/material.dart';
import 'dart:convert';


final List<String> ufList = <String>["AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO"];
typedef void StringCallback(String val);

class DropdownButtonWidget extends StatefulWidget {

  final StringCallback callback;
  DropdownButtonWidget({required this.callback});

  @override
  _DropdownButtonState createState() => _DropdownButtonState();


}

class _DropdownButtonState extends State<DropdownButtonWidget> {


  String dropdownValue = ufList.first;




  // setState(() {});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: Colors.black,
      ),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
        widget.callback(dropdownValue);
      },
      items: ufList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

}