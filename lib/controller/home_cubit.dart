import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otex_app/controller/home_state.dart';
import 'package:otex_app/helper/database_helper.dart';
import 'package:otex_app/models/category.dart';
import 'package:otex_app/models/product.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<Category> _categories = [];
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  int _selectedCategoryIndex = 0;

  Future<void> loadInitialData() async {
    emit(HomeLoading());
    try {
      await Future.wait([loadCategories(), loadProducts()]);
      _emitCombinedState();
    } catch (e) {
      emit(HomeError('Failed to load data: $e'));
    }
  }

  Future<void> loadCategories() async {
    emit(CategoriesHomeLoading());
    try {
      _categories = await DatabaseHelper().getAllCategories();
      if (_categories.isEmpty) {
        emit(CategoriesHomeEmpty());
      } else {
        emit(CategoriesHomeLoaded(_categories));
      }
    } catch (e) {
      emit(CategoriesHomeError('Failed to load categories: $e'));
    }
  }

  Future<void> loadProducts() async {
    emit(ProductsHomeLoading());
    try {
      _allProducts = await DatabaseHelper().getAllProducts();
      _filteredProducts = List.from(_allProducts);

      if (_allProducts.isEmpty) {
        emit(ProductsHomeEmpty());
      } else {
        emit(ProductsHomeLoaded(_filteredProducts));
      }
    } catch (e) {
      emit(ProductsHomeError('Failed to load products: $e'));
    }
  }

  void selectCategory(int index) {
    if (index >= 0 && index < _categories.length) {
      _selectedCategoryIndex = index;
      _filterProducts();
    }
  }

  void _filterProducts() async {
    emit(FilterProductsHomeLoading());
    try {
      List<Product> filtered = List.from(_allProducts);
      if (_selectedCategoryIndex > 0) {
        final categoryId = _categories[_selectedCategoryIndex].id;
        filtered = filtered.where((product) => product.categoryId == categoryId).toList();
      }
      _filteredProducts = filtered;
      if (filtered.isEmpty) {
        emit(FilterProductsHomeEmpty());
      } else {
        emit(FilterProductsHomeLoaded(filtered));
      }
    } catch (e) {
      emit(FilterProductsHomeError('Failed to filter products: $e'));
    }
  }

  void _emitCombinedState() {
    if (_filteredProducts.isNotEmpty) {
      emit(ProductsHomeLoaded(_filteredProducts));
    } else {
      emit(ProductsHomeEmpty());
    }
  }

  List<Category> get categories => _categories;
  List<Product> get filteredProducts => _filteredProducts;
  List<Product> get allProducts => _allProducts;
  int get selectedCategoryIndex => _selectedCategoryIndex;

  Future<void> refreshCategories() async {
    await loadCategories();
  }

  Future<void> refreshProducts() async {
    await loadProducts();
    _filterProducts();
  }
}
