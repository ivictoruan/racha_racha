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
  final Function()? onClearTextPressed;

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
    this.onClearTextPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width * 0.85,
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.all(Radius.circular(size.width * 0.2)),
        shadowColor: Colors.deepPurpleAccent,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(.75),
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
                borderSide:
                    BorderSide(color: Colors.deepPurple.withOpacity(0.8)),
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 0.2)),
              ),
              labelText: "$labelText (obrigatório)",
              labelStyle: TextStyle(
                fontSize: 0.035 * size.width,
                fontWeight: FontWeight.w500,
              ),
              hintText: hintText ?? "Digite o $labelText",
              hintStyle: TextStyle(
                fontSize: 0.035 * size.width,
                fontWeight: FontWeight.w500,
              ),
              prefixIcon: icon == null
                  ? null
                  : Icon(
                      icon,
                      color: Colors.purple,
                    ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(size.width * 0.2),
                ),
                borderSide: const BorderSide(
                    color: Colors.deepPurple,
                    width: 5,
                    style: BorderStyle.none),
              ),
              // suffixIcon: IconButton(
              //     icon: const Icon(Icons.clear),
              //     color: Colors.purple,
              //     onPressed: () => onClearTextPressed!() ?? () {}),
            ),
            validator: validator,
            onSaved: onSaved,
            onChanged: onChanged,
            maxLines: 1,
            onFieldSubmitted: onFieldSubmitted,
          ),
        ),
      ),
    );
  }
}
