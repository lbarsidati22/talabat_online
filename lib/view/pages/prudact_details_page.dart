import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_online/model/prudact_item_model.dart';
import 'package:talabat_online/utils/app_colors.dart';
import 'package:talabat_online/view/widgets/counter_widget.dart';
import 'package:talabat_online/view_models/home_details_cubit/home_details_cubit.dart';

class PrudactDetailsPage extends StatelessWidget {
  final String prudactId;
  const PrudactDetailsPage({super.key, required this.prudactId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Builder(builder: (context) {
      final cubit = BlocProvider.of<PrudactDetailsCubit>(context);

      return BlocBuilder<PrudactDetailsCubit, PrudactDetailsState>(
        bloc: cubit,
        buildWhen: (prevuse, current) =>
            current is PrudactDetailsLeading ||
            current is PrudactDetailsLoaded ||
            current is PrudactDetailsError,
        builder: (context, state) {
          if (state is PrudactDetailsLeading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          } else if (state is PrudactDetailsError) {
            return Scaffold(
              body: Center(
                child: Text(state.message),
              ),
            );
          } else if (state is PrudactDetailsLoaded) {
            final prudact = state.prudacts;
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: Text(
                  prudact.name,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                actions: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    width: size.width * 0.12,
                    height: size.height * 0.06,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColors.grey2,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.shopping_bag,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              body: Stack(
                children: [
                  Container(
                    height: size.height * 0.54,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.grey3,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.14,
                        ),
                        CachedNetworkImage(
                          height: size.height * 0.4,
                          imageUrl: prudact.imgUrl,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: AppColors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.48),
                    child: Container(
                      padding: EdgeInsets.all(24),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.withe,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(33),
                          topLeft: Radius.circular(33),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      prudact.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 26,
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          '${prudact.avrageRate}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                BlocBuilder<PrudactDetailsCubit,
                                    PrudactDetailsState>(
                                  bloc: cubit,
                                  buildWhen: (previous, current) =>
                                      current is QuantityCounterLoaded ||
                                      current is PrudactDetailsLoaded,
                                  builder: (context, state) {
                                    if (state is QuantityCounterLoaded) {
                                      return CounterWidget(
                                        cubit: cubit,
                                        value: state.value,
                                        prudactId: prudact.id,
                                      );
                                    } else if (state is PrudactDetailsLoaded) {
                                      return CounterWidget(
                                        cubit: cubit,
                                        value: 1,
                                        prudactId: prudact.id,
                                      );
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Size',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            BlocBuilder<PrudactDetailsCubit,
                                PrudactDetailsState>(
                              bloc: cubit,
                              buildWhen: (prevues, current) =>
                                  current is SelectedSizeLoaded ||
                                  current is PrudactDetailsLoaded,
                              builder: (context, state) {
                                return Row(
                                  children: PrudactSize.values.map(
                                    (size) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            right: 5, top: 8),
                                        child: InkWell(
                                          onTap: () {
                                            if (state is SelectedSizeLoaded) {}
                                            cubit.selectSize(size);
                                          },
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  state is SelectedSizeLoaded &&
                                                          state.size == size
                                                      ? Theme.of(context)
                                                          .primaryColor
                                                      : AppColors.grey3,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Text(
                                                size.name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      color:
                                                          state is SelectedSizeLoaded &&
                                                                  state.size ==
                                                                      size
                                                              ? AppColors.withe
                                                              : AppColors.black,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                );
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Descreption',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              maxLines: 7,
                              overflow: TextOverflow.ellipsis,
                              prudact.description,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: AppColors.black2,
                                  ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '\$',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                            color: AppColors.primaryColor,
                                          ),
                                    ),
                                    Text(
                                      '${prudact.price}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                                BlocBuilder<PrudactDetailsCubit,
                                    PrudactDetailsState>(
                                  bloc: cubit,
                                  buildWhen: (prevuse, current) =>
                                      current is PrudactAdedToCart ||
                                      current is PrudactAddingToCart,
                                  builder: (context, state) {
                                    if (state is PrudactAddingToCart) {
                                      return ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          foregroundColor: AppColors.withe,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        onPressed: null,
                                        child: Center(
                                          child: CircularProgressIndicator
                                              .adaptive(),
                                        ),
                                      );
                                    } else if (state is PrudactAdedToCart) {
                                      return ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.grey,
                                          foregroundColor: AppColors.withe,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        onPressed: null,
                                        child: Text('Add to Cart'),
                                      );
                                    }
                                    return ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryColor,
                                        foregroundColor: AppColors.withe,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.shopping_bag,
                                        color: AppColors.withe,
                                      ),
                                      onPressed: () {
                                        if (cubit.selectedSize != null) {
                                          cubit.addToCart(prudact.id);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content:
                                                  Text('Please Select a Size'),
                                            ),
                                          );
                                        }
                                      },
                                      label: Text('Add to Cart'),
                                    );
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: Text('Something is rong'),
              ),
            );
          }
        },
      );
    });
  }
}
