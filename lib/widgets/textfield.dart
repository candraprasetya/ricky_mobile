// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyTextfield extends StatefulWidget {
  final String title;
  final TextEditingController textEditingController;
  const MyTextfield({
    Key? key,
    required this.title,
    required this.textEditingController,
  }) : super(key: key);

  @override
  State<MyTextfield> createState() => _MyTextfieldState();
}

class _MyTextfieldState extends State<MyTextfield> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 4),
        TextField(
          controller: widget.textEditingController,
          decoration: InputDecoration(
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
      ],
    );
  }
}
