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

  static String calcPercentage(String flourAmount, String otherAmount) {
    var percentage = tryParseString(otherAmount) / tryParseString(flourAmount);
    return fromDecimalPercentage(percentage).toStringAsFixed(2);
  }
}
