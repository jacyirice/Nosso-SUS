import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nossosus_app/screens/detalhes_ubs_page.dart';
import 'package:nossosus_app/shared/themes/app_colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'bottomBar.dart';

class SearchPage extends StatefulWidget {
  String search_service;
  String search_city;

  SearchPage({this.search_service = '', this.search_city = '', Key? key})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _myControllerSearch = TextEditingController();
  String _dropdownCityValue = 'Cidade';
  List<String> citys = ['Cidade'];
  var _controller;
  double lat = -10.1707379;
  double long = -48.3090628;

  Stream<QuerySnapshot> UbsStream =
      FirebaseFirestore.instance.collection('sus').snapshots();

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    _showSnackBar('Buscando informações...', false);
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

  CameraPosition _initialCameraPosition(lat, long, {double zoom = 14}) {
    return CameraPosition(
      target: LatLng(lat, long),
      zoom: zoom,
    );
  }

  void _showSearchForm(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _myControllerSearch,
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
                    padding: EdgeInsets.all(8.0),
                    child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return DropdownButton(
                        value: _dropdownCityValue,
                        iconSize: 24,
                        elevation: 16,
                        onChanged: (String? v) {
                          _dropdownCityValue = v!;
                          setState(() {});
                        },
                        items:
                            citys.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      );
                    })),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text(
                      "Pesquisar",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    onPressed: () {
                      widget.search_service = _myControllerSearch.text;
                      widget.search_city = _dropdownCityValue != 'Cidade'
                          ? _dropdownCityValue
                          : '';
                      Navigator.pop(context);
                      setState(() {});
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.primary)),
                  ),
                )
              ],
            ),
          );
        });
  }

  void _showSnackBar(message, showAction) {
    final snackBar = SnackBar(
      content: Text(message),
      action: showAction
          ? SnackBarAction(
              label: 'Continuar',
              onPressed: () {},
            )
          : null,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  List<Marker> _markers = <Marker>[];

  get_makers(snapshot) {
    List<Marker> aux = <Marker>[];
    for (DocumentSnapshot document in snapshot.data.docs) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      if (!citys.contains(data['cidade'])) citys.add(data['cidade']);
      bool flag = true;

      if (widget.search_city.isNotEmpty) {
        if (!data['cidade']
            .toLowerCase()
            .contains(widget.search_city.toLowerCase())) flag = false;
      }
      if (flag && widget.search_service.isNotEmpty) {
        if (!data['servico']
            .toLowerCase()
            .contains(widget.search_service.toLowerCase())) flag = false;
      }
      if (flag)
        aux.add(
          Marker(
            // icon: BitmapDescriptor.from.fromBytes(Icons.help_center.t),
            markerId: MarkerId(document.id),
            position: LatLng(
              double.parse(data['loc_lat']),
              double.parse(data['loc_long']),
            ),
            infoWindow: InfoWindow(
              title: data['nome'],
              snippet: data['servico'],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetalheUbsPage(
                    linkUbs: data['link'],
                  ),
                ),
              );
            },
          ),
        );
    }
    _markers = aux;
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
                  _showSnackBar(e.toString(), true);
                },
              );
            },
          ),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _showSearchForm(context);
              }),
        ],
      ),
      backgroundColor: AppColors.background,
      body: StreamBuilder<QuerySnapshot>(
        stream: UbsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            () => _showSnackBar('Ocorreu um erro. ${snapshot.error}', true);
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            get_makers(snapshot);
            return GoogleMap(
              markers: Set<Marker>.of(_markers),
              mapType: MapType.terrain,
              onMapCreated: _onMapCreated,
              initialCameraPosition:
                  _initialCameraPosition(lat = lat, long = long, zoom: 9),
            );
          } else {
            return Center(
              child: Icon(Icons.error),
            );
          }
        },
      ),
      bottomNavigationBar: AppBottom(
        activeBottom: 1,
      ),
    );
  }
}
