import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_online/utils/app_colors.dart';
import 'package:talabat_online/utils/app_routes.dart';
import 'package:talabat_online/view/widgets/main_bottom.dart';
import 'package:talabat_online/view_models/payment_methods_cubit/pyament_methods_cubit.dart';

class PaymentBottomSheet extends StatelessWidget {
  const PaymentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<PyamentMethodsCubit>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Methods',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            BlocBuilder<PyamentMethodsCubit, PyamentMethodsState>(
              bloc: cubit,
              buildWhen: (previous, current) =>
                  current is FetchPaymentMethodsError ||
                  current is FetchedPaymentMethods ||
                  current is FetchingPaymentMethods,
              builder: (context, state) {
                if (state is FetchingPaymentMethods) {
                  return Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (state is FetchedPaymentMethods) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.paymantCarts.length,
                    itemBuilder: (context, index) {
                      final paymentCarts = state.paymantCarts[index];
                      return InkWell(
                        onTap: () {
                          cubit.changPaymentMethods(paymentCarts.id);
                        },
                        child: Card(
                          color: AppColors.withe,
                          child: ListTile(
                            leading: DecoratedBox(
                              decoration: BoxDecoration(
                                color: AppColors.grey3,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: CachedNetworkImage(
                                  height: 50,
                                  width: 50,
                                  imageUrl:
                                      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Mastercard_2019_logo.svg/1200px-Mastercard_2019_logo.svg.png',
                                ),
                              ),
                            ),
                            title: Text(
                              paymentCarts.cardNumber,
                            ),
                            subtitle: Text(
                              paymentCarts.cardHolderName,
                            ),
                            trailing: BlocBuilder<PyamentMethodsCubit,
                                PyamentMethodsState>(
                              bloc: cubit,
                              buildWhen: (previous, current) =>
                                  current is PaymentMethodsChosen,
                              builder: (context, state) {
                                if (state is PaymentMethodsChosen) {
                                  final chosenPayment = state.chosenPaymnt;

                                  return Radio<String>(
                                    value: paymentCarts.id,
                                    groupValue: chosenPayment.id,
                                    onChanged: (id) {
                                      cubit.changPaymentMethods(id!);
                                    },
                                  );
                                }
                                return SizedBox.shrink();
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return SizedBox.shrink();
              },
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.addNewCartRoute)
                    .then((onValue) {
                  cubit.fetchPaymentMethods();
                });
              },
              child: Card(
                color: AppColors.withe,
                child: ListTile(
                  leading: Icon(
                    Icons.add_circle,
                  ),
                  title: Text(
                    'Add Payment Method',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ),
            SizedBox(height: 14),
            BlocConsumer<PyamentMethodsCubit, PyamentMethodsState>(
              listenWhen: (previous, current) =>
                  current is ConfirmPaymentLoaded,
              listener: (context, state) {
                if (state is ConfirmPaymentLoaded) {
                  Navigator.pop(context);
                }
              },
              bloc: cubit,
              buildWhen: (previous, current) =>
                  current is ConfirmPaymentLoaded ||
                  current is ConfirmPaymentLeading,
              builder: (context, state) {
                if (state is ConfirmPaymentLeading) {
                  return MainBottom(
                    isLeading: true,
                    onTap: () {},
                  );
                }
                return MainBottom(
                  text: 'Confirm',
                  onTap: () {
                    cubit.confirmPaymentMethods();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
