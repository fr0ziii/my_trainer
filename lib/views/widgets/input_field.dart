import 'package:flutter/material.dart';
import '/utils/constants.dart';

class InputField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  InputField({
    required this.label,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: ValueKey(label));

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: titleStyle,
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    controller: controller,
                    style: subtitleStyle,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: subtitleStyle,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                    ),
                  ),
                ),
                widget == null ? Container(): Container(child: widget) // Puedes agregar más widgets aquí
              ],
            )
          )
        ],
      ),
    );
  }
}
