import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:ecommerce_app/features/main_layout/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/config/get_it.dart';
import 'core/routes_manager/route_generator.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");
  runApp(MainApp(token: token));
}

class MainApp extends StatelessWidget {
  String? token;
  MainApp({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: child,
        onGenerateRoute: RouteGenerator.getRoute,
        onGenerateInitialRoutes: (initialRoute) {
          return token == null
              ? [
                  MaterialPageRoute(
                    builder: (context) {
                      return SignInScreen();
                    },
                  )
                ]
              : [
                  MaterialPageRoute(builder: (context) {
                    return MainLayout();
                  })
                ];
        },
        // initialRoute: Routes.signInRoute,
      ),
    );
  }
}
