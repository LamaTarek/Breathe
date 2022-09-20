import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isSecure = true;
  bool isLoading = false;
  final _formkey = GlobalKey<FormState>();

  String gender = "";
  String fullName = "";
  String email = "";
  String phone = "";
  String password = "";
  String confirmationPassword = "";
  String birthdate = "";
  int points = 0;
  int treePlanted = 0;
  final joinedDate = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _formkey,
              child: SafeArea(
                  child: Center(
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 280,
                      width: 280,
                      child: Image.asset("images/Agreement.gif"),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.0),
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    //full name text field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (fullName.isEmpty) {
                              return "Full name is required";
                            }
                          },
                          onChanged: (value) {
                            fullName = value;
                          },
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            labelText: 'Full name',
                            prefixIcon: Icon(Icons.person_outline_rounded),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    //email text field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (!(RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(email))) {
                              return "Invalid email address";
                            }
                          },
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.grey,
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
                          validator: (value) {
                            if (value!.length < 5) {
                              return "Password is too short";
                            }
                          },
                          onChanged: (value) {
                            password = value;
                          },
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                              labelText: 'Password',
                              prefixIcon:
                                  const Icon(Icons.lock_outline_rounded),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  isSecure = !isSecure;
                                  setState(() {});
                                },
                                icon: const Icon(Icons.visibility_off_outlined),
                              )),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    //// confirm password text field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        child: TextFormField(
                          obscureText: isSecure,
                          validator: (value) {
                            if (value!.characters != password.characters) {
                              return "Password not match";
                            }
                          },
                          onChanged: (value) {
                            confirmationPassword = value;
                          },
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                              labelText: 'Confirm password',
                              prefixIcon:
                                  const Icon(Icons.lock_outline_rounded),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  isSecure = !isSecure;
                                  setState(() {});
                                },
                                icon: const Icon(Icons.visibility_off_outlined),
                              )),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    //phone text field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.length < 11) {
                              return "Invalid phone number";
                            }
                          },
                          onChanged: (value) {
                            phone = value;
                          },
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            labelText: 'Phone',
                            prefixIcon: Icon(Icons.phone_outlined),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      child: GenderPickerWithImage(
                        showOtherGender: false,
                        verticalAlignedText: false,
                        selectedGender: Gender.Male,
                        selectedGenderTextStyle: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                        unSelectedGenderTextStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal),
                        onChanged: (Gender? value) {
                          String g = value.toString(); //g= "gender.female"
                          var arr = g.split('.');
                          gender = arr[1];
                        },
                        equallyAligned: true,
                        animationDuration: Duration(milliseconds: 300),
                        isCircular: true,
                        // default : true,
                        opacityOfGradient: 0.4,
                        padding: const EdgeInsets.all(3),
                        size: 50, //default : 40
                      ),
                    ),

                    //register  btn
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            _signUp();
                          }
                        },
                        child: const Text('Singn up'),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //joined us before? login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Joined us before? ',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              )),
            ),
    );
  }

  void _signUp() async {
    isLoading = true;
    setState(() {});

    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      String uid = auth.currentUser!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'fullName': fullName,
        'email': email,
        'password': password,
        'phone': phone,
        'points': points,
        'treePlanted': treePlanted,
        'joinedDate': joinedDate,
        'gender': gender,
      });
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Sign up successed'),
                content: Text('Your account was created. you can now sign in'),
                icon: Icon(Icons.security_update_good,
                    size: 46, color: Colors.green),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                        setState(() {});
                      },
                      child: Text('OK'))
                ],
              ));
    } on FirebaseAuthException catch (e) {
      _handleSignUpError(e);
    }
  }

  void _handleSignUpError(FirebaseAuthException e) {
    String messageToDisplay;
    switch (e.code) {
      case 'email-already-in-use':
        messageToDisplay = "This email is already in use";
        break;
      case 'invalid-email':
        messageToDisplay = "email is invalid";
        break;
      case 'operation-not-allowed':
        messageToDisplay = " This operation is not allowed";
        break;
      case 'weak-password':
        messageToDisplay = "the password is too weak";
        break;
      default:
        messageToDisplay = "unknown error occurred";
        break;
    }
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Sign up faild'),
              content: Text(messageToDisplay),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      isLoading = false;
                      setState(() {});
                    },
                    child: Text('OK'))
              ],
            ));
  }
}
