import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_online/utils/app_colors.dart';
import 'package:talabat_online/view/widgets/lable_with_text_feild.dart';
import 'package:talabat_online/view/widgets/location_iten.dart';
import 'package:talabat_online/view/widgets/main_bottom.dart';
import 'package:talabat_online/view_models/chose_location_cubit/chose_location_cubit.dart';

class ChoseLocationPage extends StatefulWidget {
  const ChoseLocationPage({super.key});

  @override
  State<ChoseLocationPage> createState() => _ChoseLocationPageState();
}

final locationController = TextEditingController();

class _ChoseLocationPageState extends State<ChoseLocationPage> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ChoseLocationCubit>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Address',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose your location',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  'Let\'s find your unforgratble enevt. Choose a lecation below to ged started ',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey,
                      ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.red,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    prefixIcon: Icon(
                      Icons.location_on_outlined,
                      color: AppColors.grey,
                    ),
                    hintText: 'City-Country',
                    suffixIcon:
                        BlocConsumer<ChoseLocationCubit, ChoseLocationState>(
                      listenWhen: (previous, current) =>
                          current is ConfirmAddressLoaded ||
                          current is LocationAded,
                      listener: (context, state) {
                        if (state is LocationAded) {
                          locationController.clear();
                        } else if (state is ConfirmAddressLoaded) {
                          Navigator.pop(context);
                        }
                      },
                      buildWhen: (previous, current) =>
                          current is LocationAdding ||
                          current is LocationAded ||
                          current is LocationError,
                      bloc: cubit,
                      builder: (context, state) {
                        if (state is LocationAdding) {
                          return Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }
                        return IconButton(
                          onPressed: () {
                            if (locationController.text.isNotEmpty) {
                              cubit.addLocation(locationController.text);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Your locations required'),
                                ),
                              );
                            }
                          },
                          icon: Icon(
                            Icons.add,
                            size: 28,
                            color: AppColors.grey,
                          ),
                        );
                      },
                    ),
                    fillColor: AppColors.grey3,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Select location',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                BlocBuilder<ChoseLocationCubit, ChoseLocationState>(
                  bloc: cubit,
                  buildWhen: (previous, current) =>
                      current is FetchLocationError ||
                      current is FetchedLocation ||
                      current is FetchingLocation,
                  builder: (context, state) {
                    if (state is FetchingLocation) {
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else if (state is FetchedLocation) {
                      final locations = state.locations;
                      return ListView.builder(
                        itemCount: locations.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final location = locations[index];
                          return BlocBuilder<ChoseLocationCubit,
                              ChoseLocationState>(
                            bloc: cubit,
                            buildWhen: (previous, current) =>
                                current is ChosenLocation,
                            builder: (context, state) {
                              if (state is ChosenLocation) {
                                final choseLocation = state.location;
                                return LocationIten(
                                  backgoundColor:
                                      choseLocation.id == location.id
                                          ? AppColors.primaryColor
                                          : AppColors.grey,
                                  location: location,
                                  onTap: () {
                                    cubit.selectLocation(location.id);
                                  },
                                );
                              }
                              return LocationIten(
                                location: location,
                                onTap: () {
                                  cubit.selectLocation(location.id);
                                },
                              );
                            },
                          );
                        },
                      );
                    } else if (state is FetchLocationError) {
                      return Text('Something is rong');
                    }
                    return SizedBox.shrink();
                  },
                ),
                SizedBox(height: 20),
                BlocBuilder<ChoseLocationCubit, ChoseLocationState>(
                  bloc: cubit,
                  buildWhen: (previouse, current) =>
                      current is ConfirmAddressError ||
                      current is ConfirmAddressLeading ||
                      current is ConfirmAddressLoaded,
                  builder: (context, state) {
                    if (state is ConfirmAddressLeading) {
                      return MainBottom(
                        isLeading: true,
                        onTap: () {},
                      );
                    }
                    return MainBottom(
                      text: 'Confirm Address ',
                      onTap: () {
                        cubit.confirmAddress();
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
