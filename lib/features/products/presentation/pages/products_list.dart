import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_search/features/discover/data/models/category_model.dart';
import 'package:visual_search/features/products/presentation/cubit/product_cubit.dart';

import '../widgets/product_card.dart';
import '../widgets/product_detail_page.dart';

class ProductsListPage extends StatefulWidget {
  final CategoryModel categoryModel;
  const ProductsListPage({super.key, required this.categoryModel});

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<ProductCubit>()
        .getAllProductsByCategory(widget.categoryModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryModel.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductData) {
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
