import 'package:contactsapp/global.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);
  String? _chosenValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(left: 190.0, bottom: 26.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SmoothPageIndicator(
                    controller: _pageController, // PageController
                    count: 2,
                    effect: WormEffect(
                        spacing: 15.0,
                        dotWidth: 11.0,
                        dotHeight: 11.0,
                        activeDotColor: Colors.black,
                        dotColor: Color(0xffbcbcbc)), // your preferred effect
                    onDotClicked: (index) {}),
              ],
            ),
          ),
          PageView(
            controller: _pageController,
            children: <Widget>[intro1(), intro2()],
          ),
        ]));
  }

  Widget intro1() {
    return Column(
      children: [
        Column(
          children: [
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.width - 300),
              height: MediaQuery.of(context).size.width - 360,
              child: Image.asset('assets/images/kontaktlogo.png'),
            ),
            Text("Kontakt", style: introScreen, textAlign: TextAlign.center)
          ],
        ),
        SizedBox(
          height: 60.0,
        ),
        Container(
          height: 300.0,
          child: Image.asset('assets/images/pana.png'),
        ),
        SizedBox(
          height: 23.0,
        ),
        Container(
            width: 300.0,
            child: Text(
              "Access all the contacts from your department in one place.",
              style: introScreenDesc,
              textAlign: TextAlign.center,
            )),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0, right: 15.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Next", style: introNPbtn),
                  SizedBox(
                    width: 3.0,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15.0,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget intro2() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100.0, left: 40.0, right: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to",
                style: welcomeText,
              ),
              Text(
                "Kontakt",
                style: welcomeKontakt,
              ),
              SizedBox(
                height: 80.0,
              ),
              Text(
                "Select your branch",
                style: branchSelection,
              ),
              Text(
                "Note : The selected branch will be displayed in your home screen as default.",
                style: descTextIntro,
              ),
              SizedBox(
                height: 20.0,
              ),
              //DropDown
              Container(
                width: 340.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xffF1F1F1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: const Offset(
                        0.0,
                        4.0,
                      ),
                      blurRadius: 8.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _chosenValue,
                    isExpanded: true,
                    //elevation: 5,
                    style: TextStyle(color: Color(0xffbcbcbc)),
                    icon: Transform.rotate(
                      angle: 270 * math.pi / 180,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xffbcbcbc),
                          size: 19.0,
                        ),
                      ),
                    ),

                    items: <String>[
                      'Computer Science & Engineering',
                      'Information Science & Engineering',
                      'Mechanical Engineering',
                      'Electronics & Communications Engineering'
                      'Civil Engineering',
                      'Artifical Intelligence',
                      'Data Science',
      
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 12.0, right: 10.0),
                          child: Text(
                            value,
                            style: dropDownList,
                          ),
                        ),
                      );
                    }).toList(),
                    hint: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Text(
                        "Please choose a department",
                        style: dropDownList,
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _chosenValue = value;
                      });
                    },
                  ),
                ),
              ),
              //DropDown Ends
              SizedBox(
                height: 40.0,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Proceed',
                      style: allBtns,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0, left: 15.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 15.0,
                  ),
                  SizedBox(
                    width: 3.0,
                  ),
                  Text("Previous", style: introNPbtn),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
