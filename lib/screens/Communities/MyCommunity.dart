import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pillai_hackcelestial/Services/student.dart';
import 'package:pillai_hackcelestial/Socket/init.dart';
import 'package:pillai_hackcelestial/model/Disscussion.dart';
import 'package:pillai_hackcelestial/model/StudentFourm.dart';
import 'package:pillai_hackcelestial/model/community.dart';
import 'package:pillai_hackcelestial/screens/committe/create/createCommitteform.dart';
import 'package:pillai_hackcelestial/widgets/AboutCommunityTabBar1.dart';
import 'package:pillai_hackcelestial/widgets/AboutCommunityTabBar2.dart';
import 'package:pillai_hackcelestial/widgets/AboutCommunityTabBar3.dart';
import 'package:pillai_hackcelestial/widgets/DiscussionChatList.dart';

class Mycommunity extends ConsumerStatefulWidget {
  final Communites data;
  Mycommunity({required this.data});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MyCommunity();
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _MyCommunity extends ConsumerState<Mycommunity>
    with SingleTickerProviderStateMixin {
  late ScrollController dicCon;
  late ScrollController nested;
  late TextEditingController msg;
  @override
  void initState() {
    super.initState();
    msg = TextEditingController();
    nested = ScrollController();
    dicCon = ScrollController()..addListener(listCon);
    mySocketConnect.socket.emit('joinRoom', {
      'roomId': widget.data.sId,
      'userId': StudentServices.myId,
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // dicCon.jumpTo(value)NestedScrollView.scrollTo(0, 0);
    });
  }

  void sendMessage(String message) {
    print("msg sent");
    if (message.isNotEmpty) {
      mySocketConnect.socket.emit('message', {
        'roomId': widget.data.sId,
        'userId': StudentServices.myId,
        'content': message,
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nested.dispose();
    dicCon.dispose();
    // mySocketConnect.socket.destroy();
    msg.dispose();
  }

  void listCon() {
    if (dicCon.position.pixels == dicCon.position.maxScrollExtent) {
      print("reached Top");
      //  nested.;
      // nested
      //   ..animateTo(
      //     nested.position.minScrollExtent,
      //     duration: Duration(seconds: 1),
      //     curve: Curves.easeOut,
      //   );
    }
  }

  Widget build(context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color.fromARGB(255, 182, 90, 207),
      // ),
      backgroundColor: Color.fromARGB(255, 250, 248, 241),
      body: SafeArea(
        child: DefaultTabController(
          length: 4,
          child: NestedScrollView(
            controller: nested,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                // SliverAppBar(
                //   // forceElevated: innerBoxIsScrolled,
                //   // pinned: true,

                //   backgroundColor: Color.fromARGB(255, 182, 90, 207),
                //   leading: Card(
                //       color: const Color.fromARGB(255, 81, 169, 84),
                //       child: Icon(color: Colors.white, Icons.arrow_back)),
                //   actions: [
                //     Card(
                //         color: const Color.fromARGB(255, 81, 169, 84),
                //         child: SizedBox(
                //             height: 50,
                //             width: 50,
                //             child: Icon(
                //                 size: 24,
                //                 color: Colors.white,
                //                 Icons.favorite_border))),
                //     Card(
                //         color: const Color.fromARGB(255, 81, 169, 84),
                //         child: SizedBox(
                //             height: 50,
                //             width: 50,
                //             child: Icon(
                //                 size: 24,
                //                 color: Colors.white,
                //                 Icons.settings))),
                //   ],
                // ),
                SliverAppBar(
                  // pinned: true,
                  automaticallyImplyLeading: false,
                  backgroundColor: Color.fromARGB(255, 182, 90, 207),
                  expandedHeight: 300,
                  bottom: PreferredSize(
                    preferredSize: Size(double.infinity, 300),
                    child: Container(
                      // color: Colors.amber,
                      height: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 70,
                                  ),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      // widget.data.name!,
                                      widget.data.name!,

                                      style: GoogleFonts.mulish(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    "124 Active Members",
                                    style: GoogleFonts.mulish(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "Sunil",
                                    style: GoogleFonts.mulish(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "-Created by",
                                    style: GoogleFonts.mulish(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              ),
                              // Spacer(),
                              Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                    // color: Colors.amber,
                                    image: DecorationImage(
                                        // image: widget.data.imageUrl == null?
                                        image: AssetImage(
                                            "assets/images/lgbtq-community-attractive-queer-man-with-flitter-face-waving-pride-rainbow-flag-looking-c-modified 1.png"))),
                              )
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            height: 100,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 250, 248, 241),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40))),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20.0, 16, 20, 12),
                              child: Container(
                                // color: Colors.amber,
                                child: SingleChildScrollView(
                                  child: Text(
                                    widget.data.description!,
                                    textAlign: TextAlign.start,
                                    // overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.mulish(
                                        fontSize: 14,
                                        color: const Color.fromARGB(
                                            255, 124, 124, 124)),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverPersistentHeader(
                      // floating: true,
                      pinned: true,
                      delegate: MySliverPersistentHeaderDelegate(
                        child: TabBar(
                            indicatorWeight: 6,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorColor:
                                const Color.fromARGB(255, 206, 110, 89),
                            labelPadding: EdgeInsets.symmetric(vertical: 8),
                            labelStyle: GoogleFonts.mulish(
                                color: Color.fromARGB(255, 206, 110, 89),
                                fontSize: 16,
                                fontWeight: FontWeight.w800),
                            unselectedLabelStyle: GoogleFonts.mulish(
                                color: Color.fromARGB(255, 124, 124, 124),
                                fontWeight: FontWeight.w800,
                                fontSize: 16),
                            tabs: [
                              Text(
                                "Discussion",
                              ),
                              Text("Post"),
                              Text(
                                "Events",
                              ),
                              Text(
                                "Members",
                              ),
                            ]),
                        minHeight: 60,
                        maxHeight: 60,
                      )),
                ),
                // SliverPersistentHeader(
                //   pinned: true,
                //   delegate: MySliverPersistentHeaderDelegate(
                //       child: ,
                //       minHeight: MediaQuery.of(context).size.height * 0.85,
                //       maxHeight: MediaQuery.of(context).size.height * 0.85),
                // ),
              ];
            },
            body: TabBarView(
              // physics: NeverScrollableScrollPhysics(),
              children: [
                Discussionchatlist(
                  nest: nested,
                  communityId: widget.data.sId!,
                  desCo: dicCon,
                  sendMessage: sendMessage,
                ),
                Column(
                  children: [
                    SizedBox(height: 80),
                    Expanded(
                        child: Aboutcommunitytabbar1(id: widget.data.sId!)),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 80),
                    Expanded(
                        child: Aboutcommunitytabbar2(id: widget.data.sId!)),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 80),
                    Expanded(
                        child: Aboutcommunitytabbar3(id: widget.data.sId!)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget senderCard({required Discussion d}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
    child: Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: const Color.fromARGB(109, 124, 124, 124), width: 0.3),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60),
            bottomRight: Radius.circular(60),
            topRight: Radius.circular(60)),
      ),
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40))),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: d.imgUrl == null || d.imgUrl == ""
                                ? AssetImage("assets/images/speaker.png")
                                : NetworkImage(d.imgUrl!))),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        d.username!,
                        style: GoogleFonts.mulish(
                            color: Color.fromARGB(255, 182, 90, 207),
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        datePrase(d.createdAt!),
                        style: GoogleFonts.mulish(
                            color: Color.fromARGB(255, 124, 124, 124),
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.bookmark)),
                ],
              ),
            ),
            SizedBox(),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: Container(
                  // color: Colors.blue,
                  child: Text(
                d.content!,
                style: GoogleFonts.mulish(
                    fontSize: 16, fontWeight: FontWeight.bold),
              )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                children: [
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 211, 151, 151),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(d.downvotes.toString() + " response"),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 193, 227, 193),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(d.upvotes.toString() + " response"),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

