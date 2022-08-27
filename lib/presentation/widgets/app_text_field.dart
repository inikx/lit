import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final void Function(String) onChanged;
  final bool obscureText;
  final bool enableSuggestions;
  final String hintText;
  AppTextField(
      {Key? key,
      required this.onChanged,
      required this.obscureText,
      required this.enableSuggestions,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
          cursorColor: Colors.grey,
          onChanged: onChanged,
          obscureText: obscureText,
          enableSuggestions: enableSuggestions,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 15,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
            fillColor: Colors.grey[200],
            filled: true,
          )),
    );
  }
}
