import 'package:flutter/material.dart';
import 'package:geotrackr/presentation/widgets/geotrackr_app_bar.dart';
import 'package:geotrackr/presentation/widgets/geotrackr_drawer.dart';
import 'package:geotrackr/utils/custom_color.dart'; // Import the custom app bar

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDarkMode ? CustomColor.darkTextColor : CustomColor.lightTextColor;
    final backgroundColor = isDarkMode
        ? CustomColor.darkBackgroundColor
        : CustomColor.lightBackgroundColor;

    return Scaffold(
      appBar: const GeoTrackrAppBar(),
      drawer: const SafeArea(
        top: true,
        child: GeoTrackrDrawer(),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(
                  title: Text('Item #$index'),
                ),
                childCount: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
