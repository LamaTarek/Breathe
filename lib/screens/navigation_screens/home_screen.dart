import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../forms/login_page.dart';
import '../main_page.dart';
import '../side_drawer_screens/about_us_screen.dart';
import '../side_drawer_screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  bool isLoading = true;
  String counter = "";

  @override
  void initState() {
    getTreeCount();
    super.initState();
  }


  void getTreeCount() async{
    await FirebaseFirestore.instance.collection('counter').doc('Kc13bLp3P7R4277znYEK').get()
        .then((value) =>counter=value['counter'].toString());
    isLoading = false;
    setState(() {});

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color(0xffffffff),
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
      body:
      isLoading? Center(child: CircularProgressIndicator()):
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            Container(
              child: Image.asset("images/man_plant.jpeg"),
            ),
            Container(
              height: 280,
              width: 280,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Container(width: 80, height: 80,child: Image.asset("Icons/tree4.png")),
                    SizedBox(height: 10,),
                    Text(counter, style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black),),
                    SizedBox(height: 10,),
                    Text("TREE PLANTED BY 'BREATHE' USERS", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 8, color: Colors.green)
              ),
            ),
          ],
        ),
      )
    );
  }
}
