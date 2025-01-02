import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_online/model/add_to_cart_model.dart';
import 'package:talabat_online/utils/app_colors.dart';
import 'package:talabat_online/view/widgets/counter_widget.dart';
import 'package:talabat_online/view_models/cart_cubit/cart_cubit.dart';

class CartItemWidget extends StatelessWidget {
  final AddToCartModel cartItem;
  const CartItemWidget({
    super.key,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CartCubit>(context);
    final size = MediaQuery.of(context).size;
    return Row(
      //  crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.grey4,
            borderRadius: BorderRadius.circular(12),
          ),
          child: CachedNetworkImage(
            height: size.height * 0.13,
            width: size.width * 0.33,
            imageUrl: cartItem.prudact.imgUrl,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cartItem.prudact.name,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              //SizedBox(height: 5),
              Text.rich(
                TextSpan(
                  text: 'Size: ',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey,
                      ),
                  children: [
                    TextSpan(
                      text: cartItem.size.name,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<CartCubit, CartState>(
                bloc: cubit,
                buildWhen: (prevous, current) =>
                    current is QuantityCounterLoaded &&
                    current.prudactId == cartItem.prudact.id,
                builder: (context, state) {
                  if (state is QuantityCounterLoaded) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CounterWidget(
                          cubit: cubit,
                          value: state.value,
                          prudactId: cartItem.prudact.id,
                        ),
                        Text(
                          '\$${state.value * cartItem.prudact.price}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CounterWidget(
                        initalValue: cartItem.quantity,
                        cubit: cubit,
                        value: cartItem.quantity,
                        prudactId: cartItem.prudact.id,
                      ),
                      Text(
                        '\$${cartItem.totalPrice.toStringAsFixed(1)}',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
