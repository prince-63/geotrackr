import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/data/repositories/location_repository_impl.dart';
import 'package:geotrackr/domain/use_cases/get_location.dart';
import 'package:geotrackr/presentation/blocs/location_bloc.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location Tracker')),
      body: BlocProvider(
        create: (context) =>
            LocationBloc(GetLocation(LocationRepositoryImpl())),
        child: const LocationView(),
      ),
    );
  }
}

class LocationView extends StatelessWidget {
  const LocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {
              if (state is LocationInitial) {
                return const Text('Press the button to get location');
              } else if (state is LocationLoading) {
                return const CircularProgressIndicator();
              } else if (state is LocationLoaded) {
                return Text(
                    'Location: ${state.location.latitude}, ${state.location.longitude}');
              } else if (state is LocationError) {
                return Text('Error: ${state.message}');
              }
              return Container();
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<LocationBloc>().add(GetLocationEvent());
            },
            child: const Text('Get Location'),
          ),
        ],
      ),
    );
  }
}
