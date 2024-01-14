import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:bookbyte_user/serverconfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:flutter_map/flutter_map.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _phoneEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final TextEditingController _pass2EditingController = TextEditingController();
  final TextEditingController _addrEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String eula = "";
  bool _isChecked = false;
  late Position userpos;
  String addr = "";
  late double screenWidth, screenHeight;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(title: const Text("Registration Form")),
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                      child: Column(children: [
                        const Text(
                          "User Registration",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          controller: _nameEditingController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            icon: Icon(Icons.person),
                          ),
                          validator: (val) => val!.isEmpty || (val.length < 3)
                              ? "name must be longer than 3"
                              : null,
                        ),
                        TextFormField(
                          controller: _emailEditingController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            icon: Icon(Icons.email),
                          ),
                          validator: (val) => val!.isEmpty ||
                                  !val.contains("@") ||
                                  !val.contains(".")
                              ? "enter a valid email"
                              : null,
                        ),
                        TextFormField(
                          controller: _phoneEditingController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: 'Phone',
                            icon: Icon(Icons.phone),
                          ),
                          validator: (val) => val!.isEmpty || (val.length < 3)
                              ? "Phone must be longer than 10"
                              : null,
                        ),
                        TextFormField(
                          controller: _passEditingController,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            icon: Icon(Icons.lock),
                          ),
                          validator: (val) => validatePassword(val.toString()),
                        ),
                        TextFormField(
                          controller: _pass2EditingController,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Re-enter Password',
                            icon: Icon(Icons.lock),
                          ),
                          validator: (val) => validatePassword(val.toString()),
                        ),
                        TextFormField(
                          controller: _addrEditingController,
                          keyboardType: TextInputType.phone,
                          maxLines: 4,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  //_determinePosition();
                                  showMapDialog();
                                },
                                icon: const Icon(Icons.gps_not_fixed)),
                            labelText: 'Address',
                            icon: const Icon(Icons.gps_fixed),
                          ),
                          validator: (val) => val!.isEmpty || (val.length < 3)
                              ? "Phone must be longer than 10"
                              : null,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Checkbox(
                              value: _isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                              },
                            ),
                            GestureDetector(
                                onTap: _showEULA,
                                child: const Text("Agree with terms?")),
                            ElevatedButton(
                                onPressed: _registerUserDialog,
                                child: const Text("Register"))
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }

  String? validatePassword(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }

  void _registerUserDialog() {
    String pass = _passEditingController.text;
    String pass2 = _pass2EditingController.text;
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (!_isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please accept EULA"),
        backgroundColor: Colors.red,
      ));
      return;
    }
    if (pass != pass2) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Password do not match!!!"),
        backgroundColor: Colors.red,
      ));
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Register new account?",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _registerUser();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Registration Canceled"),
                  backgroundColor: Colors.red,
                ));
              },
            ),
          ],
        );
      },
    );
  }

  loadEula() async {
    eula = await rootBundle.loadString('assets/eula.txt');
  }

  void _showEULA() {
    loadEula();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "EULA",
            style: TextStyle(),
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                      child: RichText(
                    softWrap: true,
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        style: const TextStyle(
                            fontSize: 12.0, color: Colors.black),
                        text: eula),
                  )),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Close",
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void _registerUser() {
    String name = _nameEditingController.text;
    String email = _emailEditingController.text;
    String phone = _phoneEditingController.text;
    String address = _addrEditingController.text;
    String pass = _passEditingController.text;

    http.post(
        Uri.parse("${ServerConfig.server}/bookbyte/php/register_user.php "),
        body: {
          "name": name,
          "email": email,
          "phone": phone,
          "address": address,
          "password": pass
        }).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Registration Success"),
            backgroundColor: Colors.green,
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Registration Failed"),
            backgroundColor: Colors.red,
          ));
        }
      }
    });
  }

  void _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    userpos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("${userpos.latitude} : ${userpos.longitude}");
    _getAddress(userpos);
    //_addrEditingController.text = "${userpos.latitude} : ${userpos.longitude}";
    // setState(() {});
  }

  _getAddress(Position pos) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);
    if (placemarks.isEmpty) {
    } else {
      addr =
          "${placemarks[0].street}\n${placemarks[0].locality}\n${placemarks[0].postalCode} ${placemarks[0].administrativeArea}";
    }
    _addrEditingController.text = addr;
    setState(() {});
  }

  int generateIds() {
    var rng = Random();
    int randomInt;
    randomInt = rng.nextInt(100);
    return randomInt;
  }

  void showMapDialog() {
    Set<Marker> markers = {};
    MarkerId markerId1 = MarkerId(generateIds().toString());
    markers.add(Marker(
      markerId: markerId1,
      position: LatLng(userpos.latitude, userpos.longitude),
      infoWindow: InfoWindow(
        title: 'Address',
        snippet: addr,
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ));

    final Completer<GoogleMapController> mapcontroller =
        Completer<GoogleMapController>();

    CameraPosition defaultLocation = CameraPosition(
      target: LatLng(
        userpos.latitude,
        userpos.longitude,
      ),
      zoom: 14.4746,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            title: const Text(
              "Select Your Location",
              style: TextStyle(),
            ),
            content: SizedBox(
              width: screenWidth,
              child: Column(
                children: [
                  Expanded(
                    child: GoogleMap(
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      initialCameraPosition: defaultLocation,
                      onMapCreated: (GoogleMapController controller) {
                        mapcontroller.complete(controller);
                      },
                      markers: markers.toSet(),
                      onTap: (LatLng latLng) async {
                        await _getAddress2(latLng);
                        markers.clear();
                        MarkerId markerId1 = MarkerId(generateIds().toString());
                        markers.add(Marker(
                          markerId: markerId1,
                          position: LatLng(latLng.latitude, latLng.longitude),
                          infoWindow: InfoWindow(
                            title: 'Address',
                            snippet: addr,
                          ),
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueMagenta),
                        ));
                        setState(() {});
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(addr),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Close",
                  style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
      },
    );
  }

  Future<void> _getAddress2(LatLng latLng) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    if (placemarks.isEmpty) {
    } else {
      addr =
          "${placemarks[0].street}\n${placemarks[0].locality}\n${placemarks[0].postalCode} ${placemarks[0].administrativeArea}";
    }
    _addrEditingController.text = addr;
    setState(() {});
  }
}
