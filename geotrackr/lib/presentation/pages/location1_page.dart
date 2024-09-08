import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/repositories/office_repository_impl.dart';
import 'package:geotrackr/domain/use_cases/get_office.dart';
import 'package:geotrackr/presentation/blocs/office_bloc.dart';
import 'package:geotrackr/layout/responsive_layout.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: BlocProvider(
        create: (context) => OfficeBloc(
            GetOffice(OfficeRepositoryImpl('http://localhost:3000'))),
        child: const ResponsiveLayout(
          mobile: MobileLayout(),
          tablet: TabletLayout(),
          desktop: DesktopLayout(),
        ),
      ),
    );
  }
}

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              context.read<OfficeBloc>().fetchOffice('1');
            },
            child: const Text('Fetch Office'),
          ),
          BlocBuilder<OfficeBloc, OfficeState>(
            builder: (context, state) {
              if (state is OfficeLoading) {
                return const CircularProgressIndicator();
              } else if (state is OfficeLoaded) {
                return Text('Office: ${state.office.officeName}');
              } else if (state is OfficeError) {
                return Text('Error: ${state.message}');
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}

class TabletLayout extends StatelessWidget {
  const TabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Tablet Layout'),
    );
  }
}

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Desktop Layout'),
    );
  }
}
