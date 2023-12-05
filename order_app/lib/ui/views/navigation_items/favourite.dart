import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/entity/favourite_model.dart';
import 'package:order_app/ui/bloc/favourite_cubit.dart';
class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  void initState() {
    super.initState();
    context.read<FavouriteCubit>().favouriteList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavouriteCubit,List<FavouriteModel>>(
        builder: (context, state) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
           itemCount: state.length,
           itemBuilder: (context, index) {
            var product = state[index];
            print("asdad");
            return Card(
              child: Image.network(product.product_image_url),
            );
          },
        );

      },)
    );
  }
}
