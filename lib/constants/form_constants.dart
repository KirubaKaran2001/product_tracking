// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ProductFormDetails extends StatefulWidget {
  TextEditingController? controller;
  String? labelText;
  TextInputType? keyboardType;
  FilteringTextInputFormatter? textInputFormatter;

  ProductFormDetails({
    required this.controller,
    required this.labelText,
    required this.keyboardType,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductFormDetails> createState() => _ProductFormDetailsState();
}

class _ProductFormDetailsState extends State<ProductFormDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
        child: TextFormField(
          // keyboardType: TextInputType.number,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: widget.labelText,
          ),
        ),
      ),
    );
  }
}

class ProductFormDate extends StatefulWidget {
  TextEditingController? controller;
  String? labelText;
  TextInputType? keyboardType;

  ProductFormDate({
    required this.controller,
    required this.labelText,
    required this.keyboardType,
    Key? key,
  }) : super(key: key);

  @override
  _ProductFormDateState createState() => _ProductFormDateState();
}

class _ProductFormDateState extends State<ProductFormDate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: widget.labelText,
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          controller: widget.controller,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime.now());
            if (pickedDate != null) {
              debugPrint(pickedDate.toString());
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
              debugPrint(formattedDate);
              setState(() {
                widget.controller!.text = formattedDate;
              });
            } else {}
          },
        ),
      ),
    );
  }
}

