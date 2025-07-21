import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:visual_search/core/theme/app_pallete.dart';
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
    context.read<ProductCubit>().getProducts();
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
                    final products = context.read<ProductCubit>().featured;

                    return CarouselSlider.builder(
                      itemCount: products.length,
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
                                model: products[index],
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
                                    products[index].images[0],
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        products[index].title,
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
                                        decoration: BoxDecoration(
                                          color: AppPallete.gradient2,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  defaultBorderRadious)),
                                        ),
                                        child: Text(
                                          "${products[index].discountRate.toInt()}% off",
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
                            color: AppPallete.borderColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          spacing: 7,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppPallete.subBgColor,
                              ),
                              child: SvgPicture.asset(
                                "assets/icons/Image.svg",
                                color: AppPallete.borderColor,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 5,
                              children: [
                                Container(
                                  width: 100,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: AppPallete.subBgColor,
                                  ),
                                ),
                                Container(
                                  width: 70,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: AppPallete.subBgColor,
                                  ),
                                ),
                              ],
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
                        physics: BouncingScrollPhysics(),
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
                                  color: AppPallete.borderColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 7,
                                children: [
                                  Container(
                                    width: 120,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppPallete.subBgColor,
                                    ),
                                    child: SvgPicture.asset(
                                      "assets/icons/Image.svg",
                                      color: AppPallete.borderColor,
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: AppPallete.subBgColor,
                                    ),
                                  ),
                                  Container(
                                    width: 60,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: AppPallete.subBgColor,
                                    ),
                                  ),
                                  Container(
                                    width: 40,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: AppPallete.subBgColor,
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
