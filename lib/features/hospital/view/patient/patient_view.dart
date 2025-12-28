import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../model/patient_model.dart';
import '../../view_model/patient_view_model.dart';
import '../widgets/patient_tile.dart';
import '../widgets/status_badge.dart';

class PatientView extends StatelessWidget {
  const PatientView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PatientViewModel>();
    final isMobile = MediaQuery.of(context).size.width < 800;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Patient Management',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showAddPatientDialog(context, viewModel),
                icon: const Icon(Icons.add),
                label: const Text('Add Patient'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingLarge),
          // Patient List
          if (isMobile)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: AppDimensions.paddingMedium,
                mainAxisSpacing: AppDimensions.paddingMedium,
                childAspectRatio: 1.2,
              ),
              itemCount: viewModel.patients.length,
              itemBuilder: (context, index) {
                final patient = viewModel.patients[index];
                return TweenAnimationBuilder<double>(
                  duration: Duration(milliseconds: 300 + (index * 50)),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: PatientTile(patient: patient),
                );
              },
            )
          else
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Table(
                border:
                    TableBorder.all(color: const Color(0xFFE5E7EB), width: 1),
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1.5),
                  2: FlexColumnWidth(2),
                  3: FlexColumnWidth(2),
                  4: FlexColumnWidth(1.5),
                  5: FlexColumnWidth(1),
                  6: FlexColumnWidth(1.5),
                },
                children: [
                  TableRow(
                    decoration: const BoxDecoration(color: Color(0xFFF9FAFB)),
                    children: [
                      _buildTableHeader('ID'),
                      _buildTableHeader('Date'),
                      _buildTableHeader('Name'),
                      _buildTableHeader('Doctor'),
                      _buildTableHeader('Department'),
                      _buildTableHeader('Room'),
                      _buildTableHeader('Status'),
                    ],
                  ),
                  ...viewModel.patients.map((patient) {
                    return TableRow(
                      children: [
                        _buildTableCell(patient.id),
                        _buildTableCell(
                            DateFormat('MMM dd').format(patient.date)),
                        _buildTableCell(patient.name),
                        _buildTableCell(patient.doctorName),
                        _buildTableCell(patient.alignment),
                        _buildTableCell(patient.roomNumber),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: StatusBadge(status: patient.status),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          if (viewModel.patients.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  'No patients yet',
                  style: TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: Color(0xFF374151),
        ),
      ),
    );
  }

  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          color: Color(0xFF6B7280),
        ),
      ),
    );
  }

  Future<void> _showAddPatientDialog(
      BuildContext context, PatientViewModel viewModel) async {
    final nameController = TextEditingController();
    final roomController = TextEditingController();
    String? selectedDoctor;
    String? selectedDepartment;
    PatientStatus selectedStatus = PatientStatus.pending;

    final departments = [
      'Cardiology',
      'Neurology',
      'Pediatrics',
      'Orthopedic',
      'Dermatology',
      'General Medicine',
    ];

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 300),
              tween: Tween(begin: 0.8, end: 1.0),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Opacity(
                    opacity: value,
                    child: child,
                  ),
                );
              },
              child: AlertDialog(
                title: const Text('Add New Patient'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Patient Name *',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: selectedDoctor,
                        decoration: const InputDecoration(
                          labelText: 'Doctor *',
                          border: OutlineInputBorder(),
                        ),
                        items: viewModel.availableDoctors.map((doctor) {
                          return DropdownMenuItem(
                            value: doctor,
                            child: Text(doctor),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDoctor = value;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: selectedDepartment,
                        decoration: const InputDecoration(
                          labelText: 'Department *',
                          border: OutlineInputBorder(),
                        ),
                        items: departments.map((dept) {
                          return DropdownMenuItem(
                            value: dept,
                            child: Text(dept),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDepartment = value;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: roomController,
                        decoration: const InputDecoration(
                          labelText: 'Room Number *',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<PatientStatus>(
                        value: selectedStatus,
                        decoration: const InputDecoration(
                          labelText: 'Status *',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: PatientStatus.pending,
                            child: Text('Pending'),
                          ),
                          DropdownMenuItem(
                            value: PatientStatus.progress,
                            child: Text('In Progress'),
                          ),
                          DropdownMenuItem(
                            value: PatientStatus.complete,
                            child: Text('Complete'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedStatus = value;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty &&
                          selectedDoctor != null &&
                          selectedDepartment != null &&
                          roomController.text.isNotEmpty) {
                        viewModel.addPatient(
                          name: nameController.text,
                          doctorName: selectedDoctor!,
                          alignment: selectedDepartment!,
                          roomNumber: roomController.text,
                          status: selectedStatus,
                        );
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    child: const Text('Add Patient'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
