import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../forms/plant_form_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../forms/login_page.dart';
import '../main_page.dart';
import '../side_drawer_screens/about_us_screen.dart';
import '../side_drawer_screens/profile_screen.dart';

class PlantATreeScreen extends StatefulWidget {
  const PlantATreeScreen({Key? key}) : super(key: key);

  @override
  State<PlantATreeScreen> createState() => _PlantATreeScreenState();
}

class _PlantATreeScreenState extends State<PlantATreeScreen> {


  List<LatLng> positions = [];
  List<String> latitudes = [];
  List<String> longitudes = [];
  Set<Marker> markers = Set();

  static const _initialCameraPosition = CameraPosition(
      target: LatLng(31.0409, 31.3785),
      zoom: 10
  );

  late GoogleMapController _googleMapController ;




  void getPositions() async {

    await FirebaseFirestore.instance.collection('trees').get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        latitudes.add(doc["lat"].toString());
      });
    });

    await FirebaseFirestore.instance.collection('trees').get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        longitudes.add(doc["long"].toString());
      });
    });

    for(int i =0 ; i<latitudes.length; i++){
      positions.add(LatLng(double.parse(latitudes[i]), double.parse(longitudes[i])));
    }
    print(positions);

    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 3.2),
      "Icons/small_tree.png",
    );
    for(int i=0; i< positions.length; i++){
      markers.add(
          Marker(
            markerId: MarkerId(i.toString()),
            position: positions[i],
            infoWindow: InfoWindow(
              title: 'tree planted',
            ),
            icon: markerbitmap,
          )
      );
    }

    setState(() {});

  }

  @override
  void initState(){
    getPositions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                padding: EdgeInsets.zero,
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: SizedBox(
                      width: 150, height: 150, child: Image.asset('images/splash.png'),),
                  ),
                )),

            ListTile(
              title: Text("Home"),
              subtitle: Text("Go to home page"),
              trailing: Icon(Icons.home),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainPage()),
                );
              },
            ),

            ListTile(
              title: Text("User profile"),
              subtitle: Text("See your personal info"),
              trailing: Icon(Icons.person),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
            ),

            ListTile(
              title: Text("About us"),
              subtitle: Text("See more about Breathe"),
              trailing: Icon(Icons.info),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutUsScreen()),
                );
              },
            ),
            const SizedBox(height: 60,),
            const Divider(),
            ListTile(
              title: const Text("Logout"),
              subtitle: const Text("Log out from your personal account"),
              trailing: const Icon(Icons.exit_to_app),
              onTap: () async{
                final prefs = await SharedPreferences.getInstance() ;
                prefs.setBool("isLogin", false);
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xffffffff),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (controller) => _googleMapController = controller,
        onTap: (LatLng latLng) {
          print('lat and long is: $latLng');
        },
        markers: Set<Marker>.of(markers),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PlantForm(),));
        },
        child:  Padding(
          padding: const EdgeInsets.all(7.0),
          child: Image.asset("Icons/rsz_plant.png"),
        )
      ),
    );
  }




}
