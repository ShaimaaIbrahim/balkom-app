import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:ojos_app/core/localization/translations.dart';
import 'package:ojos_app/core/res/app_assets.dart';
import 'package:ojos_app/core/res/edge_margin.dart';
import 'package:ojos_app/core/res/global_color.dart';
import 'package:ojos_app/core/res/screen/vertical_padding.dart';
import 'package:ojos_app/core/res/text_style.dart';
import 'package:ojos_app/core/res/utils.dart';
import 'package:ojos_app/core/ui/widget/button/rounded_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:place_picker/entities/location_result.dart';

class ProfileLocationPage extends StatefulWidget {
  final double? width;
  final double? height;

  const ProfileLocationPage({this.width, this.height});

  @override
  _ProfileLocationPageState createState() => _ProfileLocationPageState();
}

class _ProfileLocationPageState extends State<ProfileLocationPage> {
  var _cancelToken = CancelToken();

  /// city parameters
  bool _cityValidation = false;
  String _city = '';
  final TextEditingController cityEditingController =
      new TextEditingController();

  /// ------------------------------------
  Set<Marker> markers = {};

  /// initial position
  CameraPosition _initialLocation =
      CameraPosition(target: LatLng(40.712776, -74.005974), zoom: 13);
  Completer<GoogleMapController> _mapController = Completer();

  ///
  Map<PolylineId, Polyline> polylines = {};
  BitmapDescriptor? pinLocationIcon;

  ///
  GoogleMapController? mapController;

  ///
  Position? _currentPosition;
  String? _currentAddress;

  Permission _permission = Permission.location;
  PermissionStatus _permissionStatus = PermissionStatus.denied;

  // Method for retrieving the current location
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      if (mounted)
        setState(() {
          _currentPosition = position;
          print('CURRENT POS: $_currentPosition');
          mapController!.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                // target: LatLng(40.732128, -73.999619),
                zoom: 13.0,
              ),
            ),
          );

          markers.add(Marker(
              markerId: MarkerId('current_Postion'),
              infoWindow: InfoWindow(title: 'Current Position'),
              position: LatLng(position.latitude, position.longitude),
              icon: pinLocationIcon!));
        });
      await _getAddress();
    }).catchError((e) {
      print(e);
    });
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), AppAssets.location_png);
  }

  // Method for retrieving the address
  _getAddress() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = p[0];
      if (mounted)
        setState(() {
          _currentAddress =
              "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
          // startAddressController.text = _currentAddress;
          // _startAddress = _currentAddress;
        });
    } catch (e) {
      print(e);
    }
  }

  void _listenForPermissionStatus() async {
    final status = await _permission.status;
    if (mounted) setState(() => _permissionStatus = status);
    if (_permissionStatus.isGranted) {
      await _getCurrentLocation();
    } else {
      requestPermission(_permission);
    }
  }

  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();
    if (mounted)
      setState(() {
        print(status);
        _permissionStatus = status;
        print(_permissionStatus);
      });
    if (_permissionStatus.isGranted) {
      await _getCurrentLocation();
    }
  }

  /// ------------------------------------

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCustomMapPin();
    _listenForPermissionStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(
        // fit: StackFit.expand,
        children: [
          GoogleMap(
            initialCameraPosition: _initialLocation,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            polylines: Set<Polyline>.of(polylines.values),
            markers: Set<Marker>.from(markers),
            onMapCreated: (GoogleMapController controller) async {
              mapController = controller;
              // controller.setMapStyle(_mapStyle);
              // await  createMArker();
            },
          ),
          Column(
            children: [
              //    _buildSearchWidget(width: widget.width, context: context),
              Spacer(),
              VerticalPadding(
                percentage: 4.0,
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: EdgeMargin.min, right: EdgeMargin.min),
                child: _buildDetectingLocationWidget(
                    context: context, width: widget.width!, height: 41.h),
              ),
              VerticalPadding(
                percentage: 1.0,
              ),
              Container(
                  padding: const EdgeInsets.only(
                      left: EdgeMargin.min, right: EdgeMargin.min),
                  child: RoundedButton(
                    height: 55.h,
                    width: widget.width,
                    color: globalColor.primaryColor,
                    onPressed: () {
                      requestPermission(_permission);
                    },
                    borderRadius: 8.w,
                    child: Container(
                      child: Center(
                        child: Text(
                          Translations.of(context)
                              .translate('my_site_is_approved'),
                          style: textStyle.smallTSBasic
                              .copyWith(color: globalColor.white),
                        ),
                      ),
                    ),
                  )),
              VerticalPadding(
                percentage: 1.0,
              ),
            ],
          ),
        ],
      ),
    );
  }

/*  _buildSearchWidget({BuildContext context, double width}) {
    return Padding(
      padding: const EdgeInsets.all(EdgeMargin.small),
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: globalColor.white,
          borderRadius: BorderRadius.circular(12.0.w),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5, // has the effect of softening the shadow
              spreadRadius: 0, // has the effect of extending the shadow
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Center(
                        child: Icon(
                          EvilIcons.search,
                          size: 28.w,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50.h,
                    color: globalColor.grey.withOpacity(0.2),
                    width: .5,
                  )
                ],
              ),
            ),
            Expanded(
                flex: 6,
                child: TextField(
                  decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText: "بحث في الاماكن",
                      hintStyle: textStyle.smallTSBasic
                          .copyWith(color: globalColor.grey))
                  ,
                  onTap: (){
                    showPlacePicker();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return PlacePicker(
                    //         apiKey: 'AIzaSyBJzh10NWpI0_XqmOV4v4AaH1QNx4CskpQ',
                    //         initialPosition: LatLng(40.712776, -74.005974),
                    //         useCurrentLocation: true,
                    //         selectInitialPosition: true,
                    //
                    //         //usePlaceDetailSearch: true,
                    //         onPlacePicked: (result) {
                    //           // selectedPlace = result;
                    //           Navigator.of(context).pop();
                    //           setState(() {});
                    //         },
                    //       );
                    //     },
                    //   ),
                    // );
                  },
                  readOnly: true,
                )),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Container(
                    height: 50.h,
                    color: globalColor.grey.withOpacity(0.2),
                    width: .5,
                  ),
                  Expanded(
                    flex: 1,
                    child: SvgPicture.asset(
                      AppAssets.filter,
                      width: 22,
                      height: 22,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }*/
  void showPlacePicker() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
              apiKey: 'AIzaSyBJzh10NWpI0_XqmOV4v4AaH1QNx4CskpQ',
              initialPosition: LatLng(40.712776, -74.005974),
              useCurrentLocation: false,
            )));

    // Handle the result in your way
    print(result);
  }

  _buildDetectingLocationWidget({
    required BuildContext context,
    required double width,
    required double height,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: globalColor.white,
        borderRadius: BorderRadius.all(Radius.circular(12.w)),
        border:
            Border.all(color: globalColor.grey.withOpacity(0.3), width: 0.5),
      ),
      padding: const EdgeInsets.only(
        left: EdgeMargin.subMin,
        right: EdgeMargin.subMin,
      ),
      height: height,
      width: width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Text(
              Translations.of(context).translate('automatic_locating_by'),
              style: textStyle.smallTSBasic.copyWith(
                  color: globalColor.black, fontWeight: FontWeight.w600),
            ),
          ),
          Icon(
            utils.getLang() == 'ar'
                ? Icons.keyboard_arrow_left
                : Icons.keyboard_arrow_right,
            color: globalColor.black,
          ),
        ],
      ),
    );
  }
}
