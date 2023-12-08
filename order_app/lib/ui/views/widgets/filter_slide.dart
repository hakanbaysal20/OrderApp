
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/constants/color_constants.dart';
import 'package:order_app/ui/bloc/home_cubit.dart';

class FilterSlide extends StatefulWidget {


  @override
  State<FilterSlide> createState() => _FilterSlideState();

  const FilterSlide({super.key});
}
class _FilterSlideState extends State<FilterSlide> {
  var minValue = 0.0;
  var priceValue = 30.0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Sort by",style: TextStyle(fontFamily: 'SansPro',fontSize: 20,fontWeight: FontWeight.w500),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SortButtons("Fiyat", () {
                context.read<HomeCubit>().sortAscByPriceProduct();
                Navigator.of(context).pop();

              }, Icon(Icons.keyboard_arrow_up,color: ColorConstants.white,)),
              SortButtons("Fiyat", () {
                context.read<HomeCubit>().sortDescByPriceProduct();
                Navigator.of(context).pop();

              }, Icon(Icons.keyboard_arrow_down,color: ColorConstants.white,)),
              SortButtons("İsim", () {
                context.read<HomeCubit>().sortByWordProduct();
                Navigator.of(context).pop();

              }, Icon(Icons.keyboard_arrow_up,color: ColorConstants.white,)),

            ],
          ),
          Text("Filter",style: TextStyle(fontFamily: 'SansPro',fontSize: 20,fontWeight: FontWeight.w500),),
          Text(priceValue.toInt().toString()),
          Slider(min: minValue ,max: 150,value: priceValue, onChanged: (value) {
            setState(() {
              priceValue = value;
            });
          },),
          TextButton(onPressed: () {
            context.read<HomeCubit>().filterProduct(priceValue.toInt(), 0);
            Navigator.of(context).pop();
          }, child: Text("Filtrele")),

        ],
      ),
    );
  }
}
class SortButtons extends StatelessWidget {
  String word;
  void Function()? function;
  Icon icon;


  SortButtons(this.word, this.function, this.icon);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: ColorConstants.priceColor,shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7)))),
        onPressed: function,
        child: Row(children: [Text(word,style: TextStyle(color: ColorConstants.white),),icon],));
  }
}

