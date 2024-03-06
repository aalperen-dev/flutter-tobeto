void main() {
  selamVer2("alp");
  selamVer2("eren");
  selamVer2("alperen");

  var hesapSonucu = hesapla(100000, 15);
  print(hesapSonucu);

  test1(1, 2, 3);
  test2(sayi2: 1, sayi3: 2, sayi1: 3);
}

void selamVer() {
  print("Selam");
}

void selamVer2(String kullanici) {
  print("Selam $kullanici");
}

double hesapla(double krediTutari, double yuzde) {
  var sonuc = krediTutari * yuzde / 100;
  return sonuc;
}

void test1(int sayi1, int sayi2, int sayi3) {
  print(sayi1);
  print(sayi2);
  print(sayi3);
}

void test2({required int sayi1, required int sayi2, required int sayi3}) {
  print(sayi1);
  print(sayi2);
  print(sayi3);
}
