import 'dart:io';
import 'package:finance_manager/common/Utility.dart';
import 'package:finance_manager/controller/LoadingController.dart';
import 'package:finance_manager/controller/SignUpController.dart';
import 'package:finance_manager/screens/Login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../common/Palette.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final int MAX_TEXT_FIELD_COUNT = 3;

  final _authentication = FirebaseAuth.instance;
  final signupController = Get.find<SignUpController>();
  final loadingController = Get.put(LoadingController());
  final _formKey = GlobalKey<FormState>();
  String mUserEmail = "";
  String mUserPassword = "";
  String mUserNickname = "";
  File? mUserPickedImage;
  bool isSuccessValidateEmail = false;
  bool isSuccessValidatePassword = false;
  bool isSuccessValidateNickname = false;
  late ScrollController _scrollController;
  late List<FocusNode> _focusNodeList;

  @override
  void initState() {
    super.initState();
    signupController.init();
    loadingController.init();
    _scrollController = ScrollController();
    _focusNodeList =
        List.generate(MAX_TEXT_FIELD_COUNT, (index) => FocusNode());
    for (var focus in _focusNodeList) {
      focus.addListener(() {
        _onFocusChange(focus.hasFocus);
      });
    }
  }

  void _onFocusChange(bool hasFocus) {
    if (hasFocus == false) {
      _scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    for (var focus in _focusNodeList) {
      focus.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text('Sign Up'),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back),
          )),
      backgroundColor: Colors.teal,
      body: Obx(() {
        return ModalProgressHUD(
          inAsyncCall: loadingController.isLoading.value,
          child: SafeArea(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: ClampingScrollPhysics(),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          width: 500,
                          height: 100,
                          child: Stack(
                            children: [
                              Positioned(
                                left:
                                    MediaQuery.of(context).size.width / 2 - 40,
                                top: 0,
                                child: Obx(() {
                                  return CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.grey[200],
                                      backgroundImage:
                                          signupController.mUserPickerImage.value !=
                                                  null
                                              ? FileImage(signupController
                                                  .mUserPickerImage.value!)
                                              : null);
                                }),
                              ),
                              Positioned(
                                left:
                                    MediaQuery.of(context).size.width / 2 + 10,
                                top: 40,
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.teal[600],
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            blurRadius: 2,
                                            spreadRadius: 2)
                                      ]),
                                  child: IconButton(
                                      onPressed: () {
                                        pickImage();
                                      },
                                      icon: Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.white,
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                        _inputLoginField(),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () async{
                            String message = getErrorMessage();
                            if (message != "") {
                              Utility.getInstance().showErrorMessage(message);
                              return;
                            }
                            await signUp();

                          },
                          child: Container(
                              width: 200,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  border:
                                      Border.all(width: 2, color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 10,
                                        spreadRadius: 3)
                                  ]),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      ],
                    )),
              ),
            ),
          ),
        );
      }),
    );
  }

  Container _inputLoginField() {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 290,
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
      child: Column(
        children: [
          Form(
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
                    focusNode: _focusNodeList[0],
                    validator: (value) {
                      if (value!.isEmpty ||
                          value.length < 4 ||
                          value.contains('@') == false) {
                        isSuccessValidateEmail = false;
                        return null;
                      }
                      isSuccessValidateEmail = true;
                      return null;
                    },
                    onSaved: (newValue) {
                      mUserEmail = newValue!;
                    },
                    onChanged: (value) {
                      mUserEmail = value;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon:
                            Icon(Icons.account_circle, color: Colors.green),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Palette.textColor1, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(color: Colors.green, width: 2)),
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
                    focusNode: _focusNodeList[1],
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        isSuccessValidatePassword = false;
                        return null;
                      }
                      isSuccessValidatePassword = true;

                      print(
                          'isSuccessValidatePassword : $isSuccessValidatePassword');
                      return null;
                    },
                    onSaved: (newValue) {
                      mUserPassword = newValue!;
                    },
                    onChanged: (value) {
                      mUserPassword = value;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.lock, color: Colors.green),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Palette.textColor1, width: 2)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.green, width: 2),
                        ),
                        hintText: 'Password',
                        hintStyle: GoogleFonts.nunito(
                            fontSize: 14, color: Palette.textColor1),
                        contentPadding: EdgeInsets.all(10)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    key: const ValueKey(3),
                    focusNode: _focusNodeList[2],
                    validator: (value) {
                      if (value!.isEmpty || value.length < 4) {
                        isSuccessValidateNickname = false;
                        return null;
                      }
                      isSuccessValidateNickname = true;
                      return null;
                    },
                    onSaved: (newValue) {
                      mUserNickname = newValue!;
                    },
                    onChanged: (value) {
                      mUserNickname = value;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon:
                            Icon(Icons.perm_identity, color: Colors.green),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Palette.textColor1, width: 2)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.green, width: 2),
                        ),
                        hintText: 'Nickname',
                        hintStyle: GoogleFonts.nunito(
                            fontSize: 14, color: Palette.textColor1),
                        contentPadding: EdgeInsets.all(10)),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 45,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Palette.textColor1,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15)),
              child: TextButton.icon(
                  onPressed: () async {
                    print("onClick date");
                    DateTime? tempDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1980),
                        lastDate: DateTime.now());

                    if (tempDate == null) {
                      return;
                    }
                    signupController.setUserDate(tempDate);
                  },
                  icon: Icon(
                    Icons.date_range_sharp,
                    color: Colors.green,
                  ),
                  label: Obx(() {
                    return Text(
                        signupController.isSelected.value == false ? ' Birthday' : ' ${getDateText(signupController.birthdayDate.value)}',
                      style: GoogleFonts.nunito(
                        color: Palette.textColor1,
                        fontWeight: FontWeight.normal,
                      ),
                    );
                  })),
            ),
          )
        ],
      ),
    );
  }

  String getDateText(DateTime time) {
    return '${time.year}-${time.month}-${time.day}';
  }

  String getErrorMessage() {
    _formKey.currentState!.validate();

    if (isSuccessValidateEmail == false) {
      return 'Please enter your email address accurately.';
    }
    if (isSuccessValidatePassword == false) {
      return 'Password must be at least 7 characters long.';
    }
    if (isSuccessValidateNickname == false) {
      return 'Nickname must be at least 4 characters long.';
    }
    if (signupController.isSelected.value == false) {
      return 'Please select your birthday.';
    }
    if (signupController.mUserPickerImage.value == null) {
      return 'Please take your picture.';
    }
    return "";
  }



  bool _isValidationPossible() {
    bool result = _formKey.currentState!.validate();
    print('result : $result');
    return result;
  }

  void pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 80, maxHeight: 150);

    if (pickedImageFile != null) {
      signupController.setImageFile(pickedImageFile.path);
    }
  }

  Future<void> signUp() async {
    loadingController.enableLoading();
    try {
      final userData = await _authentication.createUserWithEmailAndPassword(
          email: mUserEmail, password: mUserPassword);

      if (userData != null)
      {
        final refImage = FirebaseStorage.instance
            .ref()
            .child('picked_image')
            .child(userData.user!.uid + ".png");

        await refImage.putFile(signupController.mUserPickerImage.value!);
        final userImageUrl = await refImage.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userData.user!.uid)
            .set({
          'userNickName': mUserNickname,
          'userEmail': mUserEmail,
          'userImage': userImageUrl,
          'birthDay': signupController.getBirthDay()
        });
        loadingController.disableLoading();
        Utility.getInstance().showSuccessMessage("You have successfully registered.");
        await Future.delayed(Duration(milliseconds: 1500));
        Get.back();
      }
      else
      {
        loadingController.disableLoading();
      }

    } catch (e) {
      loadingController.disableLoading();
      Utility.getInstance().showErrorMessage(e.toString());
    }
  }
}
