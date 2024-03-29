import 'package:flutter/material.dart';

import '../../../core/ui/styles/text_styles.dart';

class OrderField extends StatelessWidget {
  const OrderField({
    super.key,
    required this.title,
    required this.controller,
    required this.validator,
    required this.hintText,
  });

  final String title;

  final TextEditingController controller;

  final FormFieldValidator validator;

  final String hintText;

  @override
  Widget build(BuildContext context) {
    const defaultBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 35,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                title,
                style: context.textStyles.textRegular.copyWith(
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          TextFormField(
            controller: controller,
            validator: validator,
            decoration: InputDecoration(
              hintText: hintText,
              border: defaultBorder,
              enabledBorder: defaultBorder,
              errorBorder: defaultBorder,
              focusedBorder: defaultBorder,
            ),
          ),
        ],
      ),
    );
  }
}
