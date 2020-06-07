import 'package:feminae/bloc/facility_service_bloc.dart';
import 'package:feminae/model/facility_service_response.dart';
import 'package:feminae/model/facility_services.dart';
import 'package:feminae/utils/size_config.dart';
import 'package:feminae/widgets/error_widget.dart';
import 'package:feminae/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class DetailsPage extends StatefulWidget {
  final int tabPosition;
  DetailsPage(this.tabPosition);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
    servicesBloc.getFacilityServices(widget.tabPosition);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return StreamBuilder<FacilityServiceResponse>(
      stream: servicesBloc.subject.stream,
      builder: (context, AsyncSnapshot<FacilityServiceResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return FeminaeError(snapshot.data.error);
          }
          return _buildFacilitiesWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return FeminaeError(snapshot.data.error);
        } else {
          return FeminaeLoading();
        }
      },
    );
  }

  Widget _buildFacilitiesWidget(FacilityServiceResponse data) {
    return ListView(
      children: data.services.map((f) => listTile(f)).toList(),
    );
  }

  Widget listTile(FacilityServices services) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
      child: Container(
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                color: Color(0xFFFFF1EE),
                width: SizeConfig.blockSizeHorizontal * 15,
                height: SizeConfig.blockSizeHorizontal * 15,
                child: Icon(
                  AntDesign.jpgfile1,
                  size: SizeConfig.blockSizeHorizontal * 7,
                  color: Color(0xFFFF7852),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    services.facilityName,
                    style: TextStyle(
                        fontFamily: 'Poppins-Medium',
                        fontSize: 16.0,
                        color: Color(0xFF3F2770)),
                  ),
                  Text(
                    '₹${services.facilityPrice}',
                    style: TextStyle(
                        fontFamily: 'Poppins-Medium', color: Color(0xFF000000)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }
}
