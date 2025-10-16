import 'package:otex_app/models/category.dart';
import 'package:otex_app/models/product.dart';

// States
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

class ProductsHomeLoading extends HomeState {}

class ProductsHomeLoaded extends HomeState {
  final List<Product> products;
  ProductsHomeLoaded(this.products);
}

class ProductsHomeError extends HomeState {
  final String message;
  ProductsHomeError(this.message);
}

class ProductsHomeEmpty extends HomeState {}

class CategoriesHomeLoading extends HomeState {}

class CategoriesHomeLoaded extends HomeState {
  final List<Category> categories;
  CategoriesHomeLoaded(this.categories);
}

class CategoriesHomeError extends HomeState {
  final String message;
  CategoriesHomeError(this.message);
}

class CategoriesHomeEmpty extends HomeState {}

class FilterProductsHomeLoading extends HomeState {}

class FilterProductsHomeLoaded extends HomeState {
  final List<Product> products;
  FilterProductsHomeLoaded(this.products);
}

class FilterProductsHomeError extends HomeState {
  final String message;
  FilterProductsHomeError(this.message);
}

class FilterProductsHomeEmpty extends HomeState {}
