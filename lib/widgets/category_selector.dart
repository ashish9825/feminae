import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategorySelector extends StatefulWidget {
  final List<String> categories;
  final Function onTapFunction;
  CategorySelector({@required this.categories, this.onTapFunction});
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int _currentIndex = 0;
  bool _isSelected;

  List<Widget> _buildServiceCategories() {
    return widget.categories.map((category) {
      var index = widget.categories.indexOf(category);
      _isSelected = _currentIndex == index;
      return Padding(
        padding: EdgeInsets.only(left: ScreenUtil().setWidth(75)),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _currentIndex = index;
            });
          },
          child: Text(category,
              style: TextStyle(
                  color: _isSelected ? Colors.black : Colors.grey,
                  fontSize: _isSelected ? 22 : 16,
                  fontFamily: "Poppins-Medium",
                  fontWeight: FontWeight.w600)),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(right: 20.0),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _buildServiceCategories(),
      ),
    );
  }
}
