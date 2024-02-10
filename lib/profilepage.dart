import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:bookbyte_user/main.dart';
import 'package:bookbyte_user/registrationpage.dart';
import 'package:http/http.dart' as http;

import 'package:bookbyte_user/models/user.dart';

import 'package:bookbyte_user/serverconfig.dart';
import 'package:bookbyte_user/shared/mydrawer.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  final User userdata;
  const ProfilePage({super.key, required this.userdata});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late double screenWidth, screenHeight;
  File? _image;
  //var pathAsset = "assets/images/profile.png";
  final df = DateFormat('dd/MM/yyyy');
  var val = 50;

  bool isDisable = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _oldpasswordController = TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();
  final TextEditingController _newaddressController = TextEditingController();
  Random random = Random();

  @override
  void initState() {
    super.initState();
    if (widget.userdata.userid == "0") {
      isDisable = true;
    } else {
      isDisable = false;
    }

    _nameController.text = widget.userdata.username.toString();
    _phoneController.text = widget.userdata.userphone.toString();
    _newaddressController.text = widget.userdata.useraddress.toString();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //CircleAvatar(backgroundImage: AssetImage('')),
                Text(
                  "My Account",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
              ],
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(
                color: Colors.grey,
                height: 1.0,
              ),
            )),
        drawer: MyDrawer(
          page: 'account',
          userdata: widget.userdata,
        ),
        body: Center(
          child: Column(children: [
            Container(
              height: screenHeight * 0.25,
              padding: const EdgeInsets.all(4),
              child: Card(
                  child: Row(children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.4,
                  child: GestureDetector(
                    onTap: () {
                      showSelectionDialog();
                    },
                    child: Container(
                      height: screenHeight * 0.3,
                      width: screenWidth * 0.8,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.scaleDown,
                              image: _image == null
                                  ? NetworkImage(
                                      // fit: BoxFit.fill,
                                      "${ServerConfig.server}/bookbyte/assets/profileimages/${widget.userdata.userid}.png")
                                  : FileImage(_image!) as ImageProvider)),
                    ),
                  ),
                  /* child: Image.asset(
                    'assets/images/pr.jpeg',
                    fit: BoxFit.contain,
                  ), */
                ),
                Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        Text(
                          widget.userdata.username.toString().toUpperCase(),
                          style: const TextStyle(fontSize: 24),
                        ),
                        const Divider(
                          color: Colors.blueGrey,
                        ),
                        Text(
                          widget.userdata.useremail.toString(),
                          style: const TextStyle(fontSize: 15),
                        ),
                        Text(
                          widget.userdata.userphone.toString(),
                          style: const TextStyle(fontSize: 15),
                        ),
                        Text(df.format(DateTime.parse(
                            widget.userdata.userdatereg.toString()))),
                        Text(
                          widget.userdata.useraddress.toString().toUpperCase(),
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ))
              ])),
            ),
            Container(
              height: screenHeight * 0.035,
              alignment: Alignment.center,
              color: Colors.blue,
              width: screenWidth,
              child: const Text("UPDATE ACCOUNT",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            // const Divider(
            //   color: Colors.blueGrey,
            // ),
            Expanded(
                child: ListView(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    shrinkWrap: true,
                    children: [
                  MaterialButton(
                    onPressed: () {
                      _updateNameDialog();
                    },
                    child: const Text("UPDATE NAME"),
                  ),
                  const Divider(
                    height: 2,
                  ),
                  MaterialButton(
                    onPressed: _changePassDialog,
                    child: const Text("UPDATE PASSWORD"),
                  ),
                  const Divider(
                    height: 2,
                  ),
                  MaterialButton(
                    onPressed: _updatePhoneDialog,
                    child: const Text("UPDATE PHONE NUMBER"),
                  ),
                  const Divider(
                    height: 2,
                  ),
                  MaterialButton(
                    onPressed: _changeAddrDialog,
                    child: const Text("UPDATE ADDRESS"),
                  ),
                  const Divider(
                    height: 2,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) => const RegistrationPage()));
                    },
                    child: const Text("NEW REGISTRATION"),
                  ),
                  const Divider(
                    height: 2,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) => const MainApp()));
                    },
                    child: const Text("LOGOUT"),
                  ),
                ])),
          ]),
        ));
  }

  void showSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            title: const Text(
              "Select from",
              style: TextStyle(),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenWidth / 4, screenHeight / 8)),
                  child: const Text('Gallery'),
                  onPressed: () => {
                    Navigator.of(context).pop(),
                    _selectfromGallery(),
                  },
                ),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenWidth / 4, screenHeight / 8)),
                  child: const Text('Camera'),
                  onPressed: () => {
                    Navigator.of(context).pop(),
                    _selectFromCamera(),
                  },
                ),
              ],
            ));
      },
    );
  }

  Future<void> _selectfromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      cropImage();
    } else {}
  }

  Future<void> _selectFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);

      cropImage();
    } else {}
  }

  Future<void> cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: _image!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.ratio4x3,
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Please Crop Your Image',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      File imageFile = File(croppedFile.path);
      _image = imageFile;
      _updateProfileImage(_image);
      setState(() {});
    }
  }

  void _updateProfileImage(image) {
    String imagestr = base64Encode(_image!.readAsBytesSync());
    http.post(
        Uri.parse("${ServerConfig.server}/bookbyte/php/update_profile.php"),
        body: {
          "userid": widget.userdata.userid.toString(),
          "image": imagestr
        }).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Insert Success"),
            backgroundColor: Colors.green,
          ));
          Navigator.of(context).pop();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (content) => ProfilePage(
                        userdata: widget.userdata,
                      )));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Insert Failed"),
            backgroundColor: Colors.red,
          ));
        }
      }
    });
  }

  void _updateNameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Change Name?",
            style: TextStyle(),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                String newname = _nameController.text;
                _updateName(newname);
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updateName(String newname) {
    http.post(
        Uri.parse("${ServerConfig.server}/bookbyte/php/update_profile.php"),
        body: {
          "userid": widget.userdata.userid.toString(),
          "newname": newname,
        }).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Insert Success"),
            backgroundColor: Colors.green,
          ));
          Navigator.of(context).pop();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (content) => ProfilePage(
                        userdata: widget.userdata,
                      )));
          setState(() {
            widget.userdata.username = newname;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Insert Failed"),
            backgroundColor: Colors.red,
          ));
        }
      }
    }
        /*  {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        setState(() {
          widget.user.name = newname;
        });
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    } */
        );
  }

  void _updatePhoneDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Change Phone?",
            style: TextStyle(),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _phoneController,
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter new your phone';
                  }
                  return null;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                String newphone = _phoneController.text;
                _updatePhone(newphone);
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updatePhone(String newphone) {
    http.post(
        Uri.parse("${ServerConfig.server}/bookbyte/php/update_profile.php"),
        body: {
          "userid": widget.userdata.userid.toString(),
          "newphone": newphone,
        }).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Insert Success"),
            backgroundColor: Colors.green,
          ));
          Navigator.of(context).pop();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (content) => ProfilePage(
                        userdata: widget.userdata,
                      )));
          setState(() {
            widget.userdata.userphone = newphone;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Insert Failed"),
            backgroundColor: Colors.red,
          ));
        }
      }
    }
        /*  {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        setState(() {
          widget.user.phone = newphone;
        });
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    } */
        );
  }

  void _changePassDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Change Password?",
            style: TextStyle(),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _oldpasswordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Old Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _newpasswordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'New Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                changePass();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void changePass() {
    http.post(
        Uri.parse("${ServerConfig.server}/bookbyte/php/update_profile.php"),
        body: {
          "userid": widget.userdata.userid.toString(),
          "oldpass": _oldpasswordController.text,
          "newpass": _newpasswordController.text,
        }).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Insert Success"),
            backgroundColor: Colors.green,
          ));
          Navigator.of(context).pop();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (content) => ProfilePage(
                        userdata: widget.userdata,
                      )));
          setState(() {});
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Insert Failed"),
            backgroundColor: Colors.red,
          ));
        }
      }
    });
  }

  void _changeAddrDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Change Address?",
            style: TextStyle(),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _newaddressController,
                // obscureText: true,
                decoration: InputDecoration(
                    labelText: 'New Address',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                /* validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter new address';
                  }
                  return null;
                }, */
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                String newaddr = _newaddressController.text;
                changeAddr(newaddr);
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void changeAddr(String newaddr) {
    http.post(
        Uri.parse("${ServerConfig.server}/bookbyte/php/update_profile.php"),
        body: {
          "userid": widget.userdata.userid.toString(),
          "newaddr": newaddr,
        }).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Insert Success"),
            backgroundColor: Colors.green,
          ));
          Navigator.of(context).pop();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (content) => ProfilePage(
                        userdata: widget.userdata,
                      )));
          setState(() {
            widget.userdata.useraddress = newaddr;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Insert Failed"),
            backgroundColor: Colors.red,
          ));
        }
      }
    });
  }
}
