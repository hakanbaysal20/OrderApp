import 'package:order_app/data/entity/basket_model.dart';

class BasketCubitTypes {

  final List<BasketModel> basketModel;
  final int totalPrice;

  BasketCubitTypes({
    required this.basketModel,
    required this.totalPrice,
  });

  BasketCubitTypes copyWith({
    List<BasketModel>? basketModel,
    int? totalPrice,
  }) {
    return BasketCubitTypes(
      basketModel: basketModel ?? this.basketModel,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BasketCubitTypes &&
              runtimeType == other.runtimeType &&
              basketModel == other.basketModel &&
              totalPrice == other.totalPrice;

  @override
  int get hashCode => basketModel.hashCode ^ totalPrice.hashCode;
}