import 'package:carousel_slider/carousel_slider.dart';
import 'package:feminae/screens/decorations/decoration_screen.dart';
import 'package:feminae/screens/salon/salon_screen.dart';
import 'package:feminae/screens/stiching/stiching_screen.dart';
import 'package:feminae/utils/data.dart';
import 'package:feminae/utils/size_config.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  var currentPageValue = 0;

  @override
  Widget build(BuildContext context) {
    return _carouselSlider();
  }

  Widget _carouselSlider() {
    return CarouselSlider(
      height: 300.0,
      initialPage: 0,
      enlargeCenterPage: true,
      autoPlay: true,
      reverse: false,
      enableInfiniteScroll: true,
      onPageChanged: (index) {
        setState(() {
          currentPageValue = index;
        });
      },
      items: images1.map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (c, a1, a2) =>
                                  selectRouteInStack(currentPageValue),
                              transitionsBuilder: (c, anim, a2, child) =>
                                  FadeTransition(
                                opacity: anim,
                                child: child,
                              ),
                              transitionDuration: Duration(milliseconds: 100),
                            ));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black12),
                    child: Image.asset(
                      imageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget selectRouteInStack(int pageIndex) {
    switch (pageIndex) {
      case 0:
        return SalonScreen();
      case 1:
        return SalonScreen();
      case 2:
        return StichingScreen();
      case 3:
        return DecorationScreen();
      default:
        return Container();
    }
  }
}


