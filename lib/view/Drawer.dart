import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/controller/AuthenticationMgr.dart';
import '../controller/UserMgr.dart';
import '../MyAppIcons.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.teal.shade800,
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              child: DrawerHeader(

                child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: CircleAvatar(
                      child: Icon(MyAppIcons.profile, size:50, color: Theme.of(context).primaryColor),
                      backgroundColor: Theme.of(context).backgroundColor,
                      ),
                    ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                  Text(UserManager.getProfileDetails()['name'],
                  style: TextStyle(fontSize: 20,
                  color: Color(0xfffafaff),
                  ),),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                  Text(UserManager.getProfileDetails()['email'],style: TextStyle(fontSize: 20,
                    color: Color(0xfffafaff),
                  ),),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                  Text(UserManager.getProfileDetails()['phoneNumber'].toString(),style: TextStyle(fontSize: 20,
                    color: Color(0xfffafaff),
                  ),),
                ],
              ),),
            ),
            ListTile(
              title: Text('Profile Page',
                style: TextStyle(fontSize: 20,
                color: Color(0xfffafaff),
              ),),
              onTap: (){
                Navigator.of(context).pushNamed('/profile');
              },
            ),
            Divider(color: Colors.black,
            ),
            ListTile(
              title: Text('SignOut',
                style: TextStyle(fontSize: 20,
                  color: Color(0xfffafaff),
                ),),
              onTap: (){
                AuthenticationManager.signOut();
                Navigator.of(context).pushNamed('/login');
              },
            ),
            Divider(color: Colors.black,
            ),
          ],

        ),
      ),
    );
  }
}
