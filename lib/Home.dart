import 'package:flutter/material.dart';
import 'package:flutter_with_data/components/EntryForm.dart';
import 'package:flutter_with_data/helper/DBHelper.dart';
import 'package:flutter_with_data/models/Contact.dart';
import 'package:sqflite/sqflite.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DBHelper dbHelper;
  int count = 0;
  List<Contact> contactList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
  }

  @override
  Widget build(BuildContext context) {
    if (contactList == null) {
      contactList = List<Contact>();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar data-data"),
      ),
      body: createListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var contact = await navigateToEntryForm(context, null);
          if (contact != null) addContact(contact);
        },
        tooltip: 'Tambah data',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<Contact> navigateToEntryForm(
      BuildContext context, Contact contact) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(contact);
    }));
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(Icons.people),
              ),
              title: Text(this.contactList[index].name, style: textStyle),
              subtitle: Text(
                this.contactList[index].phone,
              ),
              trailing: GestureDetector(
                child: Icon(Icons.delete),
                onTap: () {
                  deleteContact(contactList[index]);
                },
              ),
              onTap: () async {
                var contact =
                    await navigateToEntryForm(context, this.contactList[index]);
                if (contact != null) editContact(contact);
              },
            ),
          );
        });
  }

  void addContact(Contact contact) async {
    int result = await dbHelper.insert(contact);
    if (result > 0) {
      updateLIstView();
    }
  }

  void editContact(Contact contact) async {
    int result = await dbHelper.update(contact);
    if (result > 0) {
      updateLIstView();
    }
  }

  void deleteContact(Contact contact) async {
    int result = await dbHelper.delete(contact.id);
    if (result > 0) updateLIstView();
  }

  void updateLIstView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Contact>> contactListFuture = dbHelper.getContactList();
      contactListFuture.then((contactList) {
        setState(() {
          this.contactList = contactList;
          this.count = contactList.length;
        });
      });
    });
  }
}
