import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:talabat_online/model/payment_cart_model.dart';
import 'package:talabat_online/utils/app_colors.dart';

class PaymentMethodItem extends StatelessWidget {
  final PaymentCartModel paymentCart;
  final VoidCallback onTap;

  const PaymentMethodItem(
      {super.key, required this.paymentCart, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.withe,
        border: Border.all(
          color: AppColors.grey3,
        ),
      ),
      child: ListTile(
        onTap: onTap,
        leading: CachedNetworkImage(
          height: 50,
          width: 50,
          fit: BoxFit.contain,
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Mastercard_2019_logo.svg/1200px-Mastercard_2019_logo.svg.png',
        ),
        title: Text('MACTER CARD'),
        subtitle: Text(paymentCart.cardHolderName),
        trailing: Icon(
          Icons.chevron_right_sharp,
        ),
      ),
    );
  }
}
