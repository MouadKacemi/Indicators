import 'package:flutter/material.dart';
import 'package:indicators/helpers/ColorsSys.dart';
import 'package:indicators/helpers/Strings.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          AppBar(elevation: 0, backgroundColor: Colors.white, actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20, top: 20),
          child: Text("Skip",
              style: TextStyle(
                  color: ColorSys.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
        )
      ]),
      body: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
        GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              // Swipe right (go to the previous page)
              _pageController.previousPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            } else if (details.primaryVelocity! < 0) {
              // Swipe left (go to the next page)
              _pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            }
          },

          // ...

          child: PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            children: <Widget>[
              makePage(
                  image: "assets/images/step-one.png",
                  title: Strings.stepOneTitle,
                  content: Strings.stepOneContent),
              makePage(
                  reverse: true,
                  image: "assets/images/step-two.png",
                  title: Strings.stepTwoTitle,
                  content: Strings.stepTwoContent),
              makePage(
                  image: "assets/images/step-three.png",
                  title: Strings.stepThreeTitle,
                  content: Strings.stepThreeContent),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildIndicator(),
          ),
        )
      ]),
    );
  }

  Widget makePage({image, title, content, reverse = false}) {
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50, bottom: 60),
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              !reverse
                  ? Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Image(image: AssetImage(image)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    )
                  : SizedBox(),
              Text(title,
                  style: TextStyle(
                      color: ColorSys.primary,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              Text(content,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorSys.gray,
                      fontSize: 30,
                      fontWeight: FontWeight.w400)),
              reverse
                  ? Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Image(image: AssetImage(image)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    )
                  : SizedBox(),
            ]),
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 30 : 8,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: ColorSys.secoundry, borderRadius: BorderRadius.circular(5)),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }
}
