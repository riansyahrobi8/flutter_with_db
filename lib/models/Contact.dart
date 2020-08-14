class Contact {
  int id;
  String name, phone;

  Contact(this.name, this.phone);

  Contact.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.phone = map['phone'];
  }

  // int get id => id;
  // String get name => _name;
  // String get phone => _phone;

  // set name(String value) {
  //   _name = value;
  // }

  // set phone(String value) {
  //   _phone = value;
  // }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this.id;
    map['name'] = this.name;
    map['phone'] = this.phone;

    return map;
  }
}
