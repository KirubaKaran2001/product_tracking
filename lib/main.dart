import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:product_tracking/hive/hive_class.dart';
import 'package:product_tracking/screens/add_po_form.dart';
import 'package:product_tracking/screens/home_screen.dart';

import 'screens/edit_po_form.dart';
import 'screens/splash_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductDetailsAdapter());
  await Hive.openBox<ProductDetails>('products');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings settings) {
        debugPrint('build route for ${settings.name}');
        var routes = <String, WidgetBuilder>{
          '/splash': (BuildContext context) => const SplashScreen(),
          '/home': (BuildContext context) => const HomeScreen(),
          '/addPO': (BuildContext context) => const AddPOForm(),

        };
        WidgetBuilder builder = routes[settings.name]!;
        return MaterialPageRoute(
          builder: (ctx) => builder(ctx),
        );
      }
    );
  }
}
