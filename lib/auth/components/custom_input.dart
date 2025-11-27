import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  final String label;
  final String helpingText;
  final String? firstImagePath;
  final String? secondImagePath;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validator;

  const CustomInput({
    super.key,
    required this.label,
    required this.helpingText,
    required this.controller,
    this.firstImagePath,
    this.secondImagePath,
    this.isPassword = false,
    this.validator,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool _obscure = true;
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 12.0),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Text Field
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          focusNode: _focusNode,
          controller: widget.controller,
          validator: widget.validator,
          errorBuilder: (context, errorText) => Text(
            "      $errorText",
            style: TextStyle(color: Colors.red, fontSize: 14, height: 1.2),
          ),
          obscureText: widget.isPassword ? _obscure : false,
          decoration: InputDecoration(
            errorMaxLines: 2,

            labelText: widget.helpingText,

            labelStyle:  TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface),

            border: InputBorder.none,
            prefixIcon: widget.firstImagePath != null
                ? Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset(widget.firstImagePath!),
                  )
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility_off : Icons.visibility,

                      color: Theme.of(context).colorScheme.onSurface,
                      size: 20,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  )
                : widget.secondImagePath != null
                ? Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset(widget.secondImagePath!),
                  )
                : null,
          ),

          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: _isFocused ? FontWeight.bold : FontWeight.normal,
          ),

          onChanged: (value) {},
        ),
        const SizedBox(height: 2),

        Align(
          alignment: Alignment.center,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: _isFocused
                ? MediaQuery.widthOf(context) * 0.95
                : MediaQuery.widthOf(context) * 0.9,
            height: 2,
            color: _isFocused
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),

        const SizedBox(height: 12),
      ],
    );
  }
}
