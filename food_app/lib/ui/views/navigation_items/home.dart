import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/constants/color_constants.dart';
import 'package:order_app/data/constants/string_constants.dart';
import 'package:order_app/data/entity/product_model.dart';
import 'package:order_app/ui/cubit/home_cubit.dart';
import 'package:order_app/ui/views/product_details.dart';
import 'package:order_app/ui/widgets/filter_slide.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  var check = false;
  var minValue = 0.0;
  var maxValue = 150.0;
  var isThereSearch = false;
  var tf = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getProducts();
  }
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          StringConstants.menu,
          style: TextStyle(fontSize: 26, fontFamily: StringConstants.primaryFontFamily, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: screenWidth * 0.74,
                  height: screenWidth * 0.13,
                  child: TextField(
                    controller: tf,
                    onChanged: (value) {
                      setState(() {
                        isThereSearch = value.isNotEmpty;
                      });
                      context.read<HomeCubit>().getSearch(value);
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ColorConstants.whiteLight,
                      contentPadding: EdgeInsets.symmetric(vertical: screenWidth * 0.04, horizontal: screenWidth * 0.05),
                      suffixIcon: isThereSearch ? GestureDetector(onTap: () {
                        setState(() {
                          tf.clear();
                          isThereSearch = false;
                        });
                        FocusScope.of(context).unfocus();
                        context.read<HomeCubit>().getProducts();
                      },child: const Icon(Icons.close)) : GestureDetector(onTap: () {

                      }, child: const Icon(Icons.search),),
                      hintText: StringConstants.search,
                      hintStyle: const TextStyle(color: ColorConstants.dark, fontSize: 18, fontFamily: StringConstants.primaryFontFamily),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorConstants.white),
                        borderRadius: BorderRadius.circular(37),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorConstants.whiteLight),
                        borderRadius: BorderRadius.circular(37),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => DraggableScrollableSheet(
                        expand: false,
                        builder: (context, scrollController) => SingleChildScrollView(
                          controller: scrollController,
                          child: const FilterSlide(),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.priceColor.withOpacity(0.1),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    width: 50,
                    height: 50,
                    child: const Icon(Icons.filter_list_outlined, color: ColorConstants.priceColor),
                  ),
                ),
              ],
            ),

            BlocBuilder<HomeCubit, List<ProductModel>>(
              builder: (context, productList) {
                if (productList.isNotEmpty) {

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      var product = productList[index];
                      return Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.06,left: screenWidth * 0.06,bottom: screenWidth * 0.03,top: screenWidth * 0.03),
                        child: SizedBox(
                          height: 88,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(product: product),));
                            },
                            child: Card(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                  color: ColorConstants.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: ColorConstants.blue.withOpacity(0.08), blurRadius: 100,),
                                  ],
                                ),
                                child:  Padding(
                                  padding: EdgeInsets.only(right: screenWidth * 0.03, left: screenWidth * 0.03),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          height: screenWidth * 0.16,
                                          width: screenWidth * 0.16,
                                          child: Image.network("${StringConstants.getImage}${product.product_image}")),
                                      SizedBox(width: screenWidth * 0.025),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(product.product_name,style: const TextStyle(fontSize: 18,fontFamily: StringConstants.primaryFontFamily,fontWeight: FontWeight.w500),),
                                          const Text(StringConstants.loovyFood,style: TextStyle(fontSize: 14,fontFamily: StringConstants.primaryFontFamily,color: ColorConstants.black54),),
                                        ],
                                      ),
                                      const Spacer(),
                                      Text(
                                        "₺${product.product_price}",
                                        style: const TextStyle(fontSize: 29,fontFamily: StringConstants.primaryFontFamily,
                                            fontWeight: FontWeight.w500,color: ColorConstants.priceColor),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );

                    },
                  );
                } else {
                  return const Center(
                    child: Text("No results found."),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

