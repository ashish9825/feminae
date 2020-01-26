import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:feminae/utils/app_style.dart';

List<Color> cardColorsList;

class CategoryCard extends StatefulWidget {
  final double sizedBoxHeight;
  final double bottomPadding;
  final double containerHeight;
  final cardColors;
  final String cardIcon;
  final String cardName;
  final Function onPressed;

  CategoryCard(
      {this.sizedBoxHeight,
      this.bottomPadding,
      this.containerHeight,
      this.cardColors,
      this.cardIcon,
      this.cardName,
      this.onPressed});

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: SizedBox(
        height: widget.sizedBoxHeight,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: widget.bottomPadding),
                  child: Container(
                    height: widget.containerHeight,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: widget.cardColors,
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 8),
                            blurRadius: 8),
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: SvgPicture.asset(
                          widget.cardIcon,
                          width: ScreenUtil().setWidth(200),
                          height: ScreenUtil().setHeight(200),
                        ),
                      ),
                      Text(
                        widget.cardName,
                        style: cardTextStyle,
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
