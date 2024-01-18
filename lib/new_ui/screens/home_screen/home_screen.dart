import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tsec_app/models/student_model/student_model.dart';
import 'package:tsec_app/provider/auth_provider.dart';
import 'package:tsec_app/screens/profile_screen/profile_screen.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
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
      body: widgets[selectedPage],
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();

    // return CustomScaffold(
    //   body: SafeArea(
    //     child: CustomScrollView(
    //       slivers: [
    //         const SliverToBoxAdapter(
    //           child: MainScreenAppBar(sidePadding: _sidePadding),
    //         ),
    //         data == null
    //             ? const DepartmentList()
    //             : SliverPadding(
    //                 padding: const EdgeInsets.all(20),
    //                 sliver: SliverToBoxAdapter(
    //                   child: Container(
    //                     width: _size.width * 0.9,
    //                     decoration: BoxDecoration(
    //                       color: _theme.primaryColor,
    //                       borderRadius: BorderRadius.circular(15.0),
    //                       border: Border.all(
    //                         color: _theme.primaryColorLight,
    //                         width: 1,
    //                         style: BorderStyle.solid,
    //                       ),
    //                       boxShadow: [_boxshadow],
    //                     ),
    //                     child: ClipRRect(
    //                       borderRadius: BorderRadius.circular(15.0),
    //                       child: DatePicker(
    //                         DateTime.now(),
    //                         monthTextStyle: _theme.textTheme.subtitle2!,
    //                         dayTextStyle: _theme.textTheme.subtitle2!,
    //                         dateTextStyle: _theme.textTheme.subtitle2!,
    //                         initialSelectedDate: DateTime.now(),
    //                         selectionColor: Colors.blue,
    //                         onDateChange: ((selectedDate) async {
    //                           ref
    //                               .read(dayProvider.notifier)
    //                               .update((state) => selectedDate);
    //                         }),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //         data != null ? const CardDisplay() : const SliverToBoxAdapter()
    //       ],
    //     ),
    //   ),
    // );
  }
}

class MainScreenAppBar extends ConsumerStatefulWidget {
  final EdgeInsets _sidePadding;
  const MainScreenAppBar({
    Key? key,
    required EdgeInsets sidePadding,
  })  : _sidePadding = sidePadding,
        super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MainScreenAppBarState();
}

class _MainScreenAppBarState extends ConsumerState<MainScreenAppBar> {
  // List<EventModel> eventList = [];
  bool shouldLoop = true;

  void launchUrlcollege() async {
    var url = "https://tsec.edu/";

    if (await canLaunchUrlString(url)) {
      await launchUrlString(url.toString());
    } else
      throw "Could not launch url";
  }

  // void fetchEventDetails() {
  //   ref.watch(eventListProvider).when(
  //       data: ((data) {
  //         eventList.addAll(data ?? []);
  //         imgList.clear();
  //         for (var data in eventList) {
  //           imgList.add(data.imageUrl);
  //         }
  //         // imgList = [imgList[0]];
  //         if (imgList.length == 1) shouldLoop = false;
  //       }),
  //       loading: () {
  //         const CircularProgressIndicator();
  //       },
  //       error: (Object error, StackTrace? stackTrace) {});
  // }

  static List<String> imgList = [];

  //static const _sidePadding = EdgeInsets.symmetric(horizontal: 15);
  static int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    StudentModel? data = ref.watch(studentModelProvider);
    return Container();

    
  }
}
