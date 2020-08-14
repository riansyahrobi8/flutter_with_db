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
    super.initState();
    dbHelper = DBHelper(); // inisialisasi dbhelper diawal
  }

  @override
  Widget build(BuildContext context) {
    // check jika list dalam keadaan kosong, maka tampilkan list kosong dari class Contact
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
          var contact = await navigateToEntryForm(
              context, null); // arahakan ke halaman tambah data
          if (contact != null)
            addContact(contact); // jika contact tidak kosong, tambahkan contact
        },
        tooltip:
            'Tambah data', // akan ditampilkan jika tombol di hold on atau tekan dan tahan selama beberapa detik
        child: Icon(Icons.add),
      ),
    );
  }

  // menggunakan future agar perpindahakan halaman dilakukan di backgorund
  Future<Contact> navigateToEntryForm(
      BuildContext context, Contact contact) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(contact); // panggil form entry contact
    }));
    return result;
  }

  // isi dari body
  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle1;

    // menggunakan listview builder untuk menampilkan data yang banyak dengan jumlah data yang tidak bisa tentukan
    return ListView.builder(
        itemCount: count, // jumlah data
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            // menggunakan listile
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(Icons.people),
              ),
              title: Text(this.contactList[index].name,
                  style: textStyle), // nama contact
              subtitle: Text(
                this.contactList[index].phone, // phone number contact
              ),
              // menggunakan trailing atau ekor untuk icon hapus
              trailing: GestureDetector(
                child: Icon(Icons.delete),
                onTap: () {
                  deleteContact(
                      contactList[index]); // hapus kontack berdasarkan index
                },
              ),
              onTap: () async {
                var contact = await navigateToEntryForm(
                    context,
                    this.contactList[
                        index]); // navigate ke form entry dengan keadaan data sudah terisi
                if (contact != null) editContact(contact);
              },
            ),
          );
        });
  }

  void addContact(Contact contact) async {
    int result = await dbHelper
        .insert(contact); // panggil function insert pada class DBHelper
    if (result > 0) {
      updateLIstView(); // kemudian update Listviewnya
    }
  }

  void editContact(Contact contact) async {
    int result = await dbHelper
        .update(contact); // panggil function update pada class DBHelper
    if (result > 0) {
      updateLIstView(); // kemudian update Listviewnya
    }
  }

  void deleteContact(Contact contact) async {
    int result = await dbHelper
        .delete(contact.id); // anggil function delete pada class DBHelper
    if (result > 0) updateLIstView(); // kemudian update Listviewnya
  }

  // function updateListview
  void updateLIstView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Contact>> contactListFuture =
          dbHelper.getContactList(); // ambil contact dari db
      contactListFuture.then((contactList) {
        setState(() {
          this.contactList = contactList; // masukan semua contact
          this.count = contactList.length; // masukan jumlah contact
        });
      });
    });
  }
}
