void main() {
  var personelManager = PersonelManager();
  personelManager.add();

  var customerManager = CustomerManager();

  var customer2 = new Customer();
  customer2.firstName = "alp";
  customer2.lastName = "eren";

  customer2.firstName = "alper";

  customerManager.add(customer2);

  Personel personel1 = Personel(0);
  personel1.firstName = "test";

  var controller = PersonController();
  controller.operation(personel1);
}

class PersonController {
  void operation(Person person) {
    print('Inheritance demo :  ${person.firstName}');
  }
}

class PersonelManager {
  void add() {
    print("Eklendi!");
  }

  void update() {
    print("Güncellendi");
  }

  void delete() {
    print("Silindi");
  }
}

class CustomerManager {
  void add(Customer customer) {
    print('Eklendi :  ${customer.firstName}');
  }

  void update() {
    print("Güncellendi");
  }

  void delete() {
    print("Silindi");
  }
}

class Customer extends Person {
  Customer() : super('', '', '');
  Customer.withInfo(
    super.firstName,
    super.lastName,
    super.identityNumber,
  );
}

class Personel extends Person {
  int dateOfStart;
  Personel(
    this.dateOfStart,
  ) : super('', '', '');
  Personel.withInfo(
    super.firstName,
    super.lastName,
    super.identityNumber,
    this.dateOfStart,
  );
}

class Person {
  String firstName;
  String lastName;
  String identityNumber;

  Person(
    this.firstName,
    this.lastName,
    this.identityNumber,
  );
}
