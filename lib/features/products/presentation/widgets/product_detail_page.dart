import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:visual_search/features/discover/presentation/cubit/discover_cubit.dart';
import 'package:visual_search/features/products/data/models/product_model.dart';

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
                  color: Colors.blue, borderRadius: BorderRadius.circular(6)),
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
                  InkWell(
                    onTap: () {
                      context.read<CartCubit>().addItem(model);
                    },
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.lightBlue,
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
                  color: Colors.blue, borderRadius: BorderRadius.circular(6)),
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
                spacing: 20,
                children: [
                  Text(
                    model.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 18),
                  ),
                  Text(" | "),
                  Text(
                    "${context.read<DiscoverCubit>().categoryFromId(model.category).name} ",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 18),
                  ),
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
                        color: Colors.green,
                      ),
                      child: Text("Available in Stock"),
                    ),
                  if (!model.isInStock)
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.red,
                      ),
                      child: Text("Out of Stock"),
                    ),
                ],
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
                    model.createdAt,
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
