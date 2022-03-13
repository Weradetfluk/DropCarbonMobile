import 'package:flutter/material.dart';
import '/template/colors.dart';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';

class Slide {
  String imageUrl;

  Slide(this.imageUrl);

  factory Slide.fromJson(dynamic json) {
    return Slide(json['ban_path'] as String);
  }

  @override
  String toString() {
    return 'https://www.informatics.buu.ac.th/team2/banner/${this.imageUrl}';
  }
}

class Landing_page extends StatefulWidget {
  const Landing_page({Key? key}) : super(key: key);

  @override
  State<Landing_page> createState() => _Landing_pageState();
}

class _Landing_pageState extends State<Landing_page> {

   void initState() {
    super.initState();
    get_data_banner();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xFFEEEEEE),
        title: Text(
          "DropCarbon System",
          style: TextStyle(color: Colors.black),
        ),
        leading: Image.asset('assets/images/Logo-only-new.png'),
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
      ), //Drawer

      body: ListView(
        children: [
          Container(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  future: get_data_banner(),
                  builder: (context, AsyncSnapshot snapshot) {
                    String json_string =
                        snapshot.data.toString();
                     var mySlideJson = jsonDecode(json_string)["data_banner_json"] as List;

                     List<Slide> slideObjs = mySlideJson
                       .map((slideJson) => Slide.fromJson(slideJson))
                        .toList();


                   final List<String> banner_img = slideObjs.map((Slide) => Slide.toString()).toList();

              
                    // print(banner_img[1]);

                    return build_carusel(banner_img);
                  },
                )),
          ),
          SizedBox(height: 20),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 25, right: 25, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'กิจกรรมยอดนิยม',
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  'ดูเพิ่มเติม',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: FutureBuilder(
              builder: (context, AsyncSnapshot snapshot) {
                      return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) { 
                 return Padding(
                  
                      padding: EdgeInsets.only(left: index == 0 ? 30 : 0),
                   
                      child: Hotevent(
                         context,
                          snapshot.data[index]["eve_img_path"],
                           snapshot.data[index]["eve_name"],
                          ),
                      
                    );}
                    );                
              },
                   future: get_data_event(),
                    ),
          ),
          SizedBox(height: 20),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 25, right: 25, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'สถานที่ยอดนิยม',
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  'ดูเพิ่มเติม',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget Hotevent(BuildContext context, String imagePath, String event_name) {
    return GestureDetector(
      onTap: () => {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => DestinationDetail(imagePath)))
      },
      child: Stack(children: [
        Hero(
          tag: Image.network(
              "https://www.informatics.buu.ac.th/team2/image_event/${imagePath}"),
          child: Container(
            height: 200,
            width: 140,
            margin: EdgeInsets.only(right: 25),
            padding: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: NetworkImage(
                     "https://www.informatics.buu.ac.th/team2/image_event/${imagePath}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            height: 200,
            width: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [AppColor.secondaryColor, Colors.transparent]),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                 "${event_name}",
                  style: TextStyle(color: Colors.white),
                ),
              ]),
        ),
      ]),
    );
  }

  Widget build_carusel(banner_img) {

    final List<String> banner = banner_img;

    return Container(
   child: CarouselSlider(
        options: CarouselOptions(),
        items: banner
            .map((item) => Container(
                  child: Center(
                      child:
                          Image.network(item, fit: BoxFit.cover, width: 1500)),
                ))
            .toList(),
      ));
  }

  Future get_data_banner() async {
    var url = Uri.parse(
        'https://www.informatics.buu.ac.th/team2/Admin/Manage_banner/Admin_manage_banner/get_banner_list_ajax');

    var respone = await http.get(url);

    var result = respone.body;

    // print(result);

    return result;
  }

   Future get_data_event() async {
    var url = Uri.parse(
        'https://www.informatics.buu.ac.th/team2/Landing_page/Landing_page/get_event_list_landingpage/');

    var respone = await http.get(url);

    var result = jsonDecode(respone.body);

     print(result['arr_event']);
    return result['arr_event'];
  }
}
