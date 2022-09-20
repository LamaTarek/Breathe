import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../forms/login_page.dart';
import '../main_page.dart';
import 'about_us_screen.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String fullName = "";
  late Timestamp date ;
  String email = "" ;
  String treePlanted = "" ;
  String points = "" ;
  String gender = "";
  var joinedDate;
  bool isLoading=true;



  void getData() async{

    final  FirebaseAuth auth =  FirebaseAuth.instance;
    final uid =  auth.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) => fullName=value['fullName'].toString());
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) => email=value['email'].toString());
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) => date=value['joinedDate']);
     joinedDate = DateTime.parse(date.toDate().toString());
    print(joinedDate);
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) => treePlanted=value['treePlanted'].toString());
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) => points=value['points'].toString());
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) => gender=value['gender'].toString());
    print(gender);
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
      backgroundColor: Color(0xfffbfbfb),
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
      isLoading?
      Center(child: CircularProgressIndicator()):
      ListView(
        children: [
          gender == "Female"?
          Container(
            height: 300,
            child: Image.asset("images/female.png"),
          ):
          Container(
            height: 270,
            child: Image.asset("images/male.png"),),



          Padding(
            padding: const EdgeInsets.only(bottom: 9.0),
            child: Center(child: Text(fullName, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)),
          ),


          //card 1
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      width: 75,
                      height: 75,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Image.asset("Icons/date.png"),
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 2, color: Colors.green)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text("Joined Date", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                          ),
                          Text(joinedDate.toString(),style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          // card 2
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      width: 75,
                      height: 75,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Image.asset("Icons/arroba.png"),
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 2, color: Colors.green)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text("Registered Email", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                          ),
                          Text(email, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          //loading
          //card 3
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      width: 75,
                      height: 75,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Image.asset("Icons/tree4.png"),
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 2, color: Colors.green)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text("Tree Planted", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                          ),
                          Text(treePlanted, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          //card 4
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      width: 75,
                      height: 75,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Image.asset("Icons/token.png"),
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 2, color: Colors.green)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text("Points", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                          ),
                          Text(points, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
