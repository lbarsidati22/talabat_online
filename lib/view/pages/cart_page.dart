import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_online/utils/app_colors.dart';
import 'package:talabat_online/utils/app_routes.dart';
import 'package:talabat_online/view/widgets/cart_item_widget.dart';
import 'package:talabat_online/view_models/cart_cubit/cart_cubit.dart';
import 'package:flutter_dash/flutter_dash.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCartItems(),
      child: Builder(builder: (context) {
        final cubit = BlocProvider.of<CartCubit>(context);
        return BlocBuilder<CartCubit, CartState>(
          bloc: cubit,
          buildWhen: (previous, current) =>
              current is CartError ||
              current is CartLeading ||
              current is CartLoaded,
          builder: (context, state) {
            if (state is CartLeading) {
              return Center(child: CircularProgressIndicator.adaptive());
            } else if (state is CartLoaded) {
              final cartItems = state.cartItems;
              if (cartItems.isEmpty) {
                return Center(
                  child: Text('No Item in Your Cart'),
                );
              }
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            final cartItem = cartItems[index];
                            return CartItemWidget(cartItem: cartItem);
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              thickness: 0.6,
                            );
                          },
                        ),
                        Divider(
                          thickness: 0.6,
                        ),
                        BlocBuilder<CartCubit, CartState>(
                          bloc: cubit,
                          buildWhen: (previous, current) =>
                              current is SubtotalUpdate,
                          builder: (context, subtotalState) {
                            if (subtotalState is SubtotalUpdate) {
                              return Column(
                                children: [
                                  totalAndSubtotalWidget(
                                    title: 'Subtotal',
                                    context,
                                    amount: subtotalState.subtotal,
                                  ),
                                  totalAndSubtotalWidget(
                                    title: 'Shipping',
                                    context,
                                    amount: 10,
                                  ),
                                  SizedBox(height: 5),
                                  Dash(
                                    dashColor: AppColors.grey4,
                                    length:
                                        MediaQuery.of(context).size.width - 32,
                                  ),
                                  SizedBox(height: 5),
                                  totalAndSubtotalWidget(
                                    title: 'Total Amount',
                                    context,
                                    amount: subtotalState.subtotal + 10,
                                  ),
                                ],
                              );
                            }
                            return Column(
                              children: [
                                totalAndSubtotalWidget(
                                  title: 'Subtotal',
                                  context,
                                  amount: state.subtotal,
                                ),
                                totalAndSubtotalWidget(
                                  title: 'Shipping',
                                  context,
                                  amount: 10,
                                ),
                                totalAndSubtotalWidget(
                                  title: 'Total Amount',
                                  context,
                                  amount: state.subtotal + 10,
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          height: 60,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: AppColors.withe,
                            ),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed(AppRoutes.checkoutRoute);
                            },
                            child: Text(
                              'Checkout',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: AppColors.withe,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        );
      }),
    );
  }
}

Widget totalAndSubtotalWidget(
  BuildContext context, {
  required String title,
  required double amount,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: AppColors.grey,
            ),
      ),
      Text(
        '\$${amount.toStringAsFixed(1)}',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(),
      ),
    ],
  );
}
