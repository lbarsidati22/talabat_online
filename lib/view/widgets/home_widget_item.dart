import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:talabat_online/utils/app_routes.dart';
import 'package:talabat_online/view/widgets/prudact_item.dart';
import 'package:talabat_online/view_models/home_cubit/home_cubit.dart';

class HomeWidgetItem extends StatelessWidget {
  const HomeWidgetItem({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => HomeCubit()..getHomeData(),
      child: Builder(builder: (context) {
        return BlocBuilder<HomeCubit, HomeState>(
          bloc: BlocProvider.of<HomeCubit>(context),
          builder: (context, state) {
            if (state is HomelLeading) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is HomeError) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is HomelLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    FlutterCarousel.builder(
                      itemCount: state.carouselItem.length,
                      itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) =>
                          Padding(
                        padding: const EdgeInsetsDirectional.only(end: 16),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: state.carouselItem[itemIndex].imgUrl,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                      child:
                                          CircularProgressIndicator.adaptive()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                      options: FlutterCarouselOptions(
                        showIndicator: false,
                        autoPlay: false,
                        height: size.height * 0.19,
                        //  showIndicator: false,
                        slideIndicator: CircularWaveSlideIndicator(),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'New Arrifals',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'See All',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        )
                      ],
                    ),
                    GridView.builder(
                      itemCount: state.prudact.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (conttext, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(
                              context,
                              rootNavigator: true,
                            ).pushNamed(
                              AppRoutes.prudactDetailsRoute,
                              arguments: state.prudact[index].id,
                            );
                          },
                          child: PrudactItem(
                              prudactItemModel: state.prudact[index]),
                        );
                      },
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: Text('something is rong'),
              );
            }
          },
        );
      }),
    );
  }
}
