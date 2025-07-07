part of 'discover_cubit.dart';

@immutable
sealed class DiscoverState {}

final class DiscoverInitial extends DiscoverState {}

final class DiscoverData extends DiscoverState {
  final List<CategoryModel> categories;

  DiscoverData(this.categories);
}

final class DiscoverSingleData extends DiscoverState {
  final CategoryModel data;

  DiscoverSingleData(this.data);
}
