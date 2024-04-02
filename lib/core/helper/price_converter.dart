String priceConverter(number) {
  List<String> strNum = number.toString().split("").reversed.toList();
  List<String> newList = [];

  for (int i = 0; i < strNum.length; i++) {
    if (i % 3 == 0 && i > 0) {
      newList.add(".");
    }
    newList.add(strNum[i]);
  }

  String newStr = newList.reversed.toList().join();
  return "Rp $newStr";
}
