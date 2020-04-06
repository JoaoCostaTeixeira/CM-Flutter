/*import 'package:flutter/material.dart';
import 'package:myapp1/tabs/first.dart';
import 'package:myapp1/tabs/second.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myapp1/medicationPage.dart';
class Shop extends StatefulWidget {
  @override
  ShopState createState() {
    return new ShopState();
  }
}


class ShopState extends State<Shop> with SingleTickerProviderStateMixin{
  /*
   *-------------------- Setup Tabs ------------------*
   */
  // Create a tab controller
  TabController controller;
  var nameOfApp = "Persist Key Value";

  var counter = 0;

  // define a key to use later
  var key = "counter";


  @override
  void initState() {
    super.initState();
    _loadSavedData();
    // Initialize the Tab Controller
    controller = TabController(length: 2, vsync: this);
  }

  void _onIncrementHit() async {
    // Get shared preference instance
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      // Get value
      counter = (prefs.getInt(key) ?? 0) + 1;
    });

    // Save Value
    prefs.setInt(key, counter);
  }

  void _onDecrementHit() async {
    // Get shared preference instance
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      // Get value
      counter = (prefs.getInt(key) ?? 0) - 1;
    });

    // Save Value
    prefs.setInt(key, counter);
  }

  _loadSavedData() async {
    // Get shared preference instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Get value
      counter = (prefs.getInt(key) ?? 0);
    });
  }




  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    super.dispose();
  }

  TabBar getTabBar() {
    return TabBar(
      tabs: <Tab>[
        Tab(
          // set icon to the tab
          text: "My medication",
        ),
        Tab(
          text: "Add new Medication",
        ),
      ],
      // setup the controller
      controller: controller,
    );
  }

  TabBarView getTabBarView(var tabs) {
    return TabBarView(
      // Add tabs as widgets
      children: tabs,
      // set the controller
      controller: controller,
    );
  }

  /*
   *-------------------- Setup the page by setting up tabs in the body ------------------*
   */
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: AppBar(
        // Title
        title: Text("My medications"),
      ),
      // Body
      body: MedicationPage(),
    );
  }
}*/
