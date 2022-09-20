import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../forms/register_page.dart';
import '../intro_screens/intro_page_1.dart';
import '../intro_screens/intro_page_2.dart';
import '../intro_screens/intro_page_3.dart';
import '../intro_screens/intro_page_4.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // controller to keep track of which page we're on
  PageController _controller = PageController();

  // keep track of if we are on the last page or not
  bool onLastPage = false;





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //page view
          PageView(
            controller: _controller,
            onPageChanged: (index){
              setState(() {
                onLastPage = (index == 3);
              });
            },
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
              IntroPage4(),
            ],
          ),




          //indicator
          Container(
            alignment: Alignment(0, 0.85),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //skip
                  GestureDetector(
                    onTap: (){
                      _controller.jumpToPage(3);
                    },
                    child: Text("Skip", style: TextStyle( fontSize: 17),)
                  ),


                  //dot indicator
                  SmoothPageIndicator(controller: _controller, count: 4,
                             effect: const SwapEffect(
                               type: SwapType.yRotation,
                               dotColor:  Colors.grey,
                               activeDotColor:  Colors.black,
                               dotWidth:  11.0,
                               dotHeight:  11.0,
                               spacing:  14,
                             ), ),

                  //next or done
                  onLastPage?
                  GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context){
                              return RegisterPage();
                            },
                            ),
                        );
                      },
                      child: Text("Done", style: TextStyle( fontSize: 17),)
                  ) :
                  GestureDetector(
                      onTap: (){
                        _controller.nextPage(duration: Duration(microseconds: 500), curve: Curves.easeIn);
                      },
                      child: Text("Next", style: TextStyle(fontSize: 17),)
                  )
                ],
              )
          )


        ],
      )
    );
  }
}

