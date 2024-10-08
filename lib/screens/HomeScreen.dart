import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pillai_hackcelestial/Socket/init.dart';
import 'package:pillai_hackcelestial/components/constant.dart';
import 'package:pillai_hackcelestial/components/menu.dart';
import 'package:pillai_hackcelestial/components/rive_assets.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import 'package:pillai_hackcelestial/components/rive_utils.dart';
import 'package:pillai_hackcelestial/router/NamedRoutes.dart';
import 'package:pillai_hackcelestial/screens/Students/dashboard_page.dart';
import 'package:pillai_hackcelestial/screens/Students/events_screen.dart';
import 'package:pillai_hackcelestial/screens/Students/mentorship_page.dart';
import 'package:pillai_hackcelestial/screens/Students/my_communities.dart';
import 'package:pillai_hackcelestial/screens/search_page.dart';
import 'package:pillai_hackcelestial/widgets/EventsCrad.dart';
import 'package:pillai_hackcelestial/widgets/StudentCard.dart';
import 'package:pillai_hackcelestial/widgets/UserProfileHomePage.dart';
import 'package:pillai_hackcelestial/widgets/btm_nav_item.dart';
import 'package:pillai_hackcelestial/widgets/getCommuityListPorvider.dart';
import 'package:pillai_hackcelestial/widgets/getFaclutyListProvider.dart';
import 'package:pillai_hackcelestial/widgets/mentorCards.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Homescreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _HomeScreen();
    throw UnimplementedError();
  }
}

class _HomeScreen extends ConsumerState<Homescreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> scalAnimation;
  late Animation<double> animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100))
          ..addListener(() {
            setState(() {});
          });
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
    // getUserDetails();
  }

  Menu selectedBottonNav = bottomNavItems[0];
  List<IconData> icons = [
    Icons.home,
    CupertinoIcons.person_crop_rectangle,
    CupertinoIcons.envelope,
    CupertinoIcons.doc_on_clipboard,
    CupertinoIcons.profile_circled,
  ];

  int page = 0;

  void updateSelectedBtmNav(Menu menu) {
    if (selectedBottonNav != menu) {
      setState(() {
        selectedBottonNav = menu;
      });
    }
  }

  Widget build(context) {
    List<Widget> pages = [
      Dashboard(),
      MentorshipPage(),
      SearchPage(),
      UserDashboardPage(),
      EventScreen(),
    ];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.mic),
          onPressed: () {
            GoRouter.of(context).pushNamed(StudentsRoutes.chatBot);
          }),
      backgroundColor: MyColors.ourBackground,
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 30,
              child: DrawerHeader(
                  padding: const EdgeInsets.fromLTRB(40.0, 16.0, 16.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                      ),
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(21)),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/images/council (1).png"))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Ryaan Patel",
                        style: GoogleFonts.mulish(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "rayan@gaimil.com",
                        style: GoogleFonts.mulish(
                            fontSize: 14,
                            color: const Color.fromARGB(255, 124, 124, 124)),
                      )
                    ],
                  )),
            ),
            Expanded(
              flex: 70,
              child: Column(
                children: [
                  InkWell(
                    onTap:(){
                      GoRouter.of(context).pushNamed(StudentsRoutes.studentProfilePage);
                    },
                    child: ListTile(
                      leading: Icon(Icons.file_copy),
                      title: Text(
                        "Profile",
                        style: GoogleFonts.abel(fontSize: 16),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      GoRouter.of(context).pushNamed(StudentsRoutes.community);
                    },
                    child: ListTile(
                      leading: Icon(Icons.file_copy),
                      title: Text(
                        "Communities",
                        style: GoogleFonts.abel(fontSize: 16),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      GoRouter.of(context)
                          .pushNamed(StudentsRoutes.StudentFourm);
                    },
                    child: ListTile(
                      leading: Icon(Icons.file_copy),
                      title: Text(
                        "Student Forum",
                        style: GoogleFonts.abel(fontSize: 16),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      GoRouter.of(context)
                          .pushNamed(StudentsRoutes.chattingList);
                    },
                    child: ListTile(
                      leading: Icon(Icons.file_copy),
                      title: Text(
                        "Chats",
                        style: GoogleFonts.abel(fontSize: 16),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.file_copy),
                    title: Text(
                      "Opportunities",
                      style: GoogleFonts.abel(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.file_copy),
                    title: Text(
                      "settings",
                      style: GoogleFonts.abel(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.file_copy),
                    title: Text(
                      "Helps & FAQs",
                      style: GoogleFonts.abel(fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        GoRouter.of(context)
                            .pushNamed(StudentsRoutes.community);
                      },
                      child: Text("Communities")),
                ],
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: MyColors.ourBackground,
        actions: [
          InkWell(
            onTap: () {},
            child: SizedBox(
                height: 30,
                width: 40,
                child: Image.asset(
                  fit: BoxFit.cover,
                  "assets/images/Google Alerts.png",
                )),
          ),
          InkWell(
            onTap: () {
              GoRouter.of(context).pushNamed(StudentsRoutes.studentProfilePage);
              // mySocketConnect.socket.emit("reciveMessage", {
              //   "userId": "66e6926336455070e72e4bcb",
              //   "roomId": "room1",
              //   "content": "ddd"
              // });
            },
            child: SizedBox(
              height: 35,
              width: 40,
              child: Image.asset(
                fit: BoxFit.cover,
                "assets/images/Male User.png",
              ),
            ),
          )
        ],
      ),
      body: pages[page],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: icons,
        iconSize: 25,
        activeIndex: page,
        height: 65,
        splashSpeedInMilliseconds: 300,
        gapLocation: GapLocation.none,
        activeColor: const Color.fromARGB(255, 0, 190, 165),
        inactiveColor: const Color.fromARGB(255, 223, 219, 219),
        onTap: (int tappedIndex) {
          setState(() {
            page = tappedIndex;
          });
        },
      ),
    );
  }

  SingleChildScrollView Dashboard() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserProfileHomePage(),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Let's Build some Connections",
                  style: GoogleFonts.abyssinicaSil(fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Text(
                    "View More",
                    style: TextStyle(color: MyColors.ourPrimary),
                  ),
                )
              ],
            ),
          ),
          GetFalcultyList(),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Let’s Catch up",
                        style: GoogleFonts.abyssinicaSil(
                          fontSize: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          "View More",
                          style: TextStyle(color: MyColors.ourPrimary),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 302,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext con, int index) {
                          return StudentCard();
                        }),
                  ),
                ],
              )),
          // CommunityList()
        ],
      ),
    );
  }
}
