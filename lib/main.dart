import 'package:e_commerce/bloc/auth/auth_bloc.dart';
import 'package:e_commerce/bloc/cart/cart_bloc.dart';
import 'package:e_commerce/bloc/cart/cart_event.dart';
import 'package:e_commerce/bloc/home/home_bloc.dart';
import 'package:e_commerce/bloc/home/home_event.dart';
import 'package:e_commerce/bloc/nav/nav_bloc.dart';
import 'package:e_commerce/helper/shared_preferences_helper.dart';
import 'package:e_commerce/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://qjqgnzmkxiwrboqgoxyo.supabase.co', // Replace with your project URL
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFqcWduem1reGl3cmJvcWdveHlvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTM5NzU3NTIsImV4cCI6MjA2OTU1MTc1Mn0.2OdsyZWoaihx3Je2O0aPNBaGGGcuzEWCYkCvjIwkdCA',            // Replace with your anon key
  );
  await SharedPreferencesHelper.initializeSharedPreferences();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(),),
        BlocProvider(create: (_) => NavigationBloc(),),
        BlocProvider(create: (_) => HomeBloc()..add(LoadProducts()),),
        BlocProvider(create: (_) => CartBloc()..add(LoadCartProducts()))
      ],
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primaryColor: Colors.redAccent,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 16,
            color: Colors.black
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        scaffoldBackgroundColor: Colors.white,
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            textStyle: WidgetStatePropertyAll(TextStyle(
              color: Colors.white
            )),
            backgroundColor: WidgetStatePropertyAll(Colors.red),
          )
        )
      ),
      initialRoute: AppRouter.nav,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
