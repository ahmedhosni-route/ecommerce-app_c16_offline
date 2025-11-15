import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/features/main_layout/categories/presentation/widgets/category_card_item.dart';
import 'package:ecommerce_app/features/main_layout/manager/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sub_category_item.dart';

class SubCategoriesList extends StatelessWidget {
  const SubCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: <Widget>[
              // category title
              SliverToBoxAdapter(
                child: Text(
                  'Laptops & Electronics',
                  style: getBoldStyle(
                      color: ColorManager.primary, fontSize: FontSize.s14),
                ),
              ),
              // the category card
              SliverToBoxAdapter(
                child: CategoryCardItem("Laptops & Electronics",
                    ImageAssets.categoryCardImage,
                    (){}),
              ),
              // the grid view of the subcategories
              SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.getCategoryState?.data?.length??0,
                        (context, index) {
                      var item  = state.getCategoryState!.data![index];
                          return SubCategoryItem(
                              item.name??'',
                              item.image??"",
                              (){
                                Navigator.pushNamed(context, Routes.productsScreenRoute,arguments: item);
                              });
                        },
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.75,
                    mainAxisSpacing: AppSize.s8,
                    crossAxisSpacing: AppSize.s8,
                  ))
            ],
          );
        },
      ),
    );
  }


}
