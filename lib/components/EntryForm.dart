import 'package:flutter/material.dart';
import 'package:flutter_with_data/models/Contact.dart';

class EntryForm extends StatefulWidget {
  EntryForm(this.contact);

  final Contact contact;

  @override
  _EntryFormState createState() => _EntryFormState(this.contact);
}

class _EntryFormState extends State<EntryForm> {
  _EntryFormState(this.contact);

  Contact contact;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (contact != null) {
      nameController.text = contact.name;
      phoneController.text = contact.phone;
    }

    return Scaffold(
      appBar: AppBar(
        title: contact == null ? Text('Tambah') : Text('Ubah'),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.keyboard_arrow_left)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(children: <Widget>[
          // name
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: TextField(
              controller: nameController,
              onChanged: (value) {
                // do someting
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),

          // phone
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: TextField(
              controller: phoneController,
              onChanged: (value) {
                // do something
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: 'Telepon',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),

          // tombol button
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Row(
              children: [
                Expanded(
                    child: RaisedButton(
                  onPressed: () {
                    if (contact == null) {
                      // insert data
                      contact =
                          Contact(nameController.text, phoneController.text);
                    } else {
                      // edit data
                      contact.name = nameController.text;
                      contact.phone = phoneController.text;
                    }

                    Navigator.pop(context, contact);
                  },
                  color: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).primaryColorLight,
                  child: Text(
                    'Save',
                    textScaleFactor: 1.5,
                  ),
                )),
                Container(
                  width: 5.0,
                ),
                Expanded(
                    child: RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).primaryColorLight,
                  child: Text(
                    'Cancel',
                    textScaleFactor: 1.5,
                  ),
                ))
              ],
            ),
          )
        ]),
      ),
    );
  }
}
