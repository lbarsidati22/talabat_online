import 'package:flutter/material.dart';
import 'package:talabat_online/utils/app_colors.dart';

class CheckoutHeadlinsItem extends StatelessWidget {
  final String title;
  final int? numOfPrudact;
  final VoidCallback? onTap;
  const CheckoutHeadlinsItem({
    super.key,
    required this.title,
    this.numOfPrudact,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (numOfPrudact != null)
              Text(
                '($numOfPrudact)',
                style: Theme.of(context).textTheme.titleLarge,
              ),
          ],
        ),
        if (onTap != null)
          TextButton(
            onPressed: onTap,
            child: Text(
              'Edit',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColors.primaryColor,
                  ),
            ),
          ),
      ],
    );
  }
}
