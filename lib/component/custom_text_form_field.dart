import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    super.key,
    required this.hintText,
    required this.textController,
    required this.valid,
  });

  final String hintText;
  final TextEditingController textController;
  final String? Function(String?)? valid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        validator: valid,
        controller: textController,
        onTapOutside: (event) =>
            FocusScope.of(context).requestFocus(FocusNode()),
        decoration: InputDecoration(
          label: Text(hintText),
          labelStyle: const TextStyle(color: Colors.white24),
          errorStyle: const TextStyle(color: Colors.redAccent),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.white38,
                width: 1,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.white38,
                width: 1,
              )),
        ),
      ),
    );
  }
}
