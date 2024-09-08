import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/data/repositories/background_location_repository_impl.dart';
import 'package:geotrackr/data/services/background_location_service.dart';
import 'package:geotrackr/domain/entities/location.dart';
import 'package:geotrackr/domain/use_cases/start_background_location_service.dart';
import 'package:geotrackr/domain/use_cases/stop_background_location_service.dart';
import 'package:geotrackr/presentation/blocs/background_location_bloc.dart';
import 'package:geotrackr/presentation/widgets/geotrackr_app_bar.dart';
import 'package:geotrackr/presentation/widgets/geotrackr_drawer.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: GeoTrackrDrawer(),
      body: BlocProvider(
        create: (context) => BackgroundLocationBloc(
          startBackgroundLocationService: StartBackgroundLocationService(
              BackgroundLocationRepositoryImpl()),
          stopBackgroundLocationService:
              StopBackgroundLocationService(BackgroundLocationRepositoryImpl()),
          backgroundLocationService:
              BackgroundLocationService(BackgroundLocationRepositoryImpl()),
        ),
        child: LocationView(),
      ),
    );
  }
}

class LocationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<BackgroundLocationBloc, BackgroundLocationState>(
            builder: (context, state) {
              if (state is BackgroundLocationInitial) {
                return Text('Press the button to start location service');
              } else if (state is BackgroundLocationLoading) {
                return CircularProgressIndicator();
              } else if (state is BackgroundLocationServiceStarted) {
                return Text('Location service started');
              } else if (state is BackgroundLocationServiceStopped) {
                return Text('Location service stopped');
              } else if (state is BackgroundLocationError) {
                return Text('Error: ${state.message}');
              }
              return Container();
            },
          ),
          // Display current location
          Container(
            height: 200,
            width: 200,
            child: Center(
              child:
                  BlocBuilder<BackgroundLocationBloc, BackgroundLocationState>(
                builder: (context, state) {
                  if (state is BackgroundLocationServiceStarted ||
                      state is BackgroundLocationUpdated) {
                    return StreamBuilder<Location>(
                      stream:
                          context.read<BackgroundLocationBloc>().locationStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final location = snapshot.data!;
                          return Text(
                              'Lat: ${location.latitude}, Long: ${location.longitude}');
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Text('No location data');
                        }
                      },
                    );
                  } else {
                    return Text('Location service not started');
                  }
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context
                  .read<BackgroundLocationBloc>()
                  .add(StartBackgroundLocationServiceEvent());
            },
            child: Text('Start Location Service'),
          ),
          ElevatedButton(
            onPressed: () {
              context
                  .read<BackgroundLocationBloc>()
                  .add(StopBackgroundLocationServiceEvent());
            },
            child: Text('Stop Location Service'),
          ),
        ],
      ),
    );
  }
}
