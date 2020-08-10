class Contact {
  int _id;
  String _name, _phone;

  Contact(this._name, this._phone);

  Contact.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._phone = map['phone'];
  }

  int get id => _id;
  String get name => _name;
  String get phone => _phone;

  set name(String value) {
    _name = value;
  }

  set phone(String value) {
    _phone = value;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['name'] = this._name;
    map['phone'] = this._phone;

    return map;
  }
}
