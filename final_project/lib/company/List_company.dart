import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'dart:async';
import 'dart:convert';
import 'package:final_project/landingpage/Landingpage.dart';
import 'package:final_project/company/Detail_company.dart';

class List_company extends StatefulWidget {
  // const List_company({Key? key}) : super(key: key);

  @override
  State<List_company> createState() => _List_companyState();
}

class _List_companyState extends State<List_company> {
  List company_list = [];
  TextEditingController search = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_list_company();
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
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.dehaze_rounded))
        ],
      ),
      // endDrawer: Drawer(
      //   child: ListView(
      //     // Important: Remove any padding from the ListView.
      //     padding: EdgeInsets.zero,
      //     children: [
      //       DrawerHeader(
      //         //header of drawer
      //         decoration: BoxDecoration(
      //           color: Colors.blueGrey,
      //         ),
      //         child: Text(
      //           'Login App',
      //           style: TextStyle(
      //             color: Colors.white,
      //             fontSize: 24,
      //           ),
      //         ),
      //       ),
      //       ListTile(
      //         title: const Text('เข้าสู่ระบบ'),
      //         onTap: () {
      //           setState(() {
      //             // Navigator.pushReplacement(context,
      //             //           MaterialPageRoute(builder: (context) {
      //             //         return true;
      //             //       }));
      //           });
      //         },
      //       ),
      //     ],
      //   ), //Listview
      // ),
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
                      labelText: 'ค้นหาด้วยชื่อสถานที่',
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
                    get_list_company_by_search(search.text);
                  },
                  child: Text("ค้นหา"),
                ),
              ],
            )),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text('รายการสถานที่',
                      style: TextStyle(color: Colors.black, fontSize: 24)),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            build_list_company()
          ],
        ),
      ),
    );
  }

  Widget build_list_company() {
    return SizedBox(
      height: 450,
      child: ListView.builder(
        itemCount: company_list.length,
        itemBuilder: (context, index) {
          // print(event_list[index]['eve_name']);
          return build_card_event(
              company_list[index]['com_id'],
              company_list[index]['com_name'],
              company_list[index]['com_img_path'],
              company_list[index]['com_description'],
              company_list[index]['com_cat_name'],
              company_list[index]['com_lat'],
              company_list[index]['com_lon'],
              company_list[index]['par_name_th'],
              company_list[index]['dis_name_th'],
              company_list[index]['prv_name_th'],
              context);
        },
      ),
    );
  }

  Widget build_card_event(
      String com_id,
      String com_name,
      String com_img_path,
      String com_description,
      String com_cat_name,
      String com_lat,
      String com_lon,
      String par_name_th,
      String dis_name_th,
      String prv_name_th,
      context) {
    var _com_id,
        _com_name,
        _com_img_path,
        _com_description,
        _com_cat_name,
        _com_lat,
        _com_lon,
        _par_name_th,
        _dis_name_th,
        _prv_name_th;
    _com_id = com_id;
    _com_description = com_description;
    _com_cat_name = com_cat_name;
    _com_lat = com_lat;
    _com_lon = com_lon;
    _par_name_th = par_name_th;
    _dis_name_th = dis_name_th;
    _prv_name_th = prv_name_th;
    _com_name = com_name;
    if (_com_name.length > 13) {
      _com_name = _com_name.substring(0, 14) + '...';
      print(_com_name);
    }
    _com_img_path = com_img_path;
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(
                  'https://prepro.informatics.buu.ac.th/team2/image_company/' +
                      com_img_path,
                  fit: BoxFit.cover,
                  width: 150,
                  height: 100,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(_com_name),
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
                            builder: (context) => detail_company(
                                com_name,
                                _com_img_path,
                                _com_description,
                                _com_cat_name,
                                _com_lat,
                                _com_lon,
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

  Future get_list_company() async {
    var url = Uri.parse(
        'https://prepro.informatics.buu.ac.th/team2/Landing_page/Landing_page/get_company_list_ajax');

    var respone = await http.get(url);

    var result = json.decode(respone.body);
    print(result);
    setState(() {
      company_list = result['company'];
    });
  }

  Future get_list_company_by_search(String _search) async {
    // print(_search);
    var url = Uri.parse(
        'https://prepro.informatics.buu.ac.th/team2/Landing_page/Landing_page/get_company_list_ajax/${_search}');
    var respone = await http.get(url);
    var result = json.decode(respone.body);
    // print(path);
    setState(() {
      company_list = result['company'];
    });
  }
}
