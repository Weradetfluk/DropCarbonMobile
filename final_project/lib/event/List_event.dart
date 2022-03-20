import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'dart:async';
import 'dart:convert';
import 'package:final_project/landingpage/Landingpage.dart';
import 'package:final_project/event/Detail_event.dart';

class List_event extends StatefulWidget {
  // const List_event({Key? key}) : super(key: key);

  @override
  State<List_event> createState() => _List_eventState();
}

class _List_eventState extends State<List_event> {
  List event_list = [];
  TextEditingController search = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_list_event();
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
                  // Navigator.pushReplacement(context,
                  //           MaterialPageRoute(builder: (context) {
                  //         return true;
                  //       }));
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
                      labelText: 'ค้นหาด้วยชื่อกิจกรรม',
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
                    get_list_event_by_search(search.text);
                  },
                  child: Text("ค้นหา"),
                ),
              ],
            )),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text('รายการกิจกรรม',
                      style: TextStyle(color: Colors.black, fontSize: 24)),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            build_list_event()
          ],
        ),
      ),
    );
  }

  Widget build_list_event() {
    return SizedBox(
      height: 450,
      child: ListView.builder(
        itemCount: event_list.length,
        itemBuilder: (context, index) {
          // print(event_list[index]['eve_name']);
          return build_card_event(
              event_list[index]['eve_id'],
              event_list[index]['eve_name'],
              event_list[index]['eve_img_path'],
              event_list[index]['eve_description'],
              event_list[index]['eve_cat_name'],
              event_list[index]['eve_lat'],
              event_list[index]['eve_lon'],
              event_list[index]['par_name_th'],
              event_list[index]['dis_name_th'],
              event_list[index]['prv_name_th'],
              event_list[index]['eve_drop_carbon'],
              context);
        },
      ),
    );
  }

  Widget build_card_event(
      String eve_id,
      String eve_name,
      String eve_img_path,
      String eve_description,
      String eve_cat_name,
      String eve_lat,
      String eve_lon,
      String par_name_th,
      String dis_name_th,
      String prv_name_th,
      String eve_drop_carbon,
      context) {
    var _eve_id,
        _eve_name,
        _eve_img_path,
        _eve_description,
        _eve_cat_name,
        _eve_lat,
        _eve_lon,
        _par_name_th,
        _dis_name_th,
        _prv_name_th,
        _eve_drop_carbon;
    _eve_id = eve_id;
    _eve_description = eve_description;
    _eve_cat_name = eve_cat_name;
    _eve_lat = eve_lat;
    _eve_lon = eve_lon;
    _par_name_th = par_name_th;
    _dis_name_th = dis_name_th;
    _prv_name_th = prv_name_th;
    _eve_drop_carbon = eve_drop_carbon;
    _eve_name = eve_name;
    if (_eve_name.length > 13) {
      _eve_name = _eve_name.substring(0, 14) + '...';
      print(_eve_name);
    }
    _eve_img_path = eve_img_path;
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(
                  'https://prepro.informatics.buu.ac.th/team2/image_event/' +
                      _eve_img_path,
                  fit: BoxFit.cover,
                  width: 150,
                  height: 100,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(_eve_name),
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
                            builder: (context) => detail_event(
                                _eve_name,
                                _eve_img_path,
                                _eve_description,
                                _eve_cat_name,
                                _eve_lat,
                                _eve_lon,
                                _par_name_th,
                                _dis_name_th,
                                _prv_name_th,
                                _eve_drop_carbon),
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

  Future get_list_event() async {
    var url = Uri.parse(
        'https://prepro.informatics.buu.ac.th/team2/Landing_page/Landing_page/get_event_list_ajax');

    var respone = await http.get(url);

    var result = json.decode(respone.body);
    print(result);
    setState(() {
      event_list = result['arr_event'];
    });
  }

  Future get_list_event_by_search(String _search) async {
    // print(_search);
    var url = Uri.parse(
        'https://prepro.informatics.buu.ac.th/team2/Landing_page/Landing_page/get_event_list_ajax/${_search}');
    var respone = await http.get(url);
    var result = json.decode(respone.body);
    // print(path);
    setState(() {
      event_list = result['arr_event'];
    });
  }
}
