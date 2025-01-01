import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:talabat_online/model/prudact_item_model.dart';
import 'package:talabat_online/utils/app_colors.dart';

class PrudactItem extends StatelessWidget {
  final PrudactItemModel prudactItemModel;
  const PrudactItem({
    super.key,
    required this.prudactItemModel,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.grey2,
              ),
              height: size.height * 0.13,
              width: size.height * 0.3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: prudactItemModel.imgUrl,
                  progressIndicatorBuilder: (context, url, downloadProgress) {
                    return Center(child: CircularProgressIndicator.adaptive());
                  },
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Positioned(
              top: 3,
              right: 3,
              child: Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(33),
                  color: AppColors.grey4,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_border,
                    color: AppColors.withe,
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              prudactItemModel.name,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Text(
              prudactItemModel.category,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.grey,
                  ),
            ),
            Text(
              '\$${prudactItemModel.price}',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        )
      ],
    );
  }
}
