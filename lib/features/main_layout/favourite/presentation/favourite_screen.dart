import 'package:ecommerce_app/core/resources/constants_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/features/main_layout/favourite/presentation/widgets/favourite_item.dart';
import 'package:ecommerce_app/features/main_layout/manager/main_cubit.dart';
import 'package:ecommerce_app/features/products_screen/presentation/manager/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late MainCubit cubit;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppSize.s14.w, vertical: AppSize.s10.h),
            child: ListView.builder(
              itemCount: state.getFavState?.data?.length ?? 0,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSize.s12.h),
                  child: FavoriteItem(product: state.getFavState!.data![index]),
                );
              },
            ));
      },
    );
  }
}
