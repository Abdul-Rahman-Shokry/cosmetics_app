import '../data/models/product_model.dart';
import '../data/models/slider_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<SliderModel> sliders;
  final List<ProductModel> products;

  HomeLoaded({
    required this.sliders,
    required this.products,
  });
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}