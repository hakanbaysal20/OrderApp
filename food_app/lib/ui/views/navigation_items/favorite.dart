import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/constants/color_constants.dart';
import 'package:order_app/data/constants/string_constants.dart';
import 'package:order_app/data/entity/favorite_model.dart';
import 'package:order_app/ui/cubit/favorite_cubit.dart';
class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  void initState() {
    super.initState();
    context.read<FavouriteCubit>().favouriteList();
  }
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          StringConstants.favorite,
          style: TextStyle(fontSize: 26, fontFamily: StringConstants.primaryFontFamily, fontWeight: FontWeight.w500),
        ),
      ),
      body: BlocBuilder<FavouriteCubit,List<FavouriteModel>>(
        builder: (context, state) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.7),
           itemCount: state.length,
           itemBuilder: (context, index) {
            var product = state[index];
            return Padding(
              padding: EdgeInsets.all(screenWidth * 0.01),
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorConstants.white,
                    boxShadow: [  BoxShadow(
                      color: ColorConstants.black.withOpacity(0.05), blurRadius: 1),
                  ],
                      borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.03)),
                      ),
                  child: Column(
                    children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           IconButton(onPressed: () {
                             context.read<FavouriteCubit>().deleteFavorite(product.product_id);

                           }, icon: Icon(Icons.close_outlined ,color: ColorConstants.black45,size: screenWidth * 0.06,))
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
