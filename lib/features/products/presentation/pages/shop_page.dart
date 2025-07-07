import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:visual_search/features/products/presentation/cubit/product_cubit.dart';
import 'package:visual_search/features/products/presentation/widgets/product_card.dart';

import '../../../../core/constants/constants.dart';
import '../widgets/product_detail_page.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ProductCubit>().getPerCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductData) {
                    return CarouselSlider.builder(
                      itemCount: state.products.length,
                      options: CarouselOptions(
                        height: 200.0,
                        autoPlay: true,
                        enlargeCenterPage: true,
                      ),
                      itemBuilder: (context, index, realIndex) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProductDetailPage(
                                model: state.products[index],
                              ),
                            ));
                          },
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Flexible(
                                  child: Image.network(
                                    state.products[index].images[0],
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        state.products[index].title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontSize: 16,
                                                color: Colors.black),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: defaultPadding / 2),
                                        height: 16,
                                        decoration: const BoxDecoration(
                                          color: errorColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  defaultBorderRadious)),
                                        ),
                                        child: Text(
                                          "${state.products[index].discountRate.toInt()}% off",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return CarouselSlider.builder(
                    itemCount: 3,
                    options: CarouselOptions(
                      height: 200.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                    ),
                    itemBuilder: (context, index, realIndex) {
                      return Shimmer(
                          child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 7,
                          children: [
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white24,
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.white24,
                              ),
                            ),
                            Container(
                              width: 60,
                              height: 12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.white24,
                              ),
                            ),
                            Container(
                              width: 40,
                              height: 12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.white24,
                              ),
                            ),
                          ],
                        ),
                      ));
                    },
                  );
                },
              ),
              Text(
                "Popular Products",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 18),
              ),
              SizedBox(
                height: 400,
                width: MediaQuery.of(context).size.width,
                child: BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    if (state is ProductData) {
                      return GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 1.5),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            model: state.products[index],
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProductDetailPage(
                                  model: state.products[index],
                                ),
                              ));
                            },
                          );
                        },
                      );
                    }
                    return Shimmer(
                      child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 1.5),
                          itemCount: 6,
                          itemBuilder: (context, snapshot) {
                            return Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white30,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 7,
                                children: [
                                  Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white24,
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.white24,
                                    ),
                                  ),
                                  Container(
                                    width: 60,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.white24,
                                    ),
                                  ),
                                  Container(
                                    width: 40,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.white24,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
