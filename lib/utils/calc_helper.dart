class CalcHelper {
  static double toDecimalPercentage(String value) {
    return tryParseString(value) / 100;
  }

  static double fromDecimalPercentage(double value) {
    return value * 100;
  }

  static double tryParseString(String value) {
    return double.tryParse(value) ?? 0;
  }

  static String calcAmount(String flourAmount, String percentage) {
    var amount = tryParseString(flourAmount) * toDecimalPercentage(percentage);
    return amount.toStringAsFixed(0);
  }

  static String calcWaterAmount(String flourAmount, String waterPercentage,
      String starterAmount, String starterHydration) {
    var waterInDoughAmount =
        tryParseString(flourAmount) * toDecimalPercentage(waterPercentage);
    var waterInStarterAmount =
        calcWaterInStarter(starterAmount, starterHydration);
    ;

    var waterAmount = waterInDoughAmount - waterInStarterAmount;

    return waterAmount.toStringAsFixed(0);
  }

  static String calcPercentage(String flourAmount, String otherAmount) {
    var percentage = tryParseString(otherAmount) / tryParseString(flourAmount);
    return fromDecimalPercentage(percentage).toStringAsFixed(2);
  }

  static String calcWaterPercentage(String flourAmount, String waterAmount,
      String starterAmount, String starterHydration) {
    var waterInStarterAmount =
        calcWaterInStarter(starterAmount, starterHydration);
    var waterTotalAmount = tryParseString(waterAmount) + waterInStarterAmount;

    var waterPercentage = waterTotalAmount / tryParseString(flourAmount);
    return fromDecimalPercentage(waterPercentage).toStringAsFixed(2);
  }

  static double calcWaterInStarter(
      String starterAmount, String starterHydration) {
    return tryParseString(starterAmount) *
        tryParseString(starterHydration) /
        (tryParseString(starterHydration) + 100);
  }
}
