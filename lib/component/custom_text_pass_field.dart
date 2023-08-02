import 'package:flutter/material.dart';

class CustomTextPassForm extends StatefulWidget {
  const CustomTextPassForm({
    super.key,
    required this.hintText,
    required this.textController,
    required this.valid,
  });

  final String hintText;
  final TextEditingController textController;
  final String? Function(String?)? valid;

  @override
  State<CustomTextPassForm> createState() => _CustomTextPassFormState();
}

class _CustomTextPassFormState extends State<CustomTextPassForm> {
  bool scure = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        obscureText: scure,
        validator: widget.valid,
        controller: widget.textController,
        onTapOutside: (event) =>
            FocusScope.of(context).requestFocus(FocusNode()),
        decoration: InputDecoration(
          suffixIcon: IconButton(
              color: Colors.white38,
              // ignore: dead_code
              icon: scure == true
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
              onPressed: () {
                setState(() {
                  scure = !scure;
                });
              }),
          label: Text(widget.hintText),
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
