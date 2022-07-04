import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final void Function(String)? onChanged;
  final String label;
  final TextInputType? inputType;
  final Widget? prefixIcon;
  final bool isPassword;
  final String? Function(String?)? validator;
  const CustomInputField({
    Key? key,
    this.onChanged,
    required this.label,
    this.inputType,
    this.prefixIcon,
    this.isPassword = false,
    this.validator,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: widget.validator,
      initialValue: "",
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              keyboardType: widget.inputType,
              obscureText: _obscureText,
              onChanged: (text) {
                if (widget.validator != null) {
                  // ignore: invalid_use_of_protected_member
                  state.setValue(text);
                  state.validate();
                }
                if (widget.onChanged != null) {
                  widget.onChanged!(text);
                }
              },
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: Colors.grey),
                labelText: widget.label,
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.isPassword
                    ? CupertinoButton(
                        child: Icon(_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          _obscureText = !_obscureText;
                          setState(() {});
                        },
                      )
                    : Container(
                        width: 0,
                      ),
              ),
            ),
            if (state.hasError)
              Text(
                state.errorText!,
                style: const TextStyle(color: Colors.redAccent),
              ),
          ],
        );
      },
    );
  }
}
