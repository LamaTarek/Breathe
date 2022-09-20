import 'package:breathe/services/storage_service.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:geocoder/geocoder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../main_page.dart';
import '../navigation_screens/my_trees_screen.dart';


class PlantForm extends StatefulWidget {
  const PlantForm({Key? key}) : super(key: key);

  @override
  State<PlantForm> createState() => _PlantFormState();
}

class _PlantFormState extends State<PlantForm> {



  final FirebaseAuth auth = FirebaseAuth.instance;
  final Storage storage = Storage(); // class just created - storage service


  String filePath = "";
  String fileName = "";
  String email = "";
  String treeName = "" ;
  String plantingDate = "";
  String species = "";
  String city = "City";
  double lat =0.0;
  double long = 0.0;
  bool isLoading = false;

  //function to get current location , lat , long
  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    Position? lastPosition = await Geolocator.getLastKnownPosition();
    lat = position.latitude;
    long = position.longitude;

    final coordinates = new Coordinates(lat,long);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    var locality = first.locality;
    // print("${first.locality}");
    setState(() {
      city = "$locality";
    });
  }


 //get position permission
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }


  @override
  void initState() {
    _determinePosition();
    getCurrentLocation();
    super.initState();
  }




  final _formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Plant a Tree"),
          leading: IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if(_formkey.currentState!.validate()){
                  save();
                }
              },
              child: Text("Save", style: TextStyle(color: Colors.white, fontSize: 20),),
            ),
          ],
        ),
      body:
          isLoading? Center(child: CircularProgressIndicator()):
      Form(
        key: _formkey,
        child: Center(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                children: [
                  Container(
                      padding: EdgeInsets.all(20),
                      child: DottedBorder(
                        color: Colors.green,
                        strokeWidth: 2,
                        dashPattern: [12,12],   //10 is dash width, 6 is space width
                        child: Container(

                            height:180,
                            width: double.infinity, //width to 100% match to parent container.
                            color:Color(0xffE5E4E2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.park_outlined, color: Colors.green, size: 40,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Upload the Tree Image",),
                              ),
                              ElevatedButton(onPressed: () async{
                                final results = await FilePicker .platform.pickFiles(
                                  allowMultiple: false,
                                  type: FileType.custom,
                                  allowedExtensions: ['png', 'jpg', 'jpeg'],
                                );
                                if(results == null){
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No file selected")));
                                  return null;
                                }
                                 filePath = results.files.single.path!;
                                 fileName = results.files.single.name;
                                 setState(() {});


                              }, child: Text("BROWSE FILES")),
                              Text('$fileName'),
                            ],
                          ),
                        ),
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        validator: (value){
                          if(treeName.isEmpty){
                            return "Tree name is required";
                          }
                        },
                        onChanged: (value){
                          treeName = value;
                        },
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1, color: Colors.grey,
                            ),
                          ),
                          labelText: 'Tree Name',
                          prefixIcon: Icon(Icons.park_outlined, size: 35, color: Colors.green,),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: TextFormField(
                        keyboardType: TextInputType.datetime,
                        validator: (value){
                          if(plantingDate.isEmpty){
                            return "Planting date is required";
                          }
                        },
                        onChanged: (value){
                          plantingDate = value;
                        },
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1, color: Colors.grey,
                            ),
                          ),
                          labelText: 'Planting Date',
                          prefixIcon: Icon(Icons.calendar_today_outlined, size: 30, color: Colors.green,),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        validator: (value){
                          if(species.isEmpty){
                            return "Species is required";
                          }
                        },
                        onChanged: (value){
                          species = value;
                        },
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1, color: Colors.grey,
                            ),
                          ),
                          labelText: 'Species',
                          prefixIcon: Icon(Icons.grass_outlined, size: 35, color: Colors.green,),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Icon(Icons.location_on_outlined,size: 38, color: Colors.green,),
                              Text(city, style: TextStyle(color: Color(
                                  0xff6b7277), fontSize: 17),),
                            ],
                          ),
                        ),
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
  void save() async {
    isLoading = true;
    setState(() {});
      storage.uploadFile(filePath, fileName).then((value) =>
          print('done'));
      final User? user = auth.currentUser;
      final uemail = user?.email;
      final uid = user?.uid;
      email = uemail!;
      isLoading = true;
      try{
        // store in fire store
        await FirebaseFirestore.instance.collection('trees').add({
          'treeName': treeName,
          'plantingDate': plantingDate,
          'species': species,
          'city': city,
          'lat': lat,
          'long': long,
          'email': email,
          'imageName': fileName,
        });
        String treePlanted = "";
        String points = "" ;
        String generalCounter = "";
        //update user collection (tree - points) , update home page counter
        //1- get data , type string
        await FirebaseFirestore.instance.collection('users').doc(uid).get()
            .then((value) =>treePlanted=value['treePlanted'].toString());

        await FirebaseFirestore.instance.collection('users').doc(uid).get()
            .then((value) =>points=value['points'].toString());

        await FirebaseFirestore.instance.collection('counter').doc('Kc13bLp3P7R4277znYEK').get()
            .then((value) =>generalCounter=value['counter'].toString());


        //2- parse to int and increment values
        var treeCounter = int.parse(treePlanted);
        treeCounter = treeCounter + 1 ;

        var pointsCounter = int.parse(points);
        pointsCounter = pointsCounter + 50 ;

        var counter = int.parse(generalCounter);
        counter = counter + 1 ;


        //3- update with new values (and update general counter)
        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'treePlanted': treeCounter,
          'points': pointsCounter,
        });
        await FirebaseFirestore.instance.collection('counter').doc('Kc13bLp3P7R4277znYEK').update({
          'counter': counter});

        await showDialog(context: context, builder: (context) => AlertDialog(
          title: Text('Plantition info saved successfuly'),
          content: Text('Now you can track your tree'),
          icon: Icon(Icons.security_update_good,size: 46, color: Colors.green),
          actions: [TextButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainPage()),
            );
            setState(() {
            });
          }, child: Text('OK'))],
        ));
      }catch(e){
        print(e);
      }
      isLoading = false;
      setState(() {});

  }





}
