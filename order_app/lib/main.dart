import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/ui/bloc/basket_cubit.dart';
import 'package:order_app/ui/bloc/home_cubit.dart';
import 'package:order_app/ui/bloc/login_cubit.dart';
import 'package:order_app/ui/bloc/onboard_cubit.dart';
import 'package:order_app/ui/bloc/registration_cubit.dart';
import 'package:order_app/ui/views/home.dart';
import 'package:order_app/ui/views/login.dart';
import 'package:order_app/ui/views/onboard.dart';
import 'package:order_app/ui/views/splash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => BasketCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegistrationCubit()),
        BlocProvider(create: (context) => OnboardCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Home(),
      ),
    );
  }
}
