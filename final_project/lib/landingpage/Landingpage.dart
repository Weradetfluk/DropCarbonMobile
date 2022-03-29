import 'package:final_project/company/Detail_company.dart';
import 'package:final_project/event/Detail_event.dart';
import 'package:final_project/promotion/Detail_promotion.dart';
import 'package:flutter/material.dart';
import '/template/colors.dart';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_project/event/List_event.dart';
import 'package:final_project/promotion/List_promotion.dart';
import 'package:final_project/company/List_company.dart';

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
  List lst_banner_list = [];
  List lst_eve_list = [];
  List lst_com_list = [];
  List lst_data_pros = [];
  List lst_data_promotions = [];
  void initState() {
    super.initState();
    get_data_banner();
    get_data_event();
    get_data_company();
    get_data_pros();
    get_data_promotions();
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
                setState(() {});
              },
            ),
          ],
        ), //Listview
      ), //Drawer

      body: ListView(
        children: [
          Container(
            child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: FutureBuilder(
                  future: get_data_banner(),
                  builder: (context, AsyncSnapshot snapshot) {
                    String jsonString = snapshot.data.toString();
                    var mySlideJson = lst_banner_list as List;

                    List<Slide> slideObjs = mySlideJson
                        .map((slideJson) => Slide.fromJson(slideJson))
                        .toList();

                    final List<String> bannerImg =
                        slideObjs.map((Slide) => Slide.toString()).toList();

                    // print(banner_img[1]);

                    return build_carusel(bannerImg);
                  },
                )),
          ),
          SizedBox(height: 10),
          Padding(
            padding:
                const EdgeInsets.only(top: 5, left: 25, right: 25, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'กิจกรรมยอดนิยม',
                  style: TextStyle(fontSize: 24),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => List_event(),
                      ),
                    );
                  },
                  child: Text("ดูเพิ่มเติม"),
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
                    itemCount: lst_eve_list.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: index == 0 ? 30 : 0),
                        child: Hotevent(
                          context,
                          lst_eve_list[index]["eve_name"].toString(),
                          lst_eve_list[index]["eve_img_path"].toString(),
                          lst_eve_list[index]["eve_description"].toString(),
                          lst_eve_list[index]["eve_cat_name"].toString(),
                          lst_eve_list[index]["eve_lat"].toString(),
                          lst_eve_list[index]["eve_lon"].toString(),
                          lst_eve_list[index]["par_name_th"].toString(),
                          lst_eve_list[index]["dis_name_th"].toString(),
                          lst_eve_list[index]["prv_name_th"].toString(),
                          lst_eve_list[index]["eve_drop_carbon"].toString(),
                        ),
                      );
                    });
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding:
                const EdgeInsets.only(top: 5, left: 25, right: 25, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'สถานที่ยอดนิยม',
                  style: TextStyle(fontSize: 24),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => List_company(),
                      ),
                    );
                  },
                  child: Text("ดูเพิ่มเติม"),
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
                    itemCount: lst_com_list.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: index == 0 ? 30 : 0),
                        child: Hotplace(
                          context,
                          lst_com_list[index]["com_name"].toString(),
                          lst_com_list[index]["com_img_path"].toString(),
                          lst_com_list[index]["com_description"].toString(),
                          lst_com_list[index]["com_cat_name"].toString(),
                          lst_com_list[index]["com_lat"].toString(),
                          lst_com_list[index]["com_lon"].toString(),
                          lst_com_list[index]["par_name_th"].toString(),
                          lst_com_list[index]["dis_name_th"].toString(),
                          lst_com_list[index]["prv_name_th"].toString(),
                        ),
                      );
                    });
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 25, right: 25, bottom: 10),
            child: Center(
              child: Text(
                'ABOUT US',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "การท่องเที่ยวแบบลดคาร์บอน เป็นกิจกรรมการท่องเที่ยว",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "ที่เป็นทางเลือกในการลดคาร์บอนให้น้อยลง",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "ซึ่งจะทำให้นักท่องเที่ยวได้รับประสบการณ์เกี่ยวกับ",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "การช่วยลดคาร์บอน Drop Carbon จะพาสมาชิก ",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "และนักท่องเที่ยวทุกท่านได้มีส่วนร่วมกับกิจกรรม",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "ที่ช่วยลดคาร์บอน ไม่ว่าจะเป็นบริการต่าง ๆ",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "ในพื้นที่จังหวัดชลบุรี",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "20",
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        "สมาชิก",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  Padding(padding: const EdgeInsets.all(10.0)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "18",
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        "ผู้ประกอบการ",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "18",
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        "กิจกรรม",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  Padding(padding: const EdgeInsets.all(10.0)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "18",
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        "สถานที่ท่องเที่ยว",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding:
                const EdgeInsets.only(top: 5, left: 25, right: 25, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'โปรโมชันและรางวัล',
                  style: TextStyle(fontSize: 24),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => List_promotion(),
                      ),
                    );
                  },
                  child: Text("ดูเพิ่มเติม"),
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
                    itemCount: lst_data_promotions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: index == 0 ? 30 : 0),
                        child: HotPromotion(
                          context,
                          lst_data_promotions[index]["pro_name"].toString(),
                          lst_data_promotions[index]["pro_img_path"].toString(),
                          lst_data_promotions[index]["pro_description"].toString(),
                          lst_data_promotions[index]["pro_cat_name"].toString(),
                          lst_data_promotions[index]["com_lat"].toString(),
                          lst_data_promotions[index]["com_lon"].toString(),
                          lst_data_promotions[index]["par_name_th"].toString(),
                          lst_data_promotions[index]["dis_name_th"].toString(),
                          lst_data_promotions[index]["prv_name_th"].toString(),
                        ),
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget Hotevent(
    BuildContext context,
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
  ) {
    var _eve_name,
        _eve_img_path,
        _eve_description,
        _eve_cat_name,
        _eve_lat,
        _eve_lon,
        _par_name_th,
        _dis_name_th,
        _prv_name_th,
        _eve_drop_carbon;
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
    }
    _eve_img_path = eve_img_path;
    print(eve_lat);
    print(eve_lon);
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => detail_event(
                  eve_name,
                  _eve_img_path,
                  _eve_description,
                  _eve_cat_name,
                  _eve_lat,
                  _eve_lon,
                  _par_name_th,
                  _dis_name_th,
                  _prv_name_th,
                  _eve_drop_carbon),
            ))
      },
      child: Stack(children: [
        Hero(
          tag: Image.network(
              "https://www.informatics.buu.ac.th/team2/image_event/${_eve_img_path}"),
          child: Container(
            height: 200,
            width: 140,
            margin: EdgeInsets.only(right: 25),
            padding: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: NetworkImage(
                    "https://www.informatics.buu.ac.th/team2/image_event/${_eve_img_path}"),
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
                  "${_eve_name}",
                  style: TextStyle(color: Colors.white),
                ),
              ]),
        ),
      ]),
    );
  }

  Widget Hotplace(
    BuildContext context,
    String com_name,
    String com_img_path,
    String com_description,
    String com_cat_name,
    String com_lat,
    String com_lon,
    String par_name_th,
    String dis_name_th,
    String prv_name_th,
  ) {
    var _com_name,
        _com_img_path,
        _com_description,
        _com_cat_name,
        _com_lat,
        _com_lon,
        _par_name_th,
        _dis_name_th,
        _prv_name_th;
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
    }
    _com_img_path = com_img_path;
    return GestureDetector(
      onTap: () => {
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
        ),
      },
      child: Stack(children: [
        Hero(
          tag: Image.network(
              "https://www.informatics.buu.ac.th/team2/image_event/${com_img_path}"),
          child: Container(
            height: 200,
            width: 140,
            margin: EdgeInsets.only(right: 25),
            padding: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: NetworkImage(
                    "https://www.informatics.buu.ac.th/team2/image_company/${com_img_path}"),
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
                  "${_com_name}",
                  style: TextStyle(color: Colors.white),
                ),
              ]),
        ),
      ]),
    );
  }

  Widget HotPromotion(
    BuildContext context,
    String pro_name,
    String pro_img_path,
    String pro_description,
    String pro_cat_name,
    String pro_lat,
    String pro_lon,
    String par_name_th,
    String dis_name_th,
    String prv_name_th,
  ) {
    var _pro_name,
        _pro_img_path,
        _pro_description,
        _pro_cat_name,
        _pro_lat,
        _pro_lon,
        _par_name_th,
        _dis_name_th,
        _prv_name_th;
    _pro_description = pro_description;
    _pro_cat_name = pro_cat_name;
    _pro_lat = pro_lat;
    _pro_lon = pro_lon;
    _par_name_th = par_name_th;
    _dis_name_th = dis_name_th;
    _prv_name_th = prv_name_th;
    _pro_name = pro_name;
    if (_pro_name.length > 13) {
      _pro_name = _pro_name.substring(0, 14) + '...';
    }
    _pro_img_path = pro_img_path;
    print(pro_lat);
    print(pro_lon);
    return GestureDetector(
      onTap: () => {
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
        ),
      },
      child: Stack(children: [
        Hero(
          tag: Image.network(
              "https://www.informatics.buu.ac.th/team2/image_promotions/${pro_img_path}"),
          child: Container(
            height: 200,
            width: 140,
            margin: EdgeInsets.only(right: 25),
            padding: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: NetworkImage(
                    "https://www.informatics.buu.ac.th/team2/image_promotions/${pro_img_path}"),
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
                  "${pro_name}",
                  style: TextStyle(color: Colors.white),
                ),
              ]),
        ),
      ]),
    );
  }

  Widget build_carusel(bannerImg) {
    final List<String> banner = bannerImg;
    final List<Widget> imageSliders = banner
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(0.8),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(
                          item,
                          fit: BoxFit.cover,
                          width: 1300.0,
                          height: 200,
                        ),
                      ],
                    )),
              ),
            ))
        .toList();
    return Container(
        child: CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        scrollDirection: Axis.vertical,
        autoPlay: true,
      ),
      items: imageSliders,
    ));
  }

  Future get_data_banner() async {
    var url = Uri.parse(
        'https://www.informatics.buu.ac.th/team2/Admin/Manage_banner/Admin_manage_banner/get_banner_list_ajax');

    var respone = await http.get(url);

    var result = json.decode(respone.body);
    ;

    // print(result);
    setState(() {
      lst_banner_list = result['data_banner_json'];
    });
  }

  Future get_data_event() async {
    var url = Uri.parse(
        'https://www.informatics.buu.ac.th/team2/Landing_page/Landing_page/get_event_list_landingpage/');

    var respone = await http.get(url);

    var result = jsonDecode(respone.body);

    setState(() {
      lst_eve_list = result['arr_event'];
    });
  }

  Future get_data_company() async {
    var url = Uri.parse(
        'https://www.informatics.buu.ac.th/team2/Landing_page/Landing_page/get_company_list_landingpage/');

    var respone = await http.get(url);

    var result = jsonDecode(respone.body);

    setState(() {
      lst_com_list = result['arr_com'];
    });
  }

  Future get_data_pros() async {
    var url = Uri.parse(
        'https://www.informatics.buu.ac.th/team2/DCS_controller/get_data_pros/');

    var respone = await http.get(url);

    var result = jsonDecode(respone.body);

    setState(() {
      lst_data_pros = result['arr_data_pros'];
      print(lst_data_pros);
    });
  }

  Future get_data_promotions() async {
    var url = Uri.parse(
        'https://www.informatics.buu.ac.th/team2/Landing_page/Landing_page/get_promotion_list_landingpage/');

    var respone = await http.get(url);

    var result = jsonDecode(respone.body);

    setState(() {
      lst_data_promotions = result['arr_pro'];
      print(lst_data_promotions);
    });
  }
}
