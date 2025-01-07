import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:talabat_online/model/location_item_model.dart';
import 'package:talabat_online/utils/app_colors.dart';

class LocationIten extends StatelessWidget {
  final VoidCallback onTap;
  final Color backgoundColor;
  final LoactionItemModel location;
  const LocationIten({
    super.key,
    required this.location,
    required this.onTap,
    this.backgoundColor = AppColors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: backgoundColor,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location.city,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      '${location.city}- ${location.country}',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: AppColors.grey,
                          ),
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: backgoundColor,
                      radius: 40,
                    ),
                    CircleAvatar(
                      radius: 36,
                      backgroundImage: CachedNetworkImageProvider(
                        location.imgUrl,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
