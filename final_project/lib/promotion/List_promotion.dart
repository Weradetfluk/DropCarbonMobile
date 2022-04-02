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
  List pro_list = [];
  TextEditingController search = new TextEditingController();

  @override
  void initState() {
    super.initState();
    get_list_pro();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                setState(() {});
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
                    get_list_pro_by_search(search.text);
                  },
                  child: Text("ค้นหา"),
                ),
              ],
            )),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'รายการโปรโมชัน',
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            build_list_promotion(),
          ],
        ),
      ),
    );
  }

  Widget build_list_promotion() {
    return SizedBox(
      height: 450,
      child: ListView.builder(
        itemCount: pro_list.length,
        itemBuilder: (context, index) {
          print("---------------------------------------------------");
          print(pro_list[index]['pro_name']);
          return build_card_promotion(
              pro_list[index]['pro_id'],
              pro_list[index]['pro_name'],
              pro_list[index]['pro_description'],
              pro_list[index]['pro_add_date'],
              pro_list[index]['pro_start_date'],
              pro_list[index]['pro_end_date'],
              pro_list[index]['pro_cat_name'],
              pro_list[index]['pro_img_path'],
              pro_list[index]['pro_img_name'],
              pro_list[index]['pro_lat'],
              pro_list[index]['pro_lon'],
              pro_list[index]['par_name_th'],
              pro_list[index]['dis_name_th'],
              pro_list[index]['prv_name_th'],
              context);
        },
      ),
      // child: build_card_promotion(context),
    );
  }

  Widget build_card_promotion(
      String pro_id,
      String pro_name,
      String pro_description,
      String pro_add_date,
      String pro_start_date,
      String pro_end_date,
      String pro_cat_name,
      String pro_img_path,
      String pro_img_name,
      String pro_lat,
      String pro_lon,
      String par_name_th,
      String dis_name_th,
      String prv_name_th,
      context) {
    var _pro_id = pro_id;
    var _pro_name = pro_name;
    var _pro_description = pro_description;
    var _pro_add_date = pro_add_date;
    var _pro_start_date = pro_start_date;
    var _pro_end_date = pro_end_date;
    var _pro_cat_name = pro_cat_name;
    var _pro_img_path = pro_img_path;
    var _pro_img_name = pro_img_name;
    var _pro_lat = pro_lat;
    var _pro_lon = pro_lon;
    var _par_name_th = par_name_th;
    var _dis_name_th = dis_name_th;
    var _prv_name_th = prv_name_th;

    if (_pro_name.length > 13) {
      _pro_name = _pro_name.substring(0, 14) + '...';
      print(_pro_name);
    }
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(
                  'https://prepro.informatics.buu.ac.th/team2/image_promotions/' +
                      _pro_img_path,
                  fit: BoxFit.cover,
                  width: 150,
                  height: 100,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      // child: Text("Buy 1 Get 1 Free!"),
                      child: Text(_pro_name),
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
                            builder: (context) => Detail_promotion(
                                pro_name,
                                _pro_img_path,
                                _pro_description,
                                _pro_cat_name,
                                _pro_lat,
                                _pro_lon,
                                _par_name_th,
                                _dis_name_th,
                                _prv_name_th),
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

  Future get_list_pro() async {
    var url = Uri.parse(
        'https://prepro.informatics.buu.ac.th/team2/Landing_page/Landing_page/get_pro_list_ajax');

    var respone = await http.get(url);

    var result = json.decode(respone.body);
    print(result);
    setState(() {
      pro_list = result['arr_pro'];
    });
  }

  Future get_list_pro_by_search(String _search) async {
    // print(_search);
    var url = Uri.parse(
        'https://prepro.informatics.buu.ac.th/team2/Landing_page/Landing_page/get_pro_list_ajax/${_search}');
    var respone = await http.get(url);
    var result = json.decode(respone.body);
    // print(path);
    setState(() {
      pro_list = result['arr_pro'];
    });
  }
}

//  Widget build_list_promotion() {
//     return SizedBox(
//       height: 450,
//       child: ListView.builder(
//         itemCount: pro_list.length,
//         itemBuilder: (context, index) {
//           return build_card_promotion(context);
//         },
//       ),
//       // child: build_card_promotion(context),
//     );
//   }

// Widget build_card_promotion(
//   String pro_list,
//   String pro_id,
//   String pro_name, 
//   String pro_description, 
//   String pro_add_date, 
//   String pro_start_date, 
//   String pro_end_date, 
//   String pro_com_name,
//   String pro_img_path,
//   String pro_img_name,
//   context) 
// {
//     return Padding(
//       padding: const EdgeInsets.all(3.0),
//       child: Card(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Image.network(
//                   'https://www.informatics.buu.ac.th/team2/image_promotions/620cc76964f172.54705328.jpg',
//                   fit: BoxFit.cover,
//                   width: 150,
//                   height: 100,
//                 ),
//                 Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text("Buy 1 Get 1 Free!"),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     TextButton.icon(
//                       icon: Icon(Icons.keyboard_double_arrow_right),
//                       label: Text(''),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => Detail_promotion(),
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }