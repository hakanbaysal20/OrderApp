import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_app/data/constants/color_constants.dart';
import 'package:order_app/data/constants/string_constants.dart';
import 'package:order_app/ui/cubit/registration_cubit.dart';
import 'package:order_app/ui/widgets/customTextField.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordAgainController = TextEditingController();
  var userNameController = TextEditingController();
  var userCityController = TextEditingController();
  var selectedCity = "Adana";
  var cityList = <String>["Adana", "Adıyaman", "Afyonkarahisar", "Ağrı", "Amasya", "Ankara", "Antalya", "Artvin", "Aydın", "Balıkesir", "Bilecik", "Bingöl", "Bitlis", "Bolu", "Burdur", "Bursa", "Çanakkale",
    "Çankırı", "Çorum", "Denizli", "Diyarbakır", "Edirne", "Elazığ", "Erzincan", "Erzurum", "Eskişehir", "Gaziantep", "Giresun", "Gümüşhane", "Hakkari", "Hatay",
    "Isparta", "Mersin", "İstanbul", "İzmir", "Kars", "Kastamonu", "Kayseri", "Kırklareli", "Kırşehir", "Kocaeli", "Konya", "Kütahya", "Malatya", "Manisa",
    "Kahramanmaraş", "Mardin", "Muğla", "Muş", "Nevşehir", "Niğde", "Ordu", "Rize", "Sakarya", "Samsun", "Siirt", "Sinop", "Sivas", "Tekirdağ", "Tokat",
    "Trabzon", "Tunceli", "Şanlıurfa", "Uşak", "Van", "Yozgat", "Zonguldak", "Aksaray", "Bayburt", "Karaman", "Kırıkkale", "Batman", "Şırnak", "Bartın", "Ardahan", "Iğdır", "Yalova", "Karabük", "Kilis", "Osmaniye", "Düzce"];

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: screenWidth * 0.12),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.04),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      }, icon: const Icon(Icons.arrow_back_ios,color: ColorConstants.priceColor,size: 35,)),
                ],
              ),
            ),

            Image.asset("assets/images/ic_logo.png",color: ColorConstants.priceColor,),
            const Text("Foodi",style: TextStyle(color: ColorConstants.priceColor,fontFamily: 'Roboto' ,fontSize: 42,fontWeight: FontWeight.w500)),
             Padding(
              padding: EdgeInsets.only(bottom: screenWidth * 0.04),
              child: const Text("Grab your favourite food",style: TextStyle(fontSize: 20,fontFamily: 'Roboto',color: ColorConstants.priceColor,fontWeight: FontWeight.w500),),
            ),
            CustomTextField(obscureText: false, hintText: "Name", icon: const Icon(Icons.person_add,color: ColorConstants.priceColor,), controller: userNameController),
            CustomTextField(obscureText: false, hintText: "E-mail", icon: const Icon(Icons.mail_outline,color: ColorConstants.priceColor),controller: emailController,),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.location_on,color: ColorConstants.priceColor,),
                    enabledBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.black26)),hintText: "Şehir seç",
                    border:OutlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(7)),
                value: selectedCity,
                icon: const Icon(Icons.arrow_drop_down),
                items: cityList.map((city){
                return DropdownMenuItem(
                    value: city,
                    child: Text(city,style: const TextStyle(color: ColorConstants.black54,fontFamily: 'Roboto',fontSize: 18),));
              }).toList(),
              onChanged: (data) {
                  setState(() {
                    selectedCity = data!;
                  });
              },
              ),
            ),
            CustomTextField(obscureText: true, hintText: "Password", icon: const Icon(Icons.lock_outline,color: ColorConstants.priceColor),controller: passwordController),
            CustomTextField(obscureText: true, hintText: "Password Again", icon: const Icon(Icons.lock_outline,color: ColorConstants.priceColor),controller: passwordAgainController),

            TextButton(onPressed: () {
              userCityController.text = selectedCity;
              context.read<RegistrationCubit>().registration(context,emailController.text, passwordController.text, passwordAgainController.text,userCityController.text,userNameController.text);

            },style: TextButton.styleFrom(backgroundColor: ColorConstants.priceColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
                child: Container(width: screenWidth * 0.7,child: const Text("Sign up",style: TextStyle(color: ColorConstants.white,fontFamily: 'Roboto',fontSize: 16),textAlign: TextAlign.center))),

          ],
        ),
      ),
    );
  }
}
