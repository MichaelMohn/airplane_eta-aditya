import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map_route/map_request.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

  bool loading = true;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  Set<Polyline> get polyLines => _polyLines;
  Completer<GoogleMapController> _controller = Completer();
  LatLng latLng;
  LatLng cameraPos = LatLng(29.7174, -95.4018);
  LocationData currentLocation;

  List<int> avgTimes = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

  @override
  void initState() {
    getLocation();
    loading = true;
    for (int i = 0; i < times.length; i++) {
      avgTimes[i % 18] += times[18];
    }
    for (int i = 0; i < avgTimes.length; i++) {
      avgTimes[i] = avgTimes[i] ~/ 7;
    }
    super.initState();
  }


  getLocation() async {

    var location = new Location();
    location.onLocationChanged().listen((  currentLocation) {

      print(currentLocation.latitude);
      print(currentLocation.longitude);
      setState(() {
        latLng =  LatLng(currentLocation.latitude, currentLocation.longitude);
      });

      print("getLocation:$latLng");
      _onAddMarkerButtonPressed();
      loading = false;
    });

  }



  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId("111"),
        position: latLng,
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }


  void onCameraMove(CameraPosition position) {
    cameraPos = position.target;
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  Future<LatLng> getLatLong(String search) async {
    var uri =  new Uri.https("maps.googleapis.com", "maps/api/place/findplacefromtext/json",{
      "key":"AIzaSyBFQFljRYpN0WriPSyCwnwK0ts3a94Hg5A",
      "input":search,
      "inputtype":'textquery',
      "fields":"geometry"
    });

    var response = await http.get(
      uri,
    );

    final responseJson = json.decode(response.body);

    LatLng ltlng = LatLng(responseJson["candidates"][0]["geometry"]["location"]["lat"], responseJson["candidates"][0]["geometry"]["location"]["lng"]);

    return ltlng;
  }

  Future<String> getTime(LatLng endLatlng, int hour) async {
    var uri =  new Uri.https("maps.googleapis.com", "maps/api/directions/json",{
      "key":"AIzaSyBFQFljRYpN0WriPSyCwnwK0ts3a94Hg5A",
      "origin":"${latLng.latitude},${latLng.longitude}",
      "destination":"${endLatlng.latitude},${endLatlng.longitude}",
    });

    var response = await http.get(
      uri,
    );

    final responseJson = json.decode(response.body);

    String time = responseJson["routes"][0]["legs"][0]["duration"]["text"];

    print(time);

    int hrs = 0;
    List<String> list = time.split(" hours ");
    if (list.length > 1) {
      hrs += int.parse(list[0]);
    }

    list = time.split(" hour ");
    if (list.length > 1) {
      hrs += int.parse(list[0]);
    }


    int mins = int.parse(time.substring(time.indexOf(" mins") - 3, time.indexOf(" mins")));

    print(mins);

    mins += avgTimes[hour - 4];

    mins += hrs * 60;

    hrs = mins ~/ 60;

    mins = mins % 60;

    if (hrs > 0) {
      return hrs.toString() + " hours " + mins.toString() + " minutes";
    }
    else {
      return mins.toString() + " minutes";
    }

  }

  void sendRequest() async {
    LatLng destination = await getLatLong("IAH");
    String route = await _googleMapsServices.getRouteCoordinates(
        latLng, destination);
    String time = await getTime(destination, 10);
    print(time);
    createRoute(route);
    _addMarker(destination,"KTHM Collage");
  }

  void createRoute(String encondedPoly) {
    setState(() {
      _polyLines.clear();
      _polyLines.add(Polyline(
          polylineId: PolylineId(latLng.toString()),
          width: 4,
          points: _convertToLatLng(_decodePoly(encondedPoly)),
          color: Colors.red));
    });
  }

  void _addMarker(LatLng location, String address) {
    _markers.add(Marker(
        markerId: MarkerId("112"),
        position: location,
        infoWindow: InfoWindow(title: address, snippet: "go here"),
        icon: BitmapDescriptor.defaultMarker));
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;

      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

  @override
  Widget build(BuildContext context) {
    print("getLocation111:$latLng");
    return new Scaffold(

      body:
      loading
          ?
      CircularProgressIndicator()
          :
      GoogleMap(
        polylines: polyLines,
        markers: _markers,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: cameraPos,
          zoom: 14.4746,
        ),
        onCameraMove:  onCameraMove,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          sendRequest();
        },
        label: Text('Destination'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }


  List<int> times = [
    17,
    32,
    10,
    6,
    14,
    10,
    17,
    9,
    7,
    8,
    27,
    32,
    24,
    23,
    23,
    27,
    6,
    13,
    37,
    40,
    24,
    17,
    16,
    26,
    25,
    10,
    9,
    12,
    23,
    17,
    17,
    14,
    13,
    11,
    7,
    19,
    16,
    17,
    28,
    12,
    12,
    18,
    21,
    31,
    11,
    8,
    16,
    18,
    12,
    10,
    13,
    11,
    9,
    7,
    16,
    6,
    34,
    33,
    26,
    10,
    22,
    9,
    7,
    19,
    25,
    45,
    25,
    22,
    33,
    34,
    10,
    19,
    16,
    30,
    11,
    11,
    7,
    15,
    7,
    4,
    7,
    8,
    16,
    15,
    19,
    19,
    14,
    19,
    20,
    10,
    28,
    12,
    15,
    18,
    14,
    8,
    6,
    9,
    13,
    11,
    23,
    18,
    24,
    34,
    28,
    18,
    32,
    8,
    24,
    5,
    4,
    9,
    8,
    4,
    5,
    9,
    16,
    12,
    25,
    17,
    16,
    30,
    17,
    17,
    18,
  ];
}
