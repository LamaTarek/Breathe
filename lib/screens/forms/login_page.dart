import 'package:breathe/screens/forms/register_page.dart';
import 'package:breathe/screens/forms/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isSecure = true;
  bool isLoading = false;
  final _formkey = GlobalKey<FormState>();
  String email = "";
  String password = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body:isLoading? Center(child: CircularProgressIndicator()):
      Form(
        key: _formkey,
        child: SafeArea(
            child: Center(
              child: ListView(
                children: [

                  const SizedBox(height: 15,),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Image.asset("images/Login.gif"),
                    ),),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  //email text field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Container(
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            if(email.isEmpty){
                            return "Email is required";
                            }
                          },
                          onChanged: (value){
                            email = value;
                          },
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 1, color: Colors.grey,
                              ),
                            ),
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.alternate_email),
                          ),
                        ),
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  ////password text field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Container(
                        child: TextFormField(
                          obscureText: isSecure,
                          validator: (value){
                            if(password.isEmpty){
                              return "Password is required";
                            }
                          },
                          onChanged: (value){
                            password = value;
                          },
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1, color: Colors.grey,
                                ),
                              ),
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock_outline_rounded),
                              suffixIcon: IconButton(
                                onPressed: (){
                                  isSecure = !isSecure;
                                  setState(() {});
                                },
                                icon: const Icon(Icons.visibility_off_outlined),
                              )
                          ),
                        ),
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ResetPassword()),
                            );
                          },
                          child: const Text(
                            'Forget password?',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 15,
                  ),



                  //sign in btn
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if(_formkey.currentState!.validate()){
                          login();
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  //new to breathe? register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'New to Breathe? ',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterPage()),
                          );
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
  login() async{
    isLoading = true;
    setState(() {});
    try {
      UserCredential user =
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      print("user: ${user.user?.email}");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );

      final prefs = await SharedPreferences.getInstance();
      prefs.setBool("isLogin", true);
      prefs.setString("userEmail", "${user.user?.email}");
      prefs.setString("userId", "${user.user?.uid}");
    } catch (e) {

      SnackBar snackBar = SnackBar(
        content: Text('Email or password or both  not correct'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    isLoading = false;
    setState(() {});
  }
}
