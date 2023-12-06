import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/constants/color_constants.dart';
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
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.7),
           itemCount: state.length,
           itemBuilder: (context, index) {
            var product = state[index];
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12)),border: Border.all(color: ColorConstants.blackLight)),
                child: Column(
                  children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         IconButton(onPressed: () {

                         }, icon: Icon(Icons.favorite_outlined,color: ColorConstants.priceColor,))
                       ],
                     ),
                    Image.network(product.product_image_url),
                    Text("Baklava"),
                  ],
                ),
              ),
            );
          },
        );

      },)
    );
  }
}
