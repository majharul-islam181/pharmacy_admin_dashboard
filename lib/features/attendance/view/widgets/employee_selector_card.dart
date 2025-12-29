import 'package:flutter/material.dart';
import '../../view_model/employee_attendance_view_model.dart';
import '../../../../core/constants/app_colors.dart';

class EmployeeSelectorCard extends StatelessWidget {
  final EmployeeAttendanceViewModel viewModel;

  const EmployeeSelectorCard({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Employee',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: viewModel.selectedEmployee?.id,
            decoration: InputDecoration(
              hintText: 'Choose an employee',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.borderLight),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.borderLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: Color(0xFF14B8A6), width: 2),
              ),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
            ),
            items: viewModel.employees.map((employee) {
              return DropdownMenuItem(
                value: employee.id,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(employee.avatarUrl),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          employee.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          employee.department,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.gray500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (id) {
              if (id != null) {
                final employee = viewModel.employees.firstWhere(
                  (e) => e.id == id,
                );
                viewModel.selectEmployee(employee);
              }
            },
          ),
        ],
      ),
    );
  }
}
