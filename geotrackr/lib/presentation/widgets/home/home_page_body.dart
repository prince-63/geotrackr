import 'package:flutter/material.dart';
import 'package:geotrackr/presentation/widgets/home/calender.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  Widget build(BuildContext context) {
    return Calender();
  }
}
