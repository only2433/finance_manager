import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/AuthInfoController.dart';

class MyInformation extends StatelessWidget {
  const MyInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final dataController = Get.find<AuthInfoController>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 240,
              decoration: BoxDecoration(
                color: Color(0xff368983)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 35, left: 10),
                    child: Text('My Information',
                      style: GoogleFonts.lobster(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Color.fromARGB(255, 224, 223, 223)
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[200],

                        child: ClipOval(

                          child: SizedBox(
                            width: 95,
                            height: 95,
                            child: Image.network(dataController.getData().value!.userImage,
                            fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              ),
            Padding(
              padding: EdgeInsets.only(top: 35, left: 110),
              child: Text('Nickname',
              style: GoogleFonts.lobster(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15, left: 110),
              child: Row(
                children: [
                  Icon(Icons.account_circle,
                      color: Colors.teal),
                  SizedBox(
                    width: 20,
                  ),
                  Text(dataController.getData().value!.nickName,
                    style: GoogleFonts.signikaNegative(
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 35, left: 110),
              child: Text('Email',
                style: GoogleFonts.lobster(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15, left: 110),
              child: Row(
                children: [
                  Icon(Icons.mark_email_read_outlined,
                      color: Colors.teal),
                  SizedBox(
                    width: 20,
                  ),
                  Text(dataController.getData().value!.email,
                    style: GoogleFonts.signikaNegative(
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 35, left: 110),
              child: Text('Birthday',
                style: GoogleFonts.lobster(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15, left: 110),
              child: Row(
                children: [
                  Icon(Icons.calendar_month_rounded,
                  color: Colors.teal),
                  SizedBox(
                    width: 20,
                  ),
                  Text('${dataController.getData().value!.dateTime.year}-${dataController.getData().value!.dateTime.month}-${dataController.getData().value!.dateTime.day}',
                  style: GoogleFonts.signikaNegative(
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
