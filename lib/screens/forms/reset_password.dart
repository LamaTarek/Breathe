import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_page.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  bool isLoading = false;
  final _formkey = GlobalKey<FormState>();
  String email = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body:isLoading?Center(child: CircularProgressIndicator()):
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
                      child: Image.asset("images/Forgot password.gif"),
                    ),),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      'Forgot',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      'Password?',
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

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text("Don't worry it happens.Please enter the Email associated with your account.",
                    style: TextStyle(fontSize: 17),
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
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (email) =>
                          email != null && !(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email))
                          ? ' Enter a valid email'
                          : null,
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
                    height: 30,
                  ),

                  //submit btn
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if(_formkey.currentState!.validate()){
                          resetPassword();
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }


  Future resetPassword() async{
    isLoading = true;
    setState(() {});

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      SnackBar snackBar = SnackBar(
        content: Text('Password reset email sent'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }on FirebaseException catch(e){
      SnackBar snackBar = SnackBar(
        content: Text(e.message.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    isLoading = false;
    setState(() {});

    Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginPage(),));

  }
}
