import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/api_error_handler.dart';
import '../../../../core/network/api_helper.dart';
import '../data/models/slider_model.dart';
import '../data/models/product_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<SliderModel> sliders = [];
  List<ProductModel> products = [];

  Future<void> getHomeData() async {
    emit(HomeLoading());
    try {
      final responses = await Future.wait([
        ApiHelper.dio.get('/api/Sliders'),
        ApiHelper.dio.get('/api/Products'),
      ]);

      final List slidersData = responses[0].data;
      sliders = slidersData.map((e) => SliderModel.fromJson(e)).toList();

      final List productsData = responses[1].data;
      products = productsData.map((e) => ProductModel.fromJson(e)).toList();

      emit(HomeLoaded(sliders: sliders, products: products));
    } catch (e) {
      emit(HomeError(ApiErrorHandler.getMessage(e)));
    }
  }
}