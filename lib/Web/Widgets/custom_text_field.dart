import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.labelText,
      required this.icon,
      required this.obscureText})
      : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final IconData icon;
  final bool obscureText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.obscureText,
      controller: widget.controller,
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        hintText: widget.hintText,
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
        ),
        focusColor: Theme.of(context).primaryColor,
        contentPadding: const EdgeInsets.all(15),
        border: const OutlineInputBorder(),
        labelText: widget.labelText,
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        prefixIcon: Icon(
          widget.icon,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
