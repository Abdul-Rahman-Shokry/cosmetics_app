import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/api_error_handler.dart';
import '../../../../core/network/api_helper.dart';
import '../data/models/category_model.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  List<CategoryModel> categories = [];

  Future<void> getCategories() async {
    emit(CategoriesLoading());
    try {
      final response = await ApiHelper.dio.get('/api/Categories');
      final List data = response.data;
      categories = data.map((e) => CategoryModel.fromJson(e)).toList();
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(CategoriesError(ApiErrorHandler.getMessage(e)));
    }
  }
}