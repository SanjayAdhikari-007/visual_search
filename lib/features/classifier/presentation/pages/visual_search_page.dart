import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_search/core/common/color_print/color_print.dart';
import 'package:visual_search/features/classifier/presentation/cubit/classifier_cubit.dart';
import 'package:visual_search/features/products/presentation/cubit/product_cubit.dart';

import '../../../products/presentation/widgets/product_card.dart';
import '../../../products/presentation/widgets/product_detail_page.dart';
import '../cubit/classifier_state.dart';

class VisualSearchPage extends StatefulWidget {
  final String categoryName;
  final String color;
  const VisualSearchPage({
    super.key,
    required this.categoryName,
    required this.color,
  });

  @override
  State<VisualSearchPage> createState() => _VisualSearchPageState();
}

class _VisualSearchPageState extends State<VisualSearchPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<ProductCubit>()
        .visualSearchByName(widget.categoryName, widget.color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            BlocBuilder<ClassifierCubit, ClassifierState>(
              builder: (context, state) {
                if (state is ClassifierSuccess) {
                  printG(state.imageFile.path);
                  return Container(
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: Image.file(
                      state.imageFile,
                      height: 30,
                    ),
                  );
                }
                return Container();
              },
            ),
            Flexible(
              child: Text(
                " Visual Search: ${widget.categoryName} ${widget.color}  jfjsfjdsjfjf f ifisji fjfi ojfo j f",
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductVisualData) {
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
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
