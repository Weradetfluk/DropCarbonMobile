import 'package:final_project/promotion/Detail_promotion.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'dart:async';
import 'dart:convert';
import 'package:final_project/landingpage/Landingpage.dart';

class List_promotion extends StatefulWidget {
  // const List_promotion({ Key? key }) : super(key: key);

  @override
  State<List_promotion> createState() => _List_promotionState();
}

class _List_promotionState extends State<List_promotion> {

  List promotion_list = [];
  TextEditingController search = new TextEditingController();

  @override
  void initState(){
    super.initState();
    // get_list_promotion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xFFEEEEEE),
        title: Text("DropCarbon System", style: TextStyle(color: Colors.black)),
        leading: TextButton.icon(
          icon: Icon(Icons.arrow_back),
          label: Text(''),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Landing_page(),
              ),
            );
          },
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              //header of drawer
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Text(
                'Login App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('เข้าสู่ระบบ'),
              onTap: () {
                setState(() {

                });
              },
            ),
          ],
        ), //Listview
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
                child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 200,
                  height: 40,
                  child: TextField(
                    controller: search,
                    decoration: InputDecoration(
                      labelText: 'ค้นหาด้วยชื่อโปรโมชันหรือรางวัล',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue)),
                  onPressed: () {
                  },
                  child: Text("ค้นหา"),
                ),
              ],
            )),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text('รายการโปรโมชัน',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                      ),
                      
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            // build_list_event()
            build_list_promotion(),
            // TextButton(
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => Detail_promotion(),
            //           ),
            //         );
            //       },
            //       child: Text("ดูเพิ่มเติม"),
            //     ),
          ],
        ),
      ),
    );
  }
}

 Widget build_list_promotion() {
    return SizedBox(
      height: 450,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return build_card_promotion(context);
        },
      ),
      // child: build_card_promotion(context),
    );
  }

Widget build_card_promotion(context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(
                  'https://www.informatics.buu.ac.th/team2/image_promotions/620cc76964f172.54705328.jpg',
                  fit: BoxFit.cover,
                  width: 150,
                  height: 100,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Buy 1 Get 1 Free!"),
                    ),
                  ],
                ),
                Column(
                  children: [
                    TextButton.icon(
                      icon: Icon(Icons.keyboard_double_arrow_right),
                      label: Text(''),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Detail_promotion(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }