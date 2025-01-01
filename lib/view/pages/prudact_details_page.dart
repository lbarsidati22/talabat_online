import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                      color: AppColors.grey4,
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
                      child: Column(
                        children: [
                          Row(
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
                        ],
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
