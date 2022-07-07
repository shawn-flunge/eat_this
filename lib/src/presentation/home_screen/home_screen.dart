
import 'package:eat_this/src/core/constants.dart';
import 'package:eat_this/src/presentation/home_screen/home_screen_controller.dart';
import 'package:eat_this/src/presentation/home_screen/widgets/my_location_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late HomeScreenController controller;

  @override
  void initState() {
    super.initState();
    temp();
    controller = HomeScreenController();
  }

  temp() async{
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScreenScaffoldKey,
      body: Stack(
        children: <Widget>[
          StreamBuilder<List<Marker>>(
            stream: controller.markerStream.stream,
            initialData: const [],
            builder: (context, snapShot){
              return GoogleMap(
                initialCameraPosition: controller.initCameraPosition,
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                mapToolbarEnabled: false,
                compassEnabled: false,
                liteModeEnabled: false,
                buildingsEnabled: false,
                myLocationEnabled: false,
                markers: snapShot.data!.toSet(),
                onMapCreated: (googleMapController){
                  final double pixelRatio = MediaQuery.of(context).devicePixelRatio;
                  controller.onMapCreated(googleMapController, pixelRatio);
                },
                onCameraMove: controller.onCameraMove,
                onTap: controller.onTap,
              );
            }
          ),
          const MyLocationInScreen(),
          Positioned(
            right: 10,
            bottom: 170,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 10
                  )
                ]
              ),
              child: InkWell(
                onTap: controller.onCurrentLocationButtonTap,
                child: const Icon(
                  Icons.my_location,
                ),
              )
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 30,
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 10
                  )
                ]
              ),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.directions_walk
                  ),
                  const SizedBox(width: 10,),
                  InkWell(
                    onTap: (){

                    },
                    child: const Text(
                      '500'
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  InkWell(
                    // onTap: getRestaurant,
                    onTap: controller.setRestaurants,
                    child: const Icon(
                      Icons.search
                    ),
                  )

                ],
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 100,
            child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 10
                      )
                    ]
                ),
                child: InkWell(
                  onTap: controller.callNewApi,
                  child: const Icon(
                    Icons.category,
                  ),
                )
            ),
          ),
          StreamBuilder<bool>(
            stream: controller.isSelectedStream.stream,
            initialData: false,
            builder: (context, snapshot) {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                top: (snapshot.data ?? false) ? 70 : -150,
                left: 0,
                right: 0,
                child: Container(
                  // height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 10
                        )
                      ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          (snapshot.data ?? false) ? controller.selectedRestaurant.placeName : '',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                          (snapshot.data ?? false) ? controller.selectedRestaurant.roadAddress : ''
                      ),
                      Text(
                          (snapshot.data ?? false) ? controller.selectedRestaurant.placeCategory.fullName : ''
                      ),
                    ],
                  ),
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}
