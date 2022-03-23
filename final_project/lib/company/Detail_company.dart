import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'dart:async';
import 'dart:convert';
import 'package:final_project/landingpage/Landingpage.dart';
import 'package:final_project/company/List_company.dart';
import 'package:readmore/readmore.dart';

class detail_company extends StatefulWidget {
  // const detail_event({Key? key}) : super(key: key);
  final _com_name,
        _com_img_path,
        _com_description,
        _com_cat_name,
        _com_lat,
        _com_lon,
        _par_name_th,
        _dis_name_th,
        _prv_name_th;
  detail_company(
      this._com_name,
      this._com_img_path,
      this._com_description,
      this._com_cat_name,
      this._com_lat,
      this._com_lon,
      this._par_name_th,
      this._dis_name_th,
      this._prv_name_th);
  @override
  State<detail_company> createState() => _detail_companyState();
}

class _detail_companyState extends State<detail_company> {
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _com_name = widget._com_name;
    _com_img_path = widget._com_img_path;
    _com_description = widget._com_description;
    _com_cat_name = widget._com_cat_name;
    _com_lat = widget._com_lat;
    _com_lon = widget._com_lon;
    _par_name_th = widget._par_name_th;
    _dis_name_th = widget._dis_name_th;
    _prv_name_th = widget._prv_name_th;
  }

  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          _com_name,
        ),
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.arrow_back),
            label: Text(''),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return List_company();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3.2,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      'https://www.informatics.buu.ac.th/team2/image_company/' +
                          _com_img_path,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: -10.0,
                  bottom: 3.0,
                  child: RawMaterialButton(
                    onPressed: () {},
                    fillColor: Colors.white,
                    shape: CircleBorder(),
                    elevation: 4.0,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                        size: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.location_pin,
                    size: 14,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'ตำบล : ' +
                        _par_name_th +
                        ' อำเภอ : ' +
                        _dis_name_th +
                        ' จังหวัด : ' +
                        _prv_name_th,
                    // style: appTheme.textTheme.caption,
                  ),
                  SizedBox(height: 8),
                  SizedBox(height: 18),
                  SizedBox(height: 8),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'assets/images/social-media.png',
                    width: 25,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "  ประเภท : ",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    _com_cat_name,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: const Color(0xFF167F67),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'assets/images/carbon-dioxide.png',
                    width: 25,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    " ลดคาร์บอนไดออกไซด์ : " +
                        // _eve_drop_carbon +
                        " กิโลกรัม/ปี",
                    style: TextStyle(
                      fontSize: 18.0,
                      // fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: const Color(0xFF167F67),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'assets/images/proof-reading.png',
                    width: 25,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "รายละเอียดสถานที่",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ReadMoreText(
                _com_description,
                trimLines: 5,
                colorClickableText: Colors.blue,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'อ่านต่อ',
                trimExpandedText: ' ย้อนกลับ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
            Divider(
              color: const Color(0xFF167F67),
            ),
          ],
        ),
      ),
    );
  }
}
