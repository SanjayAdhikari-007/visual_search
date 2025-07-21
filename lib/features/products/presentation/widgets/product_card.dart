import 'package:flutter/material.dart';
import 'package:visual_search/core/theme/app_pallete.dart';
import 'package:visual_search/features/products/data/models/product_model.dart';

import '../../../../core/constants/constants.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.model, required this.onPressed});
  final ProductModel model;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppPallete.borderColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppPallete.subBgColor,
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(model.images[0]))),
                ),
                if (model.discountRate != 0)
                  Positioned(
                    right: defaultPadding / 2,
                    top: defaultPadding / 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2),
                      height: 16,
                      decoration: BoxDecoration(
                        color: AppPallete.gradient2,
                        borderRadius: BorderRadius.all(
                            Radius.circular(defaultBorderRadious)),
                      ),
                      child: Text(
                        "${model.discountRate.toInt()}% off",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
              ],
            ),
            Text(
              model.brandName,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 12),
            ),
            Text(
              model.title,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                  ),
            ),
            model.discountRate != 0
                ? Row(
                    children: [
                      Text(
                        "\$${model.priceAfterDiscount}",
                        style: const TextStyle(
                          color: Color(0xFF31B0D8),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: defaultPadding / 4),
                      Flexible(
                        child: Text(
                          "\$${model.price}",
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color,
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  )
                : Text(
                    "\$${model.price}",
                    style: const TextStyle(
                      color: Color(0xFF31B0D8),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