String datePrase(String d) {
  DateTime dateTime = DateTime.parse(d);

  // Format the date to dd/mm/yyyy
  String formattedDate = '${dateTime.day.toString().padLeft(2, '0')}/'
      '${dateTime.month.toString().padLeft(2, '0')}/'
      '${dateTime.year}';
  return formattedDate;
}

Widget reciver({required Discussion d}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
    child: Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color.fromARGB(109, 124, 124, 124), width: 0.3),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60),
            bottomLeft: Radius.circular(60),
            topRight: Radius.circular(60)),
      ),
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40))),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.bookmark)),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        d.username!,
                        style: GoogleFonts.mulish(
                            color: Color.fromARGB(255, 182, 90, 207),
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        datePrase(d.createdAt!),
                        style: GoogleFonts.mulish(
                            color: Color.fromARGB(255, 124, 124, 124),
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 60,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: d.imgUrl == null || d.imgUrl == ""
                                ? AssetImage("assets/images/speaker.png")
                                : NetworkImage(d.imgUrl!))),
                  ),
                ],
              ),
            ),
            SizedBox(),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: Container(
                  // color: Colors.blue,
                  child: Text(
                d.content!,
                style: GoogleFonts.mulish(
                    fontSize: 16, fontWeight: FontWeight.bold),
              )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 211, 151, 151),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(d.downvotes.toString() + " response"),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 193, 227, 193),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(d.upvotes.toString() + " response"),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
