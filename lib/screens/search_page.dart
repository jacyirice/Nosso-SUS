import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nossosus_app/screens/detalhes_ubs_page.dart';
import 'package:nossosus_app/shared/themes/app_colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nossosus_app/widgets/bottom_bar_widget.dart';
import 'package:nossosus_app/widgets/centered_circular_progress_indicator.dart';

const double zoomDefault = 9.0;
// Coordenadas do centro de palmas-TO
const double lat = -10.1881423;
const double long = -48.3462844;

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
  String searchService;
  String searchCity;

  SearchPage({this.searchService = '', this.searchCity = '', Key? key})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _myControllerSearch = TextEditingController();
  List<Marker> _markers = <Marker>[];
  GoogleMapController? _controller;
  List<String> citys = ['Cidade'];
  String _dropdownCityValue = 'Cidade';

  Position? _currentLoc;

  Stream<QuerySnapshot> ubsStream =
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

  bool _checkFilter(Map<String, dynamic> data, searchCity, searchService) {
    if (searchCity.isNotEmpty) {
      if (!data['cidade'].toLowerCase().contains(searchCity.toLowerCase())) {
        return false;
      }
    }
    if (searchService.isNotEmpty) {
      if (!data['servico']
          .toLowerCase()
          .contains(searchService.toLowerCase())) {
        return false;
      }
    }
    return true;
  }

  LatLngBounds _getLatLngBoundsCurrentLocate(currentLocLatLng, markerCloser) {
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

  Marker _createMarker(
    String id,
    double locLat,
    double locLong,
    String infoWindowTitle,
    String urlUbs,
  ) {
    return Marker(
      markerId: MarkerId(id),
      position: LatLng(locLat, locLong),
      infoWindow: InfoWindow(
        title: infoWindowTitle,
        // snippet: data['servico'],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetalheUbsPage(linkUbs: urlUbs),
            ),
          );
        },
      ),
    );
  }

  Marker _createUserMarker(userLoc) {
    LatLng latLngUser = LatLng(
      userLoc.latitude,
      userLoc.longitude,
    );

    return Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueAzure,
      ),
      markerId: MarkerId('home'),
      position: latLngUser,
      infoWindow: const InfoWindow(
        title: 'Sua localização',
      ),
    );
  }

  void _createInitialMakers(AsyncSnapshot<QuerySnapshot> snapshot) {
    num distanceInMeters = 0;
    Marker? markerCloser;
    List<Marker> aux = <Marker>[];

    for (DocumentSnapshot document in snapshot.data!.docs) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      if (!citys.contains(data['cidade'])) citys.add(data['cidade']);
      if (_checkFilter(data, widget.searchCity, widget.searchService)) {
        aux.add(
          _createMarker(
            document.id,
            double.parse(data['loc_lat']),
            double.parse(data['loc_long']),
            data['nome'],
            data['link'],
          ),
        );
        if (_currentLoc != null) {
          num auxDistance = _coordinateDistance(
            _currentLoc!.latitude,
            _currentLoc!.longitude,
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
      Marker userMarker = _createUserMarker(_currentLoc!);
      aux.add(userMarker);
      if (markerCloser != null) {
        _controller!.animateCamera(
          CameraUpdate.newLatLngBounds(
            _getLatLngBoundsCurrentLocate(userMarker.position, markerCloser),
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
      appBar: _buildAppBar(),
      backgroundColor: AppColors.background,
      body: _buildStreamBuilder(),
      bottomNavigationBar: const BottomBarWidget(ButtonSelected.services),
    );
  }

  _showSnackBar(message, showAction) {
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

  _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text('Pesquisar serviços'),
      actions: [
        IconButton(
          icon: const Icon(Icons.place),
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
            icon: const Icon(Icons.search),
            onPressed: () {
              _showSearchForm(context);
            }),
      ],
    );
  }

  _buildStreamBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: ubsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          _showSnackBar('Ocorreu um erro. ${snapshot.error}', true);
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CenteredCircularProgressIndicator();
        }
        if (snapshot.hasData) {
          _createInitialMakers(snapshot);
          return GoogleMap(
            markers: Set<Marker>.of(_markers),
            mapType: MapType.terrain,
            onMapCreated: _onMapCreated,
            initialCameraPosition:
                _initialCameraPosition(lat, long, zoom: zoomDefault),
          );
        } else {
          return const Center(child: Icon(Icons.error));
        }
      },
    );
  }

  _buildSearchAlertDialog() {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _myControllerSearch,
              decoration: InputDecoration(
                labelText: 'Pesquisa',
                labelStyle: const TextStyle(color: AppColors.primary),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
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
                  items: citys.map<DropdownMenuItem<String>>((String value) {
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
              child: const Text(
                "Pesquisar",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              onPressed: () {
                widget.searchService = _myControllerSearch.text;
                widget.searchCity =
                    _dropdownCityValue != 'Cidade' ? _dropdownCityValue : '';
                Navigator.pop(context);
                setState(() {});
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.primary),
              ),
            ),
          )
        ],
      ),
    );
  }

  _showSearchForm(context) {
    AlertDialog alert = _buildSearchAlertDialog();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
