import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../forms/login_page.dart';
import '../main_page.dart';
import '../side_drawer_screens/about_us_screen.dart';
import '../side_drawer_screens/profile_screen.dart';

class LeaderShipScreen extends StatefulWidget {
  const LeaderShipScreen({Key? key}) : super(key: key);

  @override
  State<LeaderShipScreen> createState() => _LeaderShipScreenState();
}

class _LeaderShipScreenState extends State<LeaderShipScreen> {


  bool isLoading = true;
  List<String> fullNames = [] ;
  List<String> treesPlantedForEachUser = [];

  void getData() async {
   isLoading = true;
    await FirebaseFirestore.instance
        .collection('users')
        .orderBy('treePlanted', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
         querySnapshot.docs.forEach((doc) {
        treesPlantedForEachUser.add(doc["treePlanted"].toString());
      });
    });

   await FirebaseFirestore.instance
       .collection('users')
       .orderBy('treePlanted', descending: true)
       .get()
       .then((QuerySnapshot querySnapshot) {
     querySnapshot.docs.forEach((doc) {
       fullNames.add(doc["fullName"].toString());
     });
   });

  print(fullNames);
  print(treesPlantedForEachUser);

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
            'Leaderboard',
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
        ListView.builder(
            itemCount: fullNames.length,
            itemBuilder: (BuildContext context, int index){
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("Icons/ecology.png"),
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 2, color: Colors.lightGreen)
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(fullNames[index], style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                              ),
                              Text("Rank: ${index+1}",style: TextStyle(fontSize: 12, ),),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 70.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 25,
                                height: 25,
                                child: Image.asset('Icons/tree4.png'),
                              ),
                              Text('${treesPlantedForEachUser[index]} tree'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );

            }
        )
    );
  }
}
