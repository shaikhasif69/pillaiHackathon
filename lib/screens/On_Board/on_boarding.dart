import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pillai_hackcelestial/components/constant.dart';
import 'package:pillai_hackcelestial/router/NamedRoutes.dart';
import 'package:pillai_hackcelestial/screens/On_Board/on_board1.dart';
import 'package:pillai_hackcelestial/screens/On_Board/on_board2.dart';
import 'package:pillai_hackcelestial/screens/On_Board/on_board3.dart';
import 'package:pillai_hackcelestial/screens/On_Board/on_board4.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class on_boarding extends StatefulWidget {
  const on_boarding({super.key});

  @override
  State<on_boarding> createState() => _on_boardingState();
}

class _on_boardingState extends State<on_boarding> {
  PageController _controller = PageController();

  bool onLastpage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastpage = (index == 3);
              });
            },
            children: const [
              on_board1(),
              on_board2(),
              on_board3(),
              on_board4(),
            ]),
        Container(
          alignment: Alignment(-0.01, 0.50),
          child: SmoothPageIndicator(
            controller: _controller,
            count: 4,
            effect: const SlideEffect(
                spacing: 8.0,
                radius: 4.0,
                dotWidth: 14.0,
                dotHeight: 7.0,
                strokeWidth: 1.5,
                dotColor: Color.fromARGB(255, 206, 153, 255),
                activeDotColor: Color.fromARGB(255, 157, 0, 255)),
          ),
        ),
        Container(
          alignment: Alignment(-0.6, 0.75),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(3);
                  },
                  child: Text(
                    "Skip",
                    style: GoogleFonts.inter(fontSize: 15, color: Colors.grey),
                  )),
              onLastpage
                  ? GestureDetector(
                      onTap: () {
                        print("hello!");
                        
                        //      showCustomDialog(
                        //   context,
                        //   onValue: (_) {},
                        // );
                        GoRouter.of(context)
                            .pushNamed(CommonRoutes.askLoginScreen);
                        // Navigator.push(
                        //     context,
                        //     PageTransition(
                        //         type: PageTransitionType.bottomToTop,
                        //         child: OnbodingScreen()));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                            color: MyColors.ourPrimary,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Done ",
                                style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 1)
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                width: MediaQuery.of(context).size.width * 0.04,
                                child: Image.asset("lib/icons/check.png"),
                              ),
                            ],
                          ),
                        ),
                      ))
                  : GestureDetector(
                      onTap: () {
                        _controller.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                            color: MyColors.ourPrimary,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Next ",
                                style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 1),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width: MediaQuery.of(context).size.width * 0.06,
                                child: Image.asset("lib/icons/arrow.png"),
                              ),
                            ],
                          ),
                        ),
                      )),
            ],
          ),
        )
      ],
    ));
  }
}
