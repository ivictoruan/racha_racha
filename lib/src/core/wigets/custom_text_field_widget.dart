import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String labelText;
  final IconData? icon;
  final TextInputType? keyboardType;
  final String? hintText;
  final String? Function(String? text)? validator;
  final void Function(String? text)? onSaved;
  final TextEditingController? controller;
  final String? initialValue;
  final bool? enabled;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final bool? autofocus;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;

  const CustomTextFieldWidget({
    Key? key,
    required this.labelText,
    this.icon,
    this.keyboardType,
    this.hintText,
    this.validator,
    this.onSaved,
    this.controller,
    this.initialValue,
    this.enabled,
    this.onChanged,
    this.inputFormatters,
    this.autofocus,
    this.textInputAction,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.all(Radius.circular(size.width * 0.2)),
      shadowColor: Colors.purpleAccent,
      child: SizedBox(
        width: size.width * 0.85,
        child: TextFormField(
          initialValue: initialValue,
          controller: controller,
          autofocus: autofocus ?? true,
          inputFormatters: inputFormatters,
          textInputAction: textInputAction,
          enabled: enabled,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.purple.withOpacity(0.8)),
              borderRadius: BorderRadius.all(Radius.circular(size.width * 0.2)),
            ),
            labelText: labelText,
            labelStyle: TextStyle(fontSize: 0.044 * size.width),
            hintText: hintText ?? "Digite o $labelText",
            hintStyle: TextStyle(fontSize: 0.044 * size.width),
            prefixIcon: icon == null ? null : Icon(icon, color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(size.width * 0.2),
              ),
              borderSide: const BorderSide(
                  color: Colors.purple, width: 5, style: BorderStyle.none),
            ),
          ),
          validator: validator,
          onSaved: onSaved,
          onChanged: onChanged,
          maxLines: 1,
          onFieldSubmitted: onFieldSubmitted,
        ),
      ),
    );
  }
}
