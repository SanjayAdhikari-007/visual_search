part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductData extends ProductState {
  final List<ProductModel> products;

  ProductData(this.products);
}

final class ProductVisualData extends ProductState {
  final List<ProductModel> products;

  ProductVisualData(this.products);
}

final class ProductSingleData extends ProductState {
  final ProductModel data;

  ProductSingleData(this.data);
}
