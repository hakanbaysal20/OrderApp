import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/ui/cubit/basket_cubit.dart';
import 'package:order_app/ui/cubit/favorite_cubit.dart';
import 'package:order_app/ui/cubit/home_cubit.dart';
import 'package:order_app/ui/cubit/login_cubit.dart';
import 'package:order_app/ui/cubit/onboard_cubit.dart';
import 'package:order_app/ui/cubit/product_details_cubit.dart';
import 'package:order_app/ui/cubit/profile_cubit.dart';
import 'package:order_app/ui/cubit/registration_cubit.dart';
import 'package:order_app/ui/cubit/splash_cubit.dart';
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
        BlocProvider(create: (context) => ProductDetailsCubit()),
        BlocProvider(create: (context) => SplashCubit()),
        BlocProvider(create: (context) => FavouriteCubit(),),
        BlocProvider(create: (context) => ProfileCubit(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Splash(),
      ),
    );
  }
}
