import 'package:flutter/material.dart';
import 'package:talabat_online/utils/app_colors.dart';

class LableWithTextFeild extends StatefulWidget {
  final String hintText;

  final IconData icon;

  final TextEditingController controller;

  final String lable;
  const LableWithTextFeild({
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
    required this.lable,
  });

  @override
  State<LableWithTextFeild> createState() => _LableWithTextFeildState();
}

class _LableWithTextFeildState extends State<LableWithTextFeild> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(
          widget.lable,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(height: 10),
        TextFormField(
          validator: (value) => value == null || value.isEmpty
              ? '${widget.lable} Cannot be empty '
              : null,
          controller: widget.controller,
          decoration: InputDecoration(
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.red,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            prefixIcon: Icon(widget.icon),
            hintText: widget.hintText,
            fillColor: AppColors.grey3,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}
