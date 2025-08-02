import 'package:e_commerce/bloc/auth/auth_bloc.dart';
import 'package:e_commerce/routes/app_routes.dart';
import 'package:e_commerce/ui/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://qjqgnzmkxiwrboqgoxyo.supabase.co', // Replace with your project URL
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFqcWduem1reGl3cmJvcWdveHlvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTM5NzU3NTIsImV4cCI6MjA2OTU1MTc1Mn0.2OdsyZWoaihx3Je2O0aPNBaGGGcuzEWCYkCvjIwkdCA',            // Replace with your anon key
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(),)
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
        appBarTheme: AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 16,
            color: Colors.black
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            textStyle: WidgetStatePropertyAll(TextStyle(
              color: Colors.white
            )),
            backgroundColor: WidgetStatePropertyAll(Colors.red),
          )
        )
      ),
      initialRoute: AppRouter.login,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
