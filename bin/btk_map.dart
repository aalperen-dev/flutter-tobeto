void main() {
  var dictionary1 = {};
  dictionary1["book"] = "kitap";
  dictionary1["little"] = "küçük";

  var dictionary2 = {"kitap": "book", "küçük": "little"};
  dictionary2["büyük"] = "big";

  print(dictionary1);
  print(dictionary2);

  dictionary1.remove("book");
  print(dictionary1);

  print('---');
  for (var key in dictionary2.keys) {
    print('key : $key');
  }

  print('---');
  for (var value in dictionary2.values) {
    print(value);
  }

  print('---');
  print(dictionary2.containsKey("kitap"));

  print('---');
  dictionary2.forEach((k, v) => print('$k - $v'));
}
