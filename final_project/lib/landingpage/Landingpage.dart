import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
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

              
                    print(banner_img[1]);

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
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                // itemCount: hotDestination.length,
                itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(left: index == 0 ? 30 : 0),
                      child: hotDestinationCard(
                          "https://www.paiduaykan.com/travel/wp-content/uploads/2018/09/%E0%B8%97%E0%B8%B5%E0%B9%88%E0%B9%80%E0%B8%97%E0%B8%B5%E0%B9%88%E0%B8%A2%E0%B8%A7%E0%B8%9A%E0%B8%B2%E0%B8%87%E0%B9%81%E0%B8%AA%E0%B8%99.jpg",
                          "xxxxx",
                          "w",
                          context),
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

  Widget hotDestinationCard(String imagePath, String placeName,
      String touristPlaceCount, BuildContext context) {
    return GestureDetector(
      onTap: () => {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => DestinationDetail(imagePath)))
      },
      child: Stack(children: [
        Hero(
          tag: Image.network(
              "https://www.paiduaykan.com/travel/wp-content/uploads/2018/09/%E0%B8%97%E0%B8%B5%E0%B9%88%E0%B9%80%E0%B8%97%E0%B8%B5%E0%B9%88%E0%B8%A2%E0%B8%A7%E0%B8%9A%E0%B8%B2%E0%B8%87%E0%B9%81%E0%B8%AA%E0%B8%99.jpg"),
          child: Container(
            height: 200,
            width: 140,
            margin: EdgeInsets.only(right: 25),
            padding: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: NetworkImage(
                    "https://www.paiduaykan.com/travel/wp-content/uploads/2018/09/%E0%B8%97%E0%B8%B5%E0%B9%88%E0%B9%80%E0%B8%97%E0%B8%B5%E0%B9%88%E0%B8%A2%E0%B8%A7%E0%B8%9A%E0%B8%B2%E0%B8%87%E0%B9%81%E0%B8%AA%E0%B8%99.jpg"),
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
                  "วิ่งควาย",
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

    return result;
  }
}
