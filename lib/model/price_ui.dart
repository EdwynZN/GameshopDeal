final class PriceUI {
  final double salePrice;
  final double normalPrice;
  final int savings;

  const PriceUI({
    required this.savings,
    required this.normalPrice,
    required this.salePrice,
  });

  factory PriceUI.fromPrice({
    required double normalPrice,
    required double salePrice,
  }) {
    final savings = 100 * (1 - salePrice / normalPrice);
    return PriceUI(
      normalPrice: normalPrice,
      salePrice: salePrice,
      savings: savings.toInt(),
    );
  }

  bool get isFree => savings == 100 || salePrice == 0;

  bool get hasDiscount => savings != 0 || salePrice != normalPrice;
}
