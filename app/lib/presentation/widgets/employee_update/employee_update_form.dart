import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/presentation/blocs/employee/employee_update_bloc.dart';
import 'package:geotrackr/presentation/widgets/custom_button.dart';
import 'package:geotrackr/presentation/widgets/labeled_input.dart';

/// The [EmployeeUpdateForm] widget is a stateful widget that represents the form for updating employee details.
/// It uses the Bloc pattern to manage the state of the employee update process.
class EmployeeUpdateForm extends StatefulWidget {
  @override
  _EmployeeUpdateFormState createState() => _EmployeeUpdateFormState();
}

class _EmployeeUpdateFormState extends State<EmployeeUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            LabeledInput(
              label: 'Name',
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            LabeledInput(
              label: 'Email',
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            LabeledInput(
              label: 'Contact Number',
              controller: _contactNumberController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a contact number';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: "Update Employee",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<EmployeeUpdateBloc>(context).add(
                      EmployeeUpdate(
                        employeeName: _nameController.text,
                        employeeEmail: _emailController.text,
                        employeeContactNumber: _contactNumberController.text,
                      ),
                    );
                  }
                },
              ),
            ),
            BlocBuilder<EmployeeUpdateBloc, EmployeeUpdateState>(
              builder: (context, state) {
                if (state is EmployeeUpdateLoading) {
                  return const CircularProgressIndicator();
                } else if (state is EmployeeUpdateLoaded) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushNamed(context, '/home');
                  });
                  return Container();
                } else if (state is EmployeeUpdateError) {
                  print('Error: ${state.message}');
                  return Text('Error: ${state.message}');
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
