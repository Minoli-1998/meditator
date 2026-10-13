import 'package:flutter/material.dart';
import 'package:meditator/utils/colors.dart';

class FormTextFieldInput extends StatelessWidget {
  final String lableText;
  final String? hintText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;

  const FormTextFieldInput({
    super.key,
    required this.hintText,
    required this.lableText,
    this.onSaved,
    this.validator,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
      decoration: InputDecoration(
        labelText: lableText,
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.primaryGrey, fontSize: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(color: AppColors.primaryGrey, width: 1),
        ),
      ),
    );
  }
}
