import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'dart:async';
import 'dart:convert';

class List_event extends StatefulWidget {
  const List_event({Key? key}) : super(key: key);

  @override
  State<List_event> createState() => _List_eventState();
}

class _List_eventState extends State<List_event> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  Widget build_card_event() {
    return Card();
  }

  Future get_list_event() async {
    var url = Uri.parse(
        'https://www.informatics.buu.ac.th/team2/Admin/Manage_banner/Admin_manage_banner/get_banner_list_ajax');

    var respone = await http.get(url);

    var result = respone.body;

    return result;
  }
}
