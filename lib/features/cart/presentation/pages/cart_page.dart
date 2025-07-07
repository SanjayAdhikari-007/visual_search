import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_search/features/cart/presentation/bloc/cart_bloc.dart';

import '../../../products/presentation/widgets/product_card.dart';
import '../../../products/presentation/widgets/product_detail_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoaded && state.itemCount != 0) {
            return ListView.builder(
              itemCount: state.itemCount,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                var model = state.items.values.toList()[index].product;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 5.0),
                  child: AspectRatio(
                    aspectRatio: 1.7,
                    child: Row(
                      spacing: 2,
                      children: [
                        Expanded(
                          child: ProductCard(
                            model: model,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProductDetailPage(
                                  model: model,
                                ),
                              ));
                            },
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  context
                                      .read<CartCubit>()
                                      .removeSingleItem(model.id);
                                },
                                icon: Icon(Icons.delete)),
                            Text(
                                "x ${state.items[model.id]!.quantity.toString()}")
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Center(child: Text("Cart is empty."));
        },
      ),
    );
  }
}
