import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/widget/home_screen_app_bar.dart';
import 'package:ecommerce_app/features/main_layout/categories/presentation/categories_tab.dart';
import 'package:ecommerce_app/features/main_layout/favourite/presentation/favourite_screen.dart';
import 'package:ecommerce_app/features/main_layout/manager/main_cubit.dart';
import 'package:ecommerce_app/features/main_layout/profile_tab/presentation/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/config/get_it.dart';
import 'home/presentation/home_tab.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;
  List<Widget> tabs = [
    const HomeTab(),
    const CategoriesTab(),
    const FavouriteScreen(),
    const ProfileTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MainCubit>()..getCategory()..getFav(),
      child: Scaffold(
        appBar: const HomeScreenAppBar(),
        extendBody: false,
        body: tabs[currentIndex],
        bottomNavigationBar: Container(
          height: 90,
          padding: EdgeInsets.only(top: 10),
          margin: EdgeInsets.only(bottom: 30, left: 10, right: 10),
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(25)),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) => changeSelectedIndex(value),
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            selectedFontSize: 1,
            selectedItemColor: ColorManager.primary,
            unselectedItemColor: ColorManager.white,
            showSelectedLabels: false, // Hide selected item labels
            showUnselectedLabels: false, // Hide unselected item labels
            items: [
              // Build BottomNavigationBarItem widgets for each tab
              CustomBottomNavBarItem(IconsAssets.icHome, "Home"),
              CustomBottomNavBarItem(IconsAssets.icCategory, "Category"),
              CustomBottomNavBarItem(IconsAssets.icWithList, "WishList"),
              CustomBottomNavBarItem(IconsAssets.icProfile, "Profile"),
            ],
          ),
        ),
      ),
    );
  }

  changeSelectedIndex(int selectedIndex) {
    setState(() {
      currentIndex = selectedIndex;
    });
  }
}

class CustomBottomNavBarItem extends BottomNavigationBarItem {
  String iconPath;
  String title;
  CustomBottomNavBarItem(this.iconPath, this.title)
      : super(
          label: title,
          icon: ImageIcon(
            AssetImage(iconPath), // Inactive icon image
            color: ColorManager.white, // Inactive icon color
          ),
          activeIcon: CircleAvatar(
            backgroundColor: ColorManager.white, // Background of active icon
            child: ImageIcon(
              AssetImage(iconPath),
              color: ColorManager
                  .primary, // Active icon imagecolor: ColorManager.primary, // Active icon color
            ),
          ),
        );
}
