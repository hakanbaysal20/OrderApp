class ListType {


  final bool checkFavourite;
  final int productAmount;

  ListType({
    required this.checkFavourite,
    required this.productAmount,
  });

  ListType copyWith({
    bool? checkFavourite,
    int? productAmount,
  }) {
    return ListType(
      checkFavourite: checkFavourite ?? this.checkFavourite,
      productAmount: productAmount ?? this.productAmount,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ListType &&
              runtimeType == other.runtimeType &&
              checkFavourite == other.checkFavourite &&
              productAmount == other.productAmount;

  @override
  int get hashCode => checkFavourite.hashCode ^ checkFavourite.hashCode;
}