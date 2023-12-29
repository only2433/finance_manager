import 'package:finance_manager/controller/AuthInfoController.dart';
import 'package:finance_manager/controller/LoadingController.dart';
import 'package:finance_manager/screens/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../common/Palette.dart';
import '../widgets/BottomNavigationBar.dart';
import 'Home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final loadingController = Get.put(LoadingController());
  final dataController = Get.find<AuthInfoController>();
  final _authentication = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String mLoginEmail = "";
  String mLoginPassword = "";

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Obx((){
        return ModalProgressHUD(
          inAsyncCall: loadingController.isLoading.value,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          child: Lottie.asset('lottie/welcome.json',
                              repeat: false,
                              animate: true,
                              alignment: Alignment.topCenter),
                        ),
                        Text('Login',
                            style: GoogleFonts.borel(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                decoration: TextDecoration.none)),
                        _inputLoginField(),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                    Positioned(
                      width: 70,
                      height: 70,
                      left: MediaQuery.of(context).size.width / 2 - 40,
                      top: MediaQuery.of(context).size.height / 2 + 220,
                      child: _loginButton(),
                    ),
                    Positioned(
                        top: MediaQuery.of(context).size.height - 50,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Not Yet ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed('/signup');
                              },
                              child: Text(
                                'Sign up?',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
        );
      })
    );
  }

  Container _inputLoginField()
  {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 170,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(width: 5, color: Colors.green),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 15,
                spreadRadius: 2)
          ]),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              TextFormField(
                key: const ValueKey(1),
                validator: (value) {
                  if (value!.isEmpty || value.length < 4) {
                    Get.snackbar('Error',
                        'Please enter at least 4 characters',
                        colorText: Colors.white,
                        backgroundColor: Colors.black,
                        snackPosition: SnackPosition.BOTTOM,
                        snackStyle: SnackStyle.GROUNDED,
                        duration:
                        Duration(milliseconds: 1500),
                        animationDuration:
                        Duration(milliseconds: 300));
                  }
                  return null;
                },
                onSaved: (newValue) {
                  mLoginEmail = newValue!;
                },
                onChanged: (value) {
                  mLoginEmail = value;
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.account_circle,
                        color: Colors.green),
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: Palette.textColor1,
                            width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: Colors.green, width: 2)),
                    hintText: 'User Email',
                    hintStyle: GoogleFonts.nunito(
                      fontSize: 14,
                      color: Palette.textColor1,
                    ),
                    contentPadding: EdgeInsets.all(10)),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                key: const ValueKey(2),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty || value.length < 6) {
                    Get.snackbar('Error',
                        'Password must be at least 7 characters long.',
                        colorText: Colors.white,
                        backgroundColor: Colors.black,
                        snackPosition: SnackPosition.BOTTOM,
                        snackStyle: SnackStyle.GROUNDED,
                        duration:
                        Duration(milliseconds: 1500),
                        animationDuration:
                        Duration(milliseconds: 300));
                    //return 'Password must be at least 7 characters long.';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  mLoginPassword = newValue!;
                },
                onChanged: (value) {
                  mLoginPassword = value;
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon:
                    Icon(Icons.lock, color: Colors.green),
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: Palette.textColor1,
                            width: 2)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Colors.green, width: 2),
                    ),
                    hintText: 'Password',
                    hintStyle: GoogleFonts.nunito(
                        fontSize: 14,
                        color: Palette.textColor1),
                    contentPadding: EdgeInsets.all(10)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _loginButton()
  {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 2)
          ]),
      child: ClipOval(
        child: Material(
          color: Colors.green[300],
          child: InkWell(
            splashColor: Colors.teal,
            onTap: () async {
              loadingController.enableLoading();

              _tryValidation();
              try {
                final userData = await dataController.login(mLoginEmail, mLoginPassword);
                loadingController.disableLoading();

               /* if (userData != null) {
                  print('로그인 성공');
                  Get.off(() {
                    return const BottomNavigationView();
                  });
                }*/
              } catch (e) {
                print('e : $e');
                loadingController.disableLoading();
                Get.snackbar(
                    'Error', 'There is no registered ID.',
                    colorText: Colors.white,
                    backgroundColor: Colors.black,
                    snackStyle: SnackStyle.GROUNDED,
                    snackPosition: SnackPosition.BOTTOM,
                    duration: Duration(milliseconds: 1500),
                    animationDuration:
                    Duration(milliseconds: 300));
              }
            },
            child: SizedBox(
              width: 50,
              height: 50,
              child: Icon(
                Icons.login,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
