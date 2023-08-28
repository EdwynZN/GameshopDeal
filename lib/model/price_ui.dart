final class PriceUI {
  final double salePrice;
  final double normalPrice;
  final int savings;

  const PriceUI({
    required this.savings,
    required this.normalPrice,
    required this.salePrice,
  });

  bool get isFree => savings == 100 || salePrice == 0;

  bool get hasDiscount => savings != 0 || salePrice != normalPrice;
}
