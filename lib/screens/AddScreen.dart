import 'package:finance_manager/controller/HomeNavigationController.dart';
import 'package:finance_manager/controller/AddScreenController.dart';
import 'package:finance_manager/controller/AuthInfoController.dart';
import 'package:finance_manager/data/BalanceItem.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

import '../common/Utility.dart';
import '../controller/LoadingController.dart';
import '../model/BalanceItemData.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  final loadingController = Get.put(LoadingController());
  final dataController = Get.find<AuthInfoController>();
  final inputDataController = Get.find<AddScreenController>();
  final TextEditingController explainController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final List<String> _nameItem = [
    'food',
    'Transfer',
    'Transportation',
    'Education'
  ];
  final List<String> _feeItem = ['Income', 'Expand'];

  @override
  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Obx(() {
        return ModalProgressHUD(
          inAsyncCall: loadingController.isLoading.value,
          child: SafeArea(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                getBackgroundContainer(),
                Positioned(
                  top: 120,
                  child: getMainContainer(),
                )
              ],
            ),
          ),
        );
      },)
    );
  }

  Column getBackgroundContainer() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: BoxDecoration(
              color: Color(0xff368983),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Adding',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.attach_file,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Container getMainContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      width: 340,
      height: 550,
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          nameSelectView(),
          SizedBox(
            height: 30,
          ),
          explainTextFieldView(),
          SizedBox(
            height: 30,
          ),
          amountTextFieldView(),
          SizedBox(
            height: 30,
          ),
          feeSelectView(),
          SizedBox(
            height: 30,
          ),
          dateSelectView(),
          SizedBox(
            height: 30,
          ),
          Spacer(),
          saveButton(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Container nameSelectView() {
    return Container(
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Color(0xffc5c5c5),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Obx(() {
          return DropdownButton<String>(
            value: inputDataController.selectedNameItem.value.isNotEmpty
                ? inputDataController.selectedNameItem.value
                : null,
            items: _nameItem
                .map((e) => DropdownMenuItem(
                      child: Container(
                        child: Row(
                          children: [
                            Image.asset(
                              'images/${e}.png',
                              width: 40,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              e,
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      ),
                      value: e,
                    ))
                .toList(),
            selectedItemBuilder: (context) {
              return _nameItem
                  .map((e) => Row(
                        children: [
                          Image.asset(
                            'images/${e}.png',
                            width: 40,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            e,
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ))
                  .toList();
            },
            onChanged: (value) {
              inputDataController.selectedNameItem.value = value!;
            },
            hint: Text(
              'Name',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            dropdownColor: Colors.white,
            isExpanded: true,
            underline: Container(),
          );
        }),
      ),
    );
  }

  Container feeSelectView() {
    return Container(
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Color(0xffc5c5c5),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Obx(() {
          return DropdownButton<String>(
            value: inputDataController.selectedFeeItem.value.isNotEmpty
                ? inputDataController.selectedFeeItem.value
                : null,
            items: _feeItem
                .map((e) => DropdownMenuItem(
                      child: Container(
                        child: Text(
                          e,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      value: e,
                    ))
                .toList(),
            selectedItemBuilder: (context) {
              return _feeItem
                  .map((e) => Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          e,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ))
                  .toList();
            },
            onChanged: (value) {
              inputDataController.selectedFeeItem.value = value!;
            },
            hint: Text(
              'Fee',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            dropdownColor: Colors.white,
            isExpanded: true,
            underline: Container(),
          );
        }),
      ),
    );
  }

  Padding explainTextFieldView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: explainController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'Explain',
            labelStyle: TextStyle(
              fontSize: 17,
              color: Colors.grey.shade500,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2, color: Color(0xffc5c5c5))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2, color: Color(0xff368983)))),
      ),
    );
  }

  Padding amountTextFieldView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: amountController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'Amount',
            labelStyle: TextStyle(
              fontSize: 17,
              color: Colors.grey.shade500,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2, color: Color(0xffc5c5c5))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2, color: Color(0xff368983)))),
      ),
    );
  }

  Container dateSelectView() {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Color(0xffc5c5c5))),
      width: 300,
      child: TextButton(
        onPressed: () async {
          DateTime? tempDate = await showDatePicker(
              context: context,
              initialDate: inputDataController.selectedDate.value,
              firstDate: DateTime(2020),
              lastDate: DateTime(2100));

          if (tempDate == null) {
            return;
          }
          inputDataController.selectedDate.value = tempDate!;
        },
        child: Obx((){
          return Text(
            'Date: ${inputDataController.selectedDate.value.year} / ${inputDataController.selectedDate.value.month} / ${inputDataController.selectedDate.value.day}',
            style: TextStyle(fontSize: 15, color: Colors.black),
          );
        }),
      ),
    );
  }

  GestureDetector saveButton() {
    return GestureDetector(
      onTap: () async{
        loadingController.enableLoading();
        var saveData = BalanceItem(
            name: inputDataController.selectedNameItem.value!,
            explain: explainController.text,
            amount: amountController.text,
            IN: inputDataController.selectedFeeItem.value!,
            dateTime: inputDataController.selectedDate.value);
        dataController.addBalanceItem(saveData);
        await dataController.uploadUserBalanceData();
        loadingController.disableLoading();
        Get.back();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xff368983),
        ),
        width: 120,
        height: 50,
        child: Text(
          'Save',
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: 'f'),
        ),
      ),
    );
  }
}
