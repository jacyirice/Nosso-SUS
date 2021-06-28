import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nossosus_app/screens/home_page.dart';
import 'package:nossosus_app/shared/themes/app_colors.dart';
import 'package:geolocator/geolocator.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _currencies = [
    "Food",
    "Transport",
    "Personal",
    "Shopping",
    "Medical",
    "Rent",
    "Movie",
    "Salary"
  ];
  final _formKey = GlobalKey<FormState>();
  var _controller;
  double lat = -10.1707379;
  double long = -48.3090628;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    _showSnackBar('Buscando informações...');
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Os serviços de localização estão desativados.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permissões de localização negadas.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'As permissões de localização são negadas permanentemente, não podemos solicitar permissões.');
    }
    return await Geolocator.getCurrentPosition();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  CameraPosition _initialCameraPosition(lat, long) {
    return CameraPosition(
      target: LatLng(lat, long),
      zoom: 14.4746,
    );
  }

  void _showSearchForm(_formKey, context) {
    String _category = '0';
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Pesquisa',
                        labelStyle: TextStyle(color: AppColors.primary),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text("Pesquisar"),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void _showSnackBar(message) {
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Continuar',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Pesquisar serviços'),
          actions: [
            IconButton(
              icon: Icon(Icons.place),
              onPressed: () {
                _determinePosition().then(
                  (value) {
                    _controller.animateCamera(
                      CameraUpdate.newCameraPosition(
                        _initialCameraPosition(value.latitude, value.longitude),
                      ),
                    );
                    setState(() {});
                  },
                ).catchError(
                  (e, stackTrace) {
                    _showSnackBar(e.toString());
                  },
                );
              },
            ),
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  _showSearchForm(_formKey, context);
                }),
          ],
        ),
        backgroundColor: AppColors.background,
        body: GoogleMap(
          mapType: MapType.hybrid,
          onMapCreated: _onMapCreated,
          initialCameraPosition: _initialCameraPosition(lat = lat, long = long),
        ),
        bottomNavigationBar: AppBottom(
          activeBottom: 1,
        ));
  }
}
