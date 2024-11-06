import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/space_constants.dart';

class TextFormFieldWidget extends StatelessWidget {
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
  final Function()? onClearTextPressed;

  const TextFormFieldWidget({
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
    this.onClearTextPressed,
  }) : super(key: key);

  Color get borderColor => Colors.deepPurple.withOpacity(0.8);

  BorderRadius get borderRadius => const BorderRadius.all(Radius.circular(30));

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Material(
          elevation: 3,
          borderRadius: borderRadius,
          shadowColor: Colors.deepPurpleAccent,
          color: Colors.white,
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
                borderSide: BorderSide(
                  color: borderColor,
                ),
                borderRadius: borderRadius,
              ),
              labelText: labelText,
              labelStyle: const TextStyle(
                fontSize: SpaceConstants.small + 2,
              ),
              hintText: hintText ?? "Digite o $labelText",
              hintStyle: TextStyle(
                fontSize: 16,
                color: borderColor,
                fontWeight: FontWeight.bold,
              ),
              prefixIcon: icon == null
                  ? null
                  : Icon(
                      icon,
                      color: Colors.deepPurple,
                    ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(80),
                ),
                borderSide: BorderSide(
                  color: Colors.deepPurple,
                  width: 6,
                  style: BorderStyle.none,
                ),
              ),
            ),
            validator: validator,
            onSaved: onSaved,
            onChanged: onChanged,
            maxLines: 1,
            onFieldSubmitted: onFieldSubmitted,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
}
