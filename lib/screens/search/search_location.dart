import 'dart:async';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:feminae/utils/credentials.dart';

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: GOOGLE_PLACES_API_KEY);

final customTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.dark,
  accentColor: Colors.redAccent,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 12.5,
      horizontal: 10.0,
    ),
  ),
);

class RoutesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: customTheme,
      routes: {
        '/': (_) => MyApp(),
        '/search': (_) => CustomSearchScaffold(),
      },
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();

class _MyAppState extends State<MyApp> {
  Mode _mode = Mode.overlay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        title: Text('MyApp'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildDropDownMenu(),
            RaisedButton(
              onPressed: _handlePressButton,
              child: Text('Search Places'),
            ),
            RaisedButton(onPressed: () {
              Navigator.of(context).pushNamed('/search');
            })
          ],
        ),
      ),
    );
  }

  Widget _buildDropDownMenu() => DropdownButton(
        value: _mode,
        items: <DropdownMenuItem<Mode>>[
          DropdownMenuItem<Mode>(
            child: Text('Overlay'),
            value: Mode.overlay,
          ),
          DropdownMenuItem<Mode>(
            child: Text('Fullscreen'),
            value: Mode.fullscreen,
          ),
        ],
        onChanged: (m) {
          setState(() {
            _mode = m;
          });
        },
      );

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(response.errorMessage),
    ));
  }

  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: GOOGLE_PLACES_API_KEY,
      onError: onError,
      mode: _mode,
      language: "fr",
      components: [Component(Component.country, "fr")],
    );

    displayPrediction(p, homeScaffoldKey.currentState);
  }
}

Future<Null> displayPrediction(
    Prediction p, ScaffoldState scaffoldState) async {
  if (p != null) {
    // get detail (lat / lng)
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
    final lat = detail.result.geometry.location.lat;
    final lng = detail.result.geometry.location.lng;

    scaffoldState.showSnackBar(
      SnackBar(content: Text('${p.description} - $lat/$lng')),
    );
  }
}

// Custom Scaffold that handles search
// basically your widgets need to extends GooglePlacesAutoCompleteWidget
// and your state GooglePlacesAutoCompleteState

class CustomSearchScaffold extends PlacesAutocompleteWidget {
  CustomSearchScaffold()
      : super(
          apiKey: GOOGLE_PLACES_API_KEY,
          sessionToken: Uuid().generateV4(),
          language: 'en',
          components: [Component(Component.country, "uk")],
        );

  @override
  _CustomSearchScaffoldState createState() => _CustomSearchScaffoldState();
}

class _CustomSearchScaffoldState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: AppBarPlacesAutoCompleteTextField());
    final body = PlacesAutocompleteResult(
      onTap: (p) {
        displayPrediction(p, searchScaffoldKey.currentState);
      },
      logo: Row(
        children: [FlutterLogo()],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
    return Scaffold(
      key: searchScaffoldKey,
      appBar: appBar,
      body: body,
    );
  }

  @override
  void onResponse(PlacesAutocompleteResponse res) {
    super.onResponse(res);
    if (res != null && res.predictions.isNotEmpty) {
      searchScaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text('Got answer')),
      );
    }
  }

  @override
  void onResponseError(PlacesAutocompleteResponse res) {
    super.onResponseError(res);
    searchScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(res.errorMessage)),
    );
  }
}

class Uuid {
  final Random _random = Random();

  String generateV4() {
    // Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
    final int special = 8 + _random.nextInt(4);

    return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
        '${_bitsDigits(16, 4)}-'
        '${_bitsDigits(12, 3)}-'
        '${_bitsDigits(special, 1)}${_bitsDigits(12, 3)}-'
        '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
  }

  String _bitsDigits(int bitCount, int digitCount) =>
      _printDigits(_generateBits(bitCount), digitCount);

  int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);

  String _printDigits(int value, int count) =>
      value.toRadixString(16).padLeft(count, '0');
}
