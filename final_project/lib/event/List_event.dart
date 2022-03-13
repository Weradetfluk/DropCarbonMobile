import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'dart:async';
import 'dart:convert';
import 'package:final_project/landingpage/Landingpage.dart';

class List_event extends StatefulWidget {
  const List_event({Key? key}) : super(key: key);

  @override
  State<List_event> createState() => _List_eventState();
}

class _List_eventState extends State<List_event> {
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('รายการกิจกรรม',
                      style: TextStyle(color: Colors.black, fontSize: 24)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: FutureBuilder(
                future: get_list_event(),
                builder: (context, AsyncSnapshot snapshot) {
                  return SizedBox(
                    height: 450,
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return build_card_event(
                            snapshot.data[index]['eve_id'],
                            snapshot.data[index]['eve_name'],
                            snapshot.data[index]['eve_img_path'],
                            context);
                      },
                      itemCount: snapshot.data.length,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget build_card_event(
      String eve_id, String eve_name, String eve_img_path, context) {
    var _eve_id, _eve_name, _eve_img_path;
    _eve_id = eve_id;
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
                  'https://www.informatics.buu.ac.th/team2/image_event/' +
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
                            builder: (context) => Landing_page(),
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
        'https://www.informatics.buu.ac.th/team2/Landing_page/Landing_page/get_event_list_ajax');

    var respone = await http.get(url);

    var result = json.decode(respone.body);
    return result['arr_event'];
  }
}
