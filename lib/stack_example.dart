import 'package:carousel_slider/carousel_slider.dart';
import 'package:feminae/utils/data.dart';
import 'package:feminae/utils/size_config.dart';
import 'package:flutter/material.dart';

class StackExample extends StatefulWidget {
  static String id = 'stackexample_screen';
  @override
  _StackExampleState createState() => new _StackExampleState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _StackExampleState extends State<StackExample> {
  var currentPageValue = 0;
  PageController controller;
  double _viewPortFraction = 0.8;

  @override
  void initState() {
    super.initState();
    controller = PageController(viewportFraction: _viewPortFraction);
  }

  @override
  Widget build(BuildContext context) {
    // controller.addListener(() {
    //   setState(() {
    //     currentPageValue = controller.page;
    //   });
    // });

    return Scaffold(
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            if (index % 2 == 0) {
              return _carouselSlider();
            } else {
              return Divider();
            }
          }),
    );
  }

  // Widget _buildPage() {
  //   return PageView.builder(
  //       controller: controller,
  //       itemBuilder: (context, position) {
  //         if (position == currentPageValue.floor()) {
  //           return Transform(
  //             transform: Matrix4.identity()
  //               ..rotateX(currentPageValue - position),
  //             child: Container(
  //                 color: position % 2 == 0 ? Colors.blue : Colors.pink,
  //                 child: Center(
  //                     child: Text(
  //                   'Page',
  //                   style: TextStyle(color: Colors.white, fontSize: 22.0),
  //                 ))),
  //           );
  //         } else if (position == currentPageValue.floor() + 1) {
  //           return Transform(
  //             transform: Matrix4.identity()
  //               ..rotateX(currentPageValue - position),
  //             child: Container(
  //                 color: position % 2 == 0 ? Colors.blue : Colors.pink,
  //                 child: Center(
  //                     child: Text(
  //                   'Page',
  //                   style: TextStyle(color: Colors.white, fontSize: 22.0),
  //                 ))),
  //           );
  //         } else {
  //           return Container(
  //             color: position % 2 == 0 ? Colors.pink : Colors.cyan,
  //           );
  //         }
  //       });
  // }

  Widget _buildCarousel(BuildContext context, int carouselIndex) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('Carousel $carouselIndex'),
        SizedBox(
          // you may want to use an aspect ratio here for tablet support
          height: 200.0,
          child: PageView.builder(
            // store this controller in a State to save the carousel scroll position

            controller: controller,
            itemCount: images.length,
            onPageChanged: (int value) {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            itemBuilder: (BuildContext context, int itemIndex) {
              if (itemIndex == currentPageValue.floor()) {
                return _buildCarouselItem(
                    context, carouselIndex, itemIndex, 100.0);
              } else if (itemIndex == currentPageValue.floor() + 1) {
                return _buildCarouselItem(
                    context, carouselIndex, itemIndex, 100.0);
              } else {
                return _buildCarouselItem(
                    context, carouselIndex, itemIndex, 200.0);
              }

              // if (images.length >= itemIndex) {
              //   //Active Page
              //   bool active = itemIndex == currentPageValue;
              //   return _buildStoryPage(itemIndex - 1, active);
              // }
            },
            // childrenDelegate: SliverChildBuilderDelegate(
            //     (BuildContext context, int itemIndex) {
            //   if (itemIndex == currentPageValue.floor()) {
            //     return _buildCarouselItem(
            //         context, carouselIndex, itemIndex, 100.0);
            //   } else if (itemIndex == currentPageValue.floor() + 1) {
            //     return _buildCarouselItem(
            //         context, carouselIndex, itemIndex, 100.0);
            //   } else {
            //     return _buildCarouselItem(
            //         context, carouselIndex, itemIndex, 200.0);
            //   }
            // }),
          ),
        )
      ],
    );
  }

  Widget _buildCarouselItem(
      BuildContext context, int carouselIndex, int itemIndex, double height) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          )),
    );
  }

  _buildStoryPage(int index, bool active) {
    //Animated Properties
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 100 : 200;

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(images[1]),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black87,
                blurRadius: blur,
                offset: Offset(offset, offset))
          ]),
      child: Center(
        child: Text(
          title[1],
          style: TextStyle(fontSize: 40, color: Colors.white),
        ),
      ),
    );
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black12
                  ),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
