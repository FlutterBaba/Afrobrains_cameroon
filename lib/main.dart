import 'package:afrobrains_cameroon/provider/category_product.dart';
import 'package:afrobrains_cameroon/provider/firebase_data_provider.dart';
import 'package:afrobrains_cameroon/provider/product_data.dart';
import 'package:afrobrains_cameroon/screen/homescreen.dart';
import 'package:afrobrains_cameroon/screen/intro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FirebaseDataProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (contex, userSnapshot) {
            if (userSnapshot.hasData) {
              return HomePage();
            }
            return IntroScreen();
          },
        ),
      ),
    );
  }
}

