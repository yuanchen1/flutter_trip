import 'package:flutter/material.dart';
import 'package:flutter_trips/dao/travel_tab_dao.dart';
import 'package:flutter_trips/model/travel_tab_model.dart';

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {
  TabController _controller;
  List<TravelTab> tabs = [];
  TravelTabModel travelTabModel;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 0, vsync: this);
    //初始化tab数据
    TravelTabDao.fetch().then((TravelTabModel model) {
      _controller = TabController(length: model.tabs.length, vsync: this);
      setState(() {
        tabs = model.tabs;
        travelTabModel = model;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 30),
            child: TabBar (
              controller: _controller,
              isScrollable: true,
              labelColor: Colors.black,
              labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide (
                  color: Color(0xff2fcfbb),
                  width: 3,
                ),
                insets: EdgeInsets.only(bottom: 10), //控制指示器的底部padding
              ),
              tabs: tabs.map<Tab>((TravelTab tab) {
                return Tab(text: tab.labelName,);
              }).toList()
            ),
          ),
          Flexible(
            child: TabBarView(
              controller: _controller,
              children: tabs.map((TravelTab tab){
                return Text(tab.groupChannelCode,style: TextStyle(color: Colors.red),);
              }).toList(),
            ),
          )
        ],
      )
    );
  }
}

