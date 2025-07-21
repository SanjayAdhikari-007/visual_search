import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:visual_search/core/theme/app_pallete.dart';
import 'package:visual_search/features/discover/presentation/cubit/discover_cubit.dart';
import 'package:visual_search/features/products/data/models/product_model.dart';

import '../../../../core/constants/constants.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import 'product_images.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel model;
  const ProductDetailPage({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: model.isInStock
          ? Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: AppPallete.buttonBlueColor,
                  borderRadius: BorderRadius.circular(6)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        spacing: 5,
                        children: [
                          Text("\$${model.priceAfterDiscount}"),
                          if (model.discountRate != 0)
                            Text("\$${model.price}",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color!
                                      .withValues(alpha: 0.7),
                                  fontSize: 14,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color!
                                      .withValues(alpha: 0.7),
                                  overflow: TextOverflow.ellipsis,
                                )),
                        ],
                      ),
                      Row(
                        spacing: 5,
                        children: [
                          Text("Unit Price"),
                          if (model.discountRate != 0)
                            Container(
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
                            )
                        ],
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Fluttertoast.showToast(
                        msg: "${model.title} added to cart",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        backgroundColor: AppPallete.buttonBlueColor,
                        textColor: Colors.black,
                        fontSize: 16.0,
                      );
                      context.read<CartCubit>().addItem(model);
                    },
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 20, 96, 141),
                            borderRadius: BorderRadius.circular(6)),
                        child: Text("Add to Cart")),
                  )
                ],
              ),
            )
          : Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: AppPallete.gradient2,
                  borderRadius: BorderRadius.circular(6)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("\$${model.priceAfterDiscount}"),
                      Text("Unit Price"),
                    ],
                  ),
                ],
              ),
            ),
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 6,
            children: [
              ProductImages(
                images: model.images,
              ),
              Text(
                model.brandName,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 16),
              ),
              Row(
                spacing: 15,
                children: [
                  Text(
                    model.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 18),
                  ),
                  Text("|"),
                  Text(
                    "${context.read<DiscoverCubit>().categoryFromId(model.category)?.name} ",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 18),
                  ),
                  if (model.isFeatured)
                    Row(
                      spacing: 15,
                      children: [
                        Text("|"),
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppPallete.gradient2,
                          ),
                          child: Text("Featured"),
                        ),
                      ],
                    )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (model.isInStock)
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppPallete.buttonBlueColor,
                      ),
                      child: Text("Available in Stock"),
                    ),
                  if (!model.isInStock)
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppPallete.gradient2,
                      ),
                      child: Text("Out of Stock"),
                    ),
                ],
              ),
              if (model.pattern == "Solid")
                Text(
                  "Color: ${model.color}",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontSize: 14),
                ),
              Text(
                "Pattern: ${model.pattern}",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: 14),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(
                    strokeAlign: 2,
                    color: Colors.white30,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  model.detail,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 13),
                ),
              ),
              RatingStars(
                maxValue: 5,
                value: model.rating,
                maxValueVisibility: false,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 10,
                children: [
                  Text("Created At:",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 13)),
                  Text(
                    DateFormat("d MMM, yyyy")
                        .format(DateTime.parse(model.createdAt)),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
