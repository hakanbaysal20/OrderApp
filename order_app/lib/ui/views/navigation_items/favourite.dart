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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Favoriler",
          style: TextStyle(fontSize: 26, fontFamily: 'SansPro', fontWeight: FontWeight.w500),
        ),
      ),
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
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [  BoxShadow(
                      color: Colors.black.withOpacity(0.05), blurRadius: 1),
                  ],
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      ),
                  child: Column(
                    children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           IconButton(onPressed: () {
                             context.read<FavouriteCubit>().deleteFavorite(product.product_id);

                           }, icon: Icon(Icons.close_outlined ,color: Colors.black45,size: 25,))
                         ],
                       ),
                      Image.network(product.product_image_url),
                      Text(product.product_name),
                    ],
                  ),
                ),
              ),
            );
          },
        );

      },)
    );
  }
}
