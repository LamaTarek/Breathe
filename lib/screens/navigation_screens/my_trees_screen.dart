import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../forms/login_page.dart';
import '../main_page.dart';
import '../side_drawer_screens/about_us_screen.dart';
import '../side_drawer_screens/profile_screen.dart';

class MyTreesScreen extends StatefulWidget {
  const MyTreesScreen({Key? key}) : super(key: key);

  @override
  State<MyTreesScreen> createState() => _MyTreesScreenState();
}

class _MyTreesScreenState extends State<MyTreesScreen> {

  bool isLoading = true;
  String email = "";
  String uid = "";
  List<String> treeNames = [];
  List<String> species =[];
  List<String> plantedDate = [] ;
  List<String> locations = [] ;


  void getData() async{
    isLoading = true;
    setState(() {});
    final  FirebaseAuth auth = await FirebaseAuth.instance;
    uid =  auth.currentUser!.uid;
    email = auth.currentUser!.email!;

    await FirebaseFirestore.instance
        .collection('trees')
        .where('email',isEqualTo : email)
        .get()
        .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          treeNames.add(doc["treeName"].toString());
      });
    });

    await FirebaseFirestore.instance
        .collection('trees')
        .where('email',isEqualTo : email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        locations.add(doc["city"].toString());
      });
    });


    await FirebaseFirestore.instance
        .collection('trees')
        .where('email',isEqualTo : email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        species.add(doc["species"].toString());
      });
    });


    await FirebaseFirestore.instance
        .collection('trees')
        .where('email',isEqualTo : email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        plantedDate.add(doc["plantingDate"].toString());
      });
    });
    isLoading = false;
    setState(() {});
  }


  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'My Trees',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, ),),
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
      backgroundColor: const Color(0xfffafafa),
      body:isLoading? Center(child: CircularProgressIndicator()):
          treeNames.isNotEmpty?
      ListView.builder(
          itemCount: treeNames.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Container(
                            width: 75,
                            height: 75,
                            // child: Image.asset("images/plant.jpg"),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('images/plant.jpg'),
                                fit: BoxFit.cover
                              ),
                                shape: BoxShape.circle,
                                border: Border.all(width: 1, color: Colors.green)
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(treeNames[index], style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold), ),
                                SizedBox(height: 3,),
                                Text('Species: ${species[index]}', style: TextStyle(fontSize: 12,color: Colors.grey, fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Icon(Icons.location_on_outlined, color: Colors.green,size: 35,),
                              ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(locations[index], style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(height: 3,),
                                Text('Location', style: TextStyle(color: Colors.grey),),
                              ],
                            ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Icon(Icons.calendar_today_rounded, color: Colors.green,size: 30,),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(plantedDate[index], style: TextStyle(fontWeight: FontWeight.bold),),
                                  SizedBox(height: 3,),
                                  Text('Planting Date',style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }):
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                        height: 100,
                        child: Image.asset('Icons/sad.png')
                    ),
                    SizedBox(height: 12,),
                    Text("You havn't plant any tree yet", style: TextStyle(color: Colors.grey), )
                  ],
                ),
              ),
    );
  }
}
