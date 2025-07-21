import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:visual_search/features/classifier/presentation/cubit/classifier_cubit.dart';
import 'package:visual_search/features/products/presentation/cubit/product_cubit.dart';

import '../../../../core/common/widgets/flickering_opacity.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../products/presentation/widgets/product_card.dart';
import '../../../products/presentation/widgets/product_detail_page.dart';
import '../cubit/classifier_state.dart';

class VisualSearchPage extends StatefulWidget {
  final String categoryName;
  final String color;
  final String pattern;
  const VisualSearchPage({
    super.key,
    required this.categoryName,
    required this.color,
    required this.pattern,
  });

  @override
  State<VisualSearchPage> createState() => _VisualSearchPageState();
}

class _VisualSearchPageState extends State<VisualSearchPage> {
  @override
  void initState() {
    super.initState();
    if (widget.pattern == "Solid") {
      context
          .read<ProductCubit>()
          .visualSearchByName(widget.categoryName, widget.color);
    } else {
      context.read<ProductCubit>().visualSearchByCategoryAndPattern(
          widget.categoryName, widget.pattern);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Flexible(
              child: Text(
                "Visual Search",
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          spacing: 10,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                BlocBuilder<ClassifierCubit, ClassifierState>(
                  builder: (context, state) {
                    if (state is ClassifierSuccess) {
                      return Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        child: Image.file(
                          state.imageFile,
                          height: 60,
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Category: "),
                        AnimatedTextKit(
                            isRepeatingAnimation: false,
                            animatedTexts: [
                              TypewriterAnimatedText(
                                widget.categoryName,
                                speed: Duration(milliseconds: 200),
                              ),
                            ])
                      ],
                    ),
                    if (widget.pattern == "Solid")
                      Row(
                        children: [
                          Text("Color: "),
                          AnimatedTextKit(
                              isRepeatingAnimation: false,
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  widget.color,
                                  speed: Duration(milliseconds: 200),
                                ),
                              ])
                        ],
                      ),
                    Row(
                      children: [
                        Text("Pattern: "),
                        AnimatedTextKit(
                            isRepeatingAnimation: false,
                            animatedTexts: [
                              TypewriterAnimatedText(
                                widget.pattern,
                                speed: Duration(milliseconds: 200),
                              ),
                            ])
                      ],
                    ),
                  ],
                )
              ],
            ),
            Flexible(
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductVisualData) {
                    if (state.products.isNotEmpty) {
                      return GridView.builder(
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 0.88),
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
                    } else {
                      return Center(
                        child: Text(
                            "Could not find products with requested query"),
                      );
                    }
                  }
                  return Shimmer(
                    duration: Duration(seconds: 2),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: AppPallete.borderColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 5,
                        children: [
                          FlickeringOpacity(
                            duration: Duration(milliseconds: 500),
                            child: Image.asset(
                              "assets/images/logo.png",
                              fit: BoxFit.fitHeight,
                              height: 70,
                            ),
                          ),
                          Text("Searching..."),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
