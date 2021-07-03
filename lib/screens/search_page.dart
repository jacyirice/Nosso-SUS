import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nossosus_app/screens/detalhes_ubs_page.dart';
import 'package:nossosus_app/shared/themes/app_colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'bottom_bar.dart';

// Fornece a distancia entre duas coordenadas
num _coordinateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}

class SearchPage extends StatefulWidget {
  String search_service;
  String search_city;

  SearchPage({this.search_service = '', this.search_city = '', Key? key})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Marker> _markers = <Marker>[];

  final _myControllerSearch = TextEditingController();
  List<String> citys = ['Cidade'];
  String _dropdownCityValue = 'Cidade';

  var _currentLoc = null;
  var _controller;

  // Coordenadas do centro de palmas
  double lat = -10.1881423;
  double long = -48.3462844;

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
                          _currentLoc = null;
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

  bool _checkFilter(data, search_city, search_service) {
    bool flag = true;
    if (search_city.isNotEmpty) {
      if (!data['cidade'].toLowerCase().contains(search_city.toLowerCase()))
        flag = false;
    }
    if (flag && search_service.isNotEmpty) {
      if (!data['servico'].toLowerCase().contains(search_service.toLowerCase()))
        flag = false;
    }
    return flag;
  }

  LatLngBounds getLatLngBoundsCurrentLocate(currentLocLatLng, markerCloser) {
    LatLng northeast;
    LatLng southwest;
    if (currentLocLatLng.latitude > markerCloser.position.latitude) {
      southwest = markerCloser.position;
      northeast = currentLocLatLng;
    } else {
      northeast = LatLng(
        markerCloser.position.latitude,
        currentLocLatLng.longitude,
      );
      southwest = LatLng(
        currentLocLatLng.latitude,
        markerCloser.position.longitude,
      );
    }
    LatLngBounds bound =
        LatLngBounds(northeast: northeast, southwest: southwest);
    return bound;
  }

  void get_makers(snapshot) {
    num distanceInMeters = 0;
    Marker? markerCloser;
    List<Marker> aux = <Marker>[];

    for (DocumentSnapshot document in snapshot.data.docs) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      if (!citys.contains(data['cidade'])) citys.add(data['cidade']);
      if (_checkFilter(data, widget.search_city, widget.search_service)) {
        aux.add(
          Marker(
            markerId: MarkerId(document.id),
            position: LatLng(
              double.parse(data['loc_lat']),
              double.parse(data['loc_long']),
            ),
            infoWindow: InfoWindow(
              title: data['nome'],
              // snippet: data['servico'],
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
          ),
        );
        if (_currentLoc != null) {
          num auxDistance = _coordinateDistance(
            _currentLoc.latitude,
            _currentLoc.longitude,
            aux[aux.length - 1].position.latitude,
            aux[aux.length - 1].position.longitude,
          );
          if (distanceInMeters <= 0) {
            distanceInMeters = auxDistance;
            markerCloser = aux[aux.length - 1];
          } else if (auxDistance < distanceInMeters) {
            distanceInMeters = auxDistance;
            markerCloser = aux[aux.length - 1];
          }
        }
      }
    }
    if (_currentLoc != null) {
      LatLng currentLocLatLng = LatLng(
        _currentLoc.latitude,
        _currentLoc.longitude,
      );
      aux.add(
        Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueAzure,
          ),
          markerId: MarkerId('home'),
          position: currentLocLatLng,
          infoWindow: InfoWindow(
            title: 'Sua localização',
          ),
        ),
      );
      if (markerCloser != null) {
        _controller.animateCamera(
          CameraUpdate.newLatLngBounds(
            getLatLngBoundsCurrentLocate(currentLocLatLng, markerCloser),
            50,
          ),
        );
      }
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
                  _currentLoc = value;
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
              initialCameraPosition: _initialCameraPosition(
                lat = lat,
                long = long,
                zoom: 9,
              ),
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
