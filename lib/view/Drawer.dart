import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/controller/AuthenticationMgr.dart';
import '../controller/UserMgr.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Column(
            children: [
              Text(UserManager.getProfileDetails()['name']),
              Text(UserManager.getProfileDetails()['email']),
              Text(UserManager.getProfileDetails()['phoneNumber'].toString()),
            ],
          ),),
          ListTile(
            title: Text('Profile Page'),
            onTap: (){
              Navigator.of(context).pushNamed('/profile');
            },
          ),
          ListTile(
            title: Text('SignOut'),
            onTap: (){
              AuthenticationManager.signOut();
              Navigator.of(context).pushNamed('/login');
            },
          ),
        ],

      ),
    );
  }
}
