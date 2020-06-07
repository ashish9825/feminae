import 'package:feminae/decorations/circletab_indicator.dart';
import 'package:feminae/screens/cleaning/cleaning_screen.dart';
import 'package:feminae/screens/decorations/decoration_screen.dart';
import 'package:feminae/screens/electronics/electronics_screen.dart';
import 'package:feminae/screens/salon/salon_screen.dart';
import 'package:feminae/screens/stiching/stiching_screen.dart';
import 'package:feminae/widgets/carausel_slider.dart';
import 'package:feminae/widgets/top_bar.dart';
import 'package:feminae/services/location.dart';
import 'package:feminae/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:feminae/utils/app_style.dart';
import 'package:feminae/widgets/category_card.dart';
import 'package:feminae/utils/data.dart';
import 'dart:math';

List<List<Color>> gradientColors = [
  [Color(0xFF3a7bd5), Color(0xFF3a6073)],
  [Color(0xFFFF5F6D), Color(0xFFFFC371)],
  [Color(0xFFEECDA3), Color(0xFFEF629F)],
  [Color(0xFFBA5370), Color(0xFFF4E2D8)],
  [Color(0xFF654ea3), Color(0xFFeaafc8)],
  [Color(0xFFEB5757), Color(0xFF000000)],
];

int colorPosition;
String cardIcon;
String categoryName;
String currentLocation;

class HomePage extends StatefulWidget {
  static String id = 'home_screen';
  @override
  _HomePageState createState() => _HomePageState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _currentIndex = 0;
  bool _isSelected;
  var currentPage = images.length - 1.0;
  Location location = Location();

  List<String> categories = [
    'Salon',
    'Cleaning',
    'Massage',
    'Fitness',
    'Stiching',
    'Electronics'
  ];

  List<Widget> _buildServiceCategories() {
    return categories.map((category) {
      var index = categories.indexOf(category);
      _isSelected = _currentIndex == index;
      return Padding(
        padding: EdgeInsets.only(left: ScreenUtil().setWidth(75)),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _currentIndex = index;
              categoryName = category;
              switch (category) {
                case 'Salon':
                  {
                    colorPosition = 0;
                    cardIcon = 'images/scissors.svg';
                  }
                  break;
                case 'Cleaning':
                  {
                    colorPosition = 1;
                    cardIcon = 'images/cleaning.svg';
                  }
                  break;
                case 'Massage':
                  {
                    colorPosition = 2;
                    cardIcon = 'images/massage.svg';
                  }
                  break;
                case 'Fitness':
                  {
                    colorPosition = 3;
                    cardIcon = 'images/sport.svg';
                  }
                  break;
                case 'Stiching':
                  {
                    colorPosition = 4;
                    cardIcon = 'images/stiching.svg';
                  }
                  break;
                case 'Electronics':
                  {
                    colorPosition = 5;
                    cardIcon = 'images/tv.svg';
                  }
                  break;
                default:
                  colorPosition = 0;
              }
            });
          },
          child: Column(
            children: <Widget>[
              Text(
                category,
                style: TextStyle(
                  color: _isSelected ? Color(0xFF2f0d72) : Colors.grey,
                  fontSize: _isSelected ? 15 : 14,
                  fontFamily: "Poppins-Medium",
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeHorizontal * 2,
              ),
              _isSelected
                  ? Container(
                      decoration: CircleTabIndicator(
                          color: Color(0xFF260b5d), radius: 3.0),
                    )
                  : Container(),
            ],
          ),
        ),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    colorPosition = 0;
    cardIcon = 'images/scissors.svg';
    categoryName = 'Salon';
    getLocation();
  }

  void getLocation() async {
    currentLocation = await location.getLastKnownLocation();  

    await location.getCurrentLocation();
    print(location.latitude);
    print(location.latitude);
    await location.getAddressFromLatLng(location.latitude, location.longitude);
    print(location.currentAddress);
    setState(() {
      currentLocation = location.currentAddress;
    });
  }

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: images.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    ScreenUtil.instance =
        ScreenUtil(width: 1125, height: 2436, allowFontScaling: true)
          ..init(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            children: <Widget>[
              TopBar(currentAddress: currentLocation ?? 'Location'),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(60),
              left: ScreenUtil().setWidth(70),
            ),
            child: Container(),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(right: 20.0),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _buildServiceCategories(),
            ),
          ),
          CategoryCard(
            sizedBoxHeight: ScreenUtil().setHeight(600),
            bottomPadding: ScreenUtil().setHeight(40),
            containerHeight: ScreenUtil().setHeight(550),
            cardColors: gradientColors[colorPosition],
            cardIcon: cardIcon,
            cardName: categoryName,
            onPressed: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (c, a1, a2) => selectRouteScreen(),
                    transitionsBuilder: (c, anim, a2, child) => FadeTransition(
                      opacity: anim,
                      child: child,
                    ),
                    transitionDuration: Duration(milliseconds: 100),
                  ));
            },
          ),
          Divider(
            color: Colors.black12,
            thickness: SizeConfig.safeBlockHorizontal*2,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Carousel(),
          ),
          // Padding(
          //   padding: EdgeInsets.only(
          //     top: ScreenUtil().setHeight(50),
          //     left: ScreenUtil().setWidth(70),
          //   ),
          //   child: Text('Discover',
          //       style: TextStyle(fontFamily: 'Poppins-Medium', fontSize: 20.0, color: Color(0xFF260b5d))),
          // ),
          // Stack(
          //   children: <Widget>[
          //     CardScrollWidget(currentPage),
          //     Positioned.fill(
          //       child: PageView.builder(
          //         itemCount: images.length,
          //         controller: controller,
          //         reverse: true,
          //         itemBuilder: (context, index) {
          //           return InkWell(
          //             onTap: () {
          //               Navigator.push(
          //                   context,
          //                   PageRouteBuilder(
          //                     pageBuilder: (c, a1, a2) =>
          //                         selectRouteInStack(index),
          //                     transitionsBuilder: (c, anim, a2, child) =>
          //                         FadeTransition(
          //                       opacity: anim,
          //                       child: child,
          //                     ),
          //                     transitionDuration: Duration(milliseconds: 100),
          //                   ));
          //             },
          //             child: Container(),
          //           );
          //         },
          //       ),
          //     )
          //   ],
          // ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
        ],
      ),
    );
  }

  void drawerOpen(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  Widget selectRouteScreen() {
    switch (categoryName) {
      case 'Salon':
        return SalonScreen();
      case 'Cleaning':
        return CleaningScreen();
      case 'Stiching':
        return StichingScreen();
      case 'Electronics':
        return ElectronicsScreen();
      default:
        return null;
    }
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

class CardScrollWidget extends StatelessWidget {
  final currentPage;
  final padding = 20.0;
  final padding1 = 10.0;
  final verticalInset = 20.0;

  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, constraints) {
        var width = constraints.maxWidth;
        var height = constraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = List();

        for (var i = 0; i < images.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0)
                ]),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.asset(images[i], fit: BoxFit.cover),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: Text(
                                title[i],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontFamily: 'Raleway'),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, bottom: 12.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 22.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                    color: Color(0xFFee7f77),
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Text(
                                  'Know More',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}
