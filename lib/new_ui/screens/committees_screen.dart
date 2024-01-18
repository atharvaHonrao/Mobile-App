import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tsec_app/utils/image_assets.dart';

import '../../models/committee_model/committee_model.dart';
import '../../models/student_model/student_model.dart';
import '../../provider/auth_provider.dart';
import '../../screens/profile_screen/profile_screen.dart';
import '../../utils/notification_type.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_scaffold.dart';
import 'home_screen/home_screen.dart';

class CommitteesScreen extends StatefulWidget {
  const CommitteesScreen({Key? key}) : super(key: key);

  @override
  _CommitteesScreenState createState() => _CommitteesScreenState();
}

class _CommitteesScreenState extends State<CommitteesScreen> {
  late final PageController _pageController;
  late final Future<List<CommitteeModel>> _committees;
  int _currentPage = 0;
  static const colorList = [Colors.red, Colors.teal, Colors.blue];
  static const opacityList = [
    Color.fromRGBO(255, 0, 0, 0.2),
    Color.fromARGB(51, 0, 255, 225),
    Color.fromARGB(51, 0, 153, 255),
  ];

  int selectedPage = 0;
  List<Widget> widgets = <Widget>[
    HomeWidget(),
    const Text(
      'Library',
    ),
    const Text(
      'Timetable',
    ),
    const Text(
      'Railway Concession',
    ),
    ProfilePage(
      justLoggedIn: false,
    ),
  ];

  static const _sidePadding = EdgeInsets.symmetric(horizontal: 15);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int currentPage = 0;
  List<Widget> pages = [
    HomeScreen(),
    Container(child: Text("TPC")),
    Container(child: Text("Commi")),
    Container(),
    Container(),
    // ProfilePage(
    //   justLoggedIn: false,
    // ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.8,
    )..addListener(() {
        if (mounted) setState(() {});
      });

    _committees = _getCommittees();
  }

  Future<List<CommitteeModel>> _getCommittees() async {
    final data = await rootBundle.loadString("assets/data/committees.json");
    final json = jsonDecode(data) as List;
    return json.map((e) => CommitteeModel.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    final _size = MediaQuery.of(context).size;
    var _theme = Theme.of(context);
    var _boxshadow = BoxShadow(
      color: _theme.primaryColorDark,
      spreadRadius: 1,
      blurRadius: 2,
      offset: const Offset(0, 1),
    );
    var profilePic = null;

    return CustomScaffold(
      body: ListView(
        children: <Widget>[
          AppBar(
            shadowColor: Colors.transparent,
            toolbarHeight: 120,
            leadingWidth: 100,
            leading: Row(
              children: [
                SizedBox(
                  width: 8,
                ),
                profilePic != null
                    ? GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: MemoryImage(profilePic),
                          // backgroundImage: MemoryImage(_image!),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              AssetImage("assets/images/pfpholder.jpg"),
                        ),
                      )
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Ink(
                  decoration: ShapeDecoration(
                    color: Colors.white, // White background color
                    shape: CircleBorder(), // Circular shape
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.note,
                      color: Colors.black, // Black icon color
                    ),
                    onPressed: () {
                      // Handle button click
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Ink(
                  decoration: ShapeDecoration(
                    color: Colors.white, // White background color
                    shape: CircleBorder(), // Circular shape
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.event_note,
                      color: Colors.black, // Black icon color
                    ),
                    onPressed: () {
                      // Handle button click
                    },
                  ),
                ),
              )
            ],
            backgroundColor: Colors.transparent,
          ),
          FutureBuilder<List<CommitteeModel>>(
            future: _committees,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!;
                return SizedBox(
                  height: _height * 0.69,
                  child: PageView.builder(
                    onPageChanged: (page) {
                      _currentPage = page;
                    },
                    controller: _pageController,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final double currentPage =
                          _pageController.position.hasContentDimensions
                              ? _pageController.page ?? 0
                              : 0;

                      // Calculate the scale based on the distance from the current page
                      final double scale =
                          1 - ((currentPage - index).abs() * 0.2);

                      return Transform.scale(
                        scale: scale,
                        child: Container(
                          width: _width * 0.8, // Adjust the width as needed
                          child: Card(
                            color: Colors.grey.withOpacity(0.7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height:
                                      120, // Set the fixed height for the image
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15),
                                        bottom: Radius.circular(15)),
                                    child: CachedNetworkImage(
                                      imageUrl: data[index].image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: _height * 0.1,
                                  child: Center(
                                    child: Text(
                                      data[_currentPage].name,
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: _height * 0.4,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        data[_currentPage].description,
                                        style: TextStyle(fontSize: 12,color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          BottomNavigationBar(
            // backgroundColor: Colors.black,
            elevation: 0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                activeIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: "Home",
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Icon(Icons.book_outlined),
                activeIcon: Icon(Icons.book),
                label: "Library",
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                activeIcon: Icon(Icons.calendar_today),
                icon: Icon(Icons.calendar_today_outlined),
                label: "Time Table",
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Icon(Icons.directions_railway_outlined),
                activeIcon: Icon(Icons.directions_railway_filled),
                label: "Railway",
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
            currentIndex: selectedPage,
            onTap: (index) {
              setState(() {
                selectedPage = index;
              });
            },
          ),
        ],
      ),
    );
  }
}
