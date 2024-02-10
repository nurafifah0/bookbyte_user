import 'package:bookbyte_user/booklistpage.dart';
import 'package:bookbyte_user/models/user.dart';
import 'package:bookbyte_user/profilepage.dart';
import 'package:bookbyte_user/serverconfig.dart';
import 'package:bookbyte_user/shared/EnterExitRoute.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  final String page;
  final User userdata;

  const MyDrawer({super.key, required this.page, required this.userdata});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  //var pathAsset = "${ServerConfig.server}/bookbyte/assets/profileimages/${widget.userdata.userid}.png";
  //"assets/images/profileimages.png";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            currentAccountPicture: CircleAvatar(
                radius: 30.0,
                // AssetImage('assets/images/pr.jpeg'),

                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.network(
                    "${ServerConfig.server}/bookbyte/assets/profileimages/${widget.userdata.userid}.png",
                  ),
                )),
            accountName: Row(
              children: [
                Text(widget.userdata.username.toString()),
                //Text(widget.userdata.userphone.toString()),
              ],
            ),
            accountEmail: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.userdata.useremail.toString()),
                    //const Text("RM100")
                  ]),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.money),
            title: const Text('Books'),
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (content) => const MainPage()));
              print(widget.page.toString());
              if (widget.page.toString() == "books") {
                //  Navigator.pop(context);
                return;
              }
              Navigator.pop(context);
              Navigator.push(
                  context,
                  EnterExitRoute(
                      exitPage: BookListPage(
                        user: widget.userdata,
                      ),
                      enterPage: BookListPage(user: widget.userdata)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.verified_user),
            title: const Text('My Account'),
            onTap: () {
              print(widget.page.toString());
              Navigator.pop(context);
              if (widget.page.toString() == "account") {
                //  Navigator.pop(context);
                return;
              }
              Navigator.pop(context);

              // Navigator.push(context,
              //     MaterialPageRoute(builder: (content) => const ProfilePage()));
              Navigator.push(
                  context,
                  EnterExitRoute(
                      exitPage: ProfilePage(userdata: widget.userdata),
                      enterPage: ProfilePage(userdata: widget.userdata)));
            },
          ),
          const Divider(
            color: Colors.blueGrey,
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
