import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otex_app/controller/home_state.dart';
import 'package:otex_app/helper/database_helper.dart';
import 'package:otex_app/models/category.dart';
import 'package:otex_app/models/product.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> loadInitialData() async {
    emit(HomeLoading());
    try {
      // Load categories and products
      final categories = await _getCategories();
      final products = await _getProducts();

      emit(HomeLoaded(
        categories: categories,
        products: products,
        selectedCategoryIndex: 0,
      ));
    } catch (e) {
      emit(HomeError('Failed to load data: $e'));
    }
  }

  void selectCategory(int index) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(currentState.copyWith(selectedCategoryIndex: index));

      // Optionally filter products based on selected category
      _filterProductsByCategory(currentState.categories[index].id!);
    }
  }

  void updateSearchQuery(String query) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(currentState.copyWith(searchQuery: query));
      _filterProductsBySearch(query);
    }
  }

  Future<List<Category>> _getCategories() async {
    // Replace with your actual data fetching logic
    final categories = await DatabaseHelper().getAllCategories();
    return Category.categories;
  }

  Future<List<Product>> _getProducts() async {
    // Replace with your actual data fetching logic
    final products = await DatabaseHelper().getAllProducts();
    return products; // Return your actual products
  }

  void _filterProductsByCategory(int categoryId) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      // Implement category-based filtering logic here
      final filteredProducts = await DatabaseHelper().getProductsByCategory(categoryId);
      emit(currentState.copyWith(products: filteredProducts));
    }
  }

  void _filterProductsBySearch(String query) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      // Implement search filtering logic here
      // final filteredProducts = ...;
      // emit(currentState.copyWith(products: filteredProducts));
    }
  }

  // Get filtered products based on current state
  List<Product> get filteredProducts {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      // Add your filtering logic here
      return currentState.products;
    }
    return [];
  }
}
