import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../model/patient_model.dart';
import 'status_badge.dart';

class PatientTile extends StatelessWidget {
  final PatientModel patient;
  final VoidCallback? onTap;

  const PatientTile({
    super.key,
    required this.patient,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        child: Container(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE5E7EB)),
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    patient.id,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  StatusBadge(status: patient.status),
                ],
              ),
              const SizedBox(height: AppDimensions.paddingSmall),
              _buildInfoRow(Icons.person, patient.name),
              _buildInfoRow(Icons.medical_services, patient.doctorName),
              _buildInfoRow(Icons.business, patient.alignment),
              _buildInfoRow(Icons.room, 'Room ${patient.roomNumber}'),
              _buildInfoRow(
                Icons.calendar_today,
                DateFormat('MMM dd, yyyy').format(patient.date),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          Icon(
            icon,
            size: 14,
            color: const Color(0xFF9CA3AF),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF6B7280),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
