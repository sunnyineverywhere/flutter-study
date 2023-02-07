import 'package:flutter/material.dart';
import 'package:flutter_state_provider/screens/user_list_screen.dart';
import 'package:flutter_state_provider/widget/button.dart';
import 'package:flutter_state_provider/widget/input.dart';
import 'package:flutter_state_provider/widget/user_list.dart';

import '../model/user.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  String? _name = '';
  String? _city = '';

  List<User> userList = [
    User('sunny', 'seoul'),
    User('siyeon', 'seoul'),
    User('jiui', 'novi')
  ];

  addUser(User user) {
    setState(() {
      userList.add(user);
    });
  }

  deleteUser(User user) {
    userList.removeWhere((_user) => _user.name == user.name);
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
          title: const Text(
        "Provider Demo",
        style: TextStyle(color: Colors.white),
      )),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InputForm(
                labelText: 'Name',
                onSaved: (String? value) {
                  _name = value;
                },
              ),
              SizedBox(height: 16),
              InputForm(
                labelText: 'City',
                onSaved: (String? value) {
                  _city = value;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MainButton(
                    text: 'Add',
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      _formKey.currentState!.save();
                      addUser(User(_name!, _city!));
                    },
                  ),
                  SizedBox(width: 8),
                  MainButton(
                    text: 'List',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserListScreen()));
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              UserList(userList, deleteUser)
            ],
          ),
        ),
      ),
    );
  }
}
