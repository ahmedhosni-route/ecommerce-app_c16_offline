import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/core/services/dio_service.dart';
import 'package:ecommerce_app/features/products_screen/data/data_source/data_source.dart';
import 'package:ecommerce_app/features/products_screen/data/data_source/data_source_imp.dart';
import 'package:ecommerce_app/features/products_screen/data/repo/repo.dart';
import 'package:ecommerce_app/features/products_screen/presentation/manager/product_cubit.dart';
import 'package:ecommerce_app/features/products_screen/presentation/widgets/custom_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/get_it.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/widget/home_screen_app_bar.dart';
import '../../../main_layout/data/models/category_response.dart';

class ProductsScreen extends StatelessWidget {
  final CategoryModel category;
  const ProductsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => getIt<ProductCubit>()..getProducts(category.id!),
      child: Scaffold(
        appBar: const HomeScreenAppBar(
          automaticallyImplyLeading: true,
        ),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      itemCount: state.getProductState?.data?.length??0,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 7 / 9,
                      ),
                      itemBuilder: (context, index) {
                        var product = state.getProductState!.data![index];
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.productDetails,arguments: product);
                          },
                          child: CustomProductWidget(
                            image: product.imageCover,
                            title: product.title,
                            price: product.price.toDouble(),
                            rating: product.ratingsAverage.toDouble(),
                            discountPercentage: 10,
                            height: height,
                            width: width,
                            description: product.description
                          ),
                        );
                      },
                      scrollDirection: Axis.vertical,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
