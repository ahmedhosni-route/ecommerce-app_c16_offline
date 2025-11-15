import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/widget/custom_elevated_button.dart';
import 'package:ecommerce_app/features/products_screen/domain/entity/product_entity.dart';
import 'package:ecommerce_app/features/products_screen/presentation/manager/product_cubit.dart';
import 'package:ecommerce_app/features/products_screen/presentation/widgets/product_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/get_it.dart';
import '../../../../core/widget/product_counter.dart';
import '../widgets/product_description.dart';
import '../widgets/product_item.dart';
import '../widgets/product_label.dart';
import '../widgets/product_rating.dart';
import '../widgets/product_size.dart';
import '../widgets/product_slider.dart';

class ProductDetails extends StatelessWidget {
  final ProductEntity product;

  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductCubit>(),
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          var cubit = context.watch<ProductCubit>();
          return Scaffold(
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Total price',
                          style: getMediumStyle(
                                  color: ColorManager.primary.withOpacity(.6))
                              .copyWith(fontSize: 18.sp),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        ValueListenableBuilder(
                          valueListenable: product.qut,
                          builder: (context, value, child) {
                            return Text('EGP ${product.price * value}',
                                style: getMediumStyle(
                                        color: ColorManager.appBarTitleColor)
                                    .copyWith(fontSize: 18.sp));
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      width: 33.w,
                    ),
                    Expanded(
                      child: CustomElevatedButton(
                        label: 'Add to cart',
                        onTap: () {},
                        prefixIcon: Icon(
                          Icons.add_shopping_cart_outlined,
                          color: ColorManager.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Product Details',
                style: getMediumStyle(color: ColorManager.appBarTitleColor)
                    .copyWith(fontSize: 20.sp),
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: ImageIcon(
                      AssetImage(IconsAssets.icSearch),
                      color: ColorManager.primary,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: ColorManager.primary,
                    )),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 50.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductSlider(
                          items: product.images.map(
                            (e) {
                              return ProductItem(imageUrl: e,onTap: () {
                               cubit.addFav(product.id);
                              },);
                            },
                          ).toList(),
                          initialIndex: 0),
                      SizedBox(
                        height: 24.h,
                      ),
                      ProductLabel(
                          productName: product.title,
                          productPrice: 'EGP ${product.price}'),
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ProductRating(
                                productBuyers: '${product.sold}',
                                productRating:
                                    '${product.ratingsAverage} (${product.ratingsQuantity})'),
                          ),
                          ValueListenableBuilder(
                            valueListenable: product.qut,
                            builder: (context, value, child) {
                              return ProductCounter(
                                  add: (_) {
                                    product.qut.value++;
                                  },
                                  remove: (_) {
                                    if (value > 1) {
                                      product.qut.value--;
                                    }
                                  },
                                  productCounter: value.toInt());
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      ProductDescription(
                          productDescription: product.description),
                      //     ProductSize(
                      //   size: const [35, 38, 39, 40],
                      //   onSelected: () {},
                      // ),
                      // SizedBox(
                      //   height: 20.h,
                      // ),
                      // Text('Color',
                      //     style: getMediumStyle(color: ColorManager.appBarTitleColor)
                      //         .copyWith(fontSize: 18.sp)),
                      // ProductColor(color: const [
                      //   Colors.red,
                      //   Colors.blueAccent,
                      //   Colors.green,
                      //   Colors.yellow,
                      // ], onSelected: () {}),
                      SizedBox(
                        height: 48.h,
                      ),
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
