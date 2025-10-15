import 'package:otex_app/models/category.dart';
import 'package:otex_app/models/product.dart';

// States
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Category> categories;
  final List<Product> products;
  final int selectedCategoryIndex;
  final String searchQuery;

  HomeLoaded({
    required this.categories,
    required this.products,
    this.selectedCategoryIndex = 0,
    this.searchQuery = '',
  });

  HomeLoaded copyWith({
    List<Category>? categories,
    List<Product>? products,
    int? selectedCategoryIndex,
    String? searchQuery,
  }) {
    return HomeLoaded(
      categories: categories ?? this.categories,
      products: products ?? this.products,
      selectedCategoryIndex: selectedCategoryIndex ?? this.selectedCategoryIndex,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
