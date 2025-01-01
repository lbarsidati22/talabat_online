import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:talabat_online/view_model/home_cubit/home_cubit.dart';

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
              return FlutterCarousel.builder(
                itemCount: state.carouselItem.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
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
                      child: Image.network(
                        fit: BoxFit.cover,
                        state.carouselItem[itemIndex].imgUrl,
                      ),
                    ),
                  ),
                ),
                options: FlutterCarouselOptions(
                  showIndicator: false,
                  height: size.height * 0.19,
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
