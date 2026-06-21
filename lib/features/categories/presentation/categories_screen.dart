import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_image.dart';
import '../logic/categories_cubit.dart';
import '../logic/categories_state.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesCubit()..getCategories(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                Text(
                  "Categories",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 24),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Icon(
                        Icons.search,
                        color: AppColors.secondaryText,
                        size: 28,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 18.0,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: AppColors.searchBoxBorder,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: AppColors.searchBoxBorder,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Expanded(
                  child: BlocBuilder<CategoriesCubit, CategoriesState>(
                    builder: (context, state) {
                      if (state is CategoriesLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is CategoriesError) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else if (state is CategoriesLoaded) {
                        return ListView.separated(
                          itemCount: state.categories.length,
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: Color(0xFFB3B3C1),
                              thickness: 0.5,
                              height: 30,
                            );
                          },
                          itemBuilder: (context, index) {
                            final category = state.categories[index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: AppImage(
                                  category.imageUrl,
                                  width: 64,
                                  height: 69,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                category.titleEn,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryText,
                                ),
                              ),
                              trailing: const Icon(
                                Icons.arrow_right,
                                color: AppColors.primaryText,
                                size: 35,
                              ),
                              onTap: () {},
                            );
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}