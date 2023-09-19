import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFormField extends StatelessWidget {
  final String label;
  final String? Function(String?) validator;
  final TextInputType textInputType;
  final int? maxLength;
  const AppTextFormField({Key? key, required this.label, required this.validator, required this.textInputType, this.maxLength = null}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
      child: TextFormField(
        keyboardType: textInputType,
        validator: validator,
        maxLength: maxLength,
        inputFormatters: [
          if(textInputType== TextInputType.number)
            FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green),

          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.indigo,
            ),
          ),
          filled: true,
          fillColor: Colors.indigo[50],
          labelText: label,
          counterText: "",
          labelStyle: const TextStyle(color: Colors.black),
        ),
      ),
    );;
  }
}
