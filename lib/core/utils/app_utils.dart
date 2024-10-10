class AppUtils {
  static String kgToLb(String kg) {
    double lbValue = double.parse(kg) * 2.20462;
    return lbValue.toStringAsFixed(2);
  }

  static String lbToKg(String lb) {
    double kgValue = double.parse(lb) / 2.20462;
    return kgValue.toStringAsFixed(2);
  }

  static bool isValidWeight(String input) {
    final RegExp weightRegExp = RegExp(r'^(?!0(\.0{1,})?$)\d{1,3}(\.\d{1,2})?\s?(kg|lb)?$');
    return weightRegExp.hasMatch(input);
  }
}
