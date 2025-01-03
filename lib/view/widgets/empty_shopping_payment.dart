import 'package:flutter/material.dart';
import 'package:talabat_online/utils/app_colors.dart';

class EmptyShoppingPayment extends StatelessWidget {
  final String title;
  const EmptyShoppingPayment({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.grey2,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
        child: Column(
          children: [
            Icon(
              Icons.add,
              size: 28,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
