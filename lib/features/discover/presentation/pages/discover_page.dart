import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/flickering_opacity.dart';
import '../../../products/presentation/pages/products_list.dart';
import '../cubit/discover_cubit.dart';

class DiscoverPage extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const DiscoverPage(),
      );
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover Products"),
      ),
      body: BlocBuilder<DiscoverCubit, DiscoverState>(
        builder: (context, state) {
          if (state is DiscoverData) {
            return ListView.builder(
              itemCount: state.categories.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProductsListPage(
                      categoryModel: state.categories[index],
                    ),
                  ));
                },
                title: Text(state.categories[index].name),
                trailing: Icon(Icons.arrow_circle_right_outlined),
              ),
            );
          }

          return Center(
            child: FlickeringOpacity(
              duration: Duration(milliseconds: 500),
              child: Text("Loading..."),
            ),
          );
        },
      ),
    );
  }
}
