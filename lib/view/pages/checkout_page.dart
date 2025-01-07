import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_online/model/location_item_model.dart';
import 'package:talabat_online/model/payment_cart_model.dart';
import 'package:talabat_online/utils/app_colors.dart';
import 'package:talabat_online/utils/app_routes.dart';
import 'package:talabat_online/view/widgets/checkout_headlins_item.dart';
import 'package:talabat_online/view/widgets/empty_shopping_payment.dart';
import 'package:talabat_online/view/widgets/payment_bottom_sheet.dart';
import 'package:talabat_online/view/widgets/payment_method_item.dart';
import 'package:talabat_online/view_models/checkout_cubit/checkout_cubit.dart';
import 'package:talabat_online/view_models/checkout_cubit/checkout_state.dart';
import 'package:talabat_online/view_models/payment_methods_cubit/pyament_methods_cubit.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});
  Widget buildPaymentMethods(
      PaymentCartModel? chosenCart, BuildContext context) {
    if (chosenCart != null) {
      return PaymentMethodItem(
        paymentCart: chosenCart,
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (_) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: double.infinity,
                  child: BlocProvider(
                    create: (context) =>
                        PyamentMethodsCubit()..fetchPaymentMethods(),
                    child: PaymentBottomSheet(),
                  ),
                );
              }).then((onValue) {
            BlocProvider.of<CheckoutCubit>(context).getCartItems();
          });
        },
      );
    } else {
      return EmptyShoppingPayment(title: 'Add Your Payment', isPayment: true);
    }
  }

  Widget buildLocationItem(
      LoactionItemModel? choseLocation, BuildContext context) {
    if (choseLocation != null) {
      return Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              imageUrl: choseLocation.imgUrl,
            ),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                choseLocation.city,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(height: 6),
              Text(
                '${choseLocation.city}-${choseLocation.country}',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey,
                    ),
              ),
            ],
          ),
        ],
      );
    } else {
      return CheckoutHeadlinsItem(
        title: 'Address',
        onTap: () {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Checkout',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: BlocProvider(
        create: (context) => CheckoutCubit()..getCartItems(),
        child: Builder(builder: (context) {
          final cubit = BlocProvider.of<CheckoutCubit>(context);
          return BlocBuilder<CheckoutCubit, CheckoutState>(
            bloc: cubit,
            buildWhen: (previous, current) =>
                current is CheckoutError ||
                current is CheckoutLeading ||
                current is CheckoutLoaded,
            builder: (context, state) {
              if (state is CheckoutLeading) {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (state is CheckoutError) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is CheckoutLoaded) {
                final cartItem = state.cartItem;
                final choseLocation = state.choseLocations;
                final chosenPaymentCart = state.chosenPaymentCarts;
                return SingleChildScrollView(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 14),
                      child: Column(
                        children: [
                          CheckoutHeadlinsItem(
                            title: 'Address',
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.choseLocationRaoute)
                                  .then((onValue) => cubit.getCartItems());
                            },
                          ),
                          buildLocationItem(choseLocation, context),
                          SizedBox(
                            height: 16,
                          ),
                          CheckoutHeadlinsItem(
                            title: 'Prudact',
                            numOfPrudact: state.numOfPrudact,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: cartItem.length,
                            itemBuilder: (context, index) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: AppColors.grey3,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: CachedNetworkImage(
                                      height: 100,
                                      width: 100,
                                      imageUrl: cartItem[index].prudact.imgUrl,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cartItem[index].prudact.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Size: ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: AppColors.grey,
                                                      ),
                                                ),
                                                Text(
                                                  cartItem[index].size.name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              '\$${cartItem[index].totalPrice.toStringAsFixed(2)}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                thickness: 0.6,
                              );
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          CheckoutHeadlinsItem(
                            title: 'Payment Method',
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          buildPaymentMethods(chosenPaymentCart, context),
                          SizedBox(
                            height: 16,
                          ),
                          Divider(
                            thickness: 0.6,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Amount :',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: AppColors.grey,
                                    ),
                              ),
                              Text(
                                '\$${state.totalAmount.toStringAsFixed(2)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                              ),
                              onPressed: () {},
                              child: Text(
                                'Checkout Now',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.withe,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Text('Something is rong'),
                );
              }
            },
          );
        }),
      ),
    );
  }
}
