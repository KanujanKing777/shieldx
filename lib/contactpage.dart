import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactListPage extends StatefulWidget {
  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
    _getContacts();
  }

  Future<void> _getContacts() async {
    if (await Permission.contacts.request().isGranted) {
      Iterable<Contact> contacts = await ContactsService.getContacts();
      setState(() {
        _contacts = contacts.toList();
      });
    } else {
      print('Permission denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _contacts.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: _contacts.length,
            itemBuilder: (context, index) {
              Contact contact = _contacts[index];
              return ListTile(
                title: Text(contact.displayName ?? 'No Name'),
                subtitle: Text(
                  contact.phones != null && contact.phones!.isNotEmpty
                      ? contact.phones!.first.value ?? 'No Phone Number'
                      : 'No Phone Number',
                ),
              );
            },
          );
  }
}