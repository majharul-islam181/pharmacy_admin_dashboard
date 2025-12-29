import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../model/doctor_model.dart';
import '../../view_model/doctor_view_model.dart';

class DoctorView extends StatelessWidget {
  const DoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DoctorViewModel>();
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFF8FAFC),
            const Color(0xFFEFF6FF).withOpacity(0.3),
          ],
        ),
      ),
      child: Column(
        children: [
          // Premium Header with Add Button and Search
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                // Premium Add New Button with gradient
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF14B8A6), Color(0xFF0D9488)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF14B8A6).withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text(
                      AppStrings.buttonAddNew,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                  ),
                ),
                const Spacer(),
                // Premium Search Field with glass effect
                Container(
                  width: isMobile ? 200 : 320,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFE2E8F0),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    onChanged: viewModel.searchDoctors,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF1E293B),
                    ),
                    decoration: InputDecoration(
                      hintText: AppStrings.hintSearchHere,
                      hintStyle: TextStyle(
                        color: const Color(0xFF94A3B8).withOpacity(0.8),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: Color(0xFF64748B),
                        size: 22,
                      ),
                      suffixIcon: viewModel.searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.close, size: 18),
                              onPressed: viewModel.clearSearch,
                              color: const Color(0xFF64748B),
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                // Premium Avatar with gradient border
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFEF4444).withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          // Premium Doctor Table
          Expanded(
            child: viewModel.doctors.isEmpty
                ? _buildEmptyState()
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 24,
                            offset: const Offset(0, 4),
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Premium Table Header with gradient
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFFF8FAFC),
                                  const Color(0xFFF1F5F9).withOpacity(0.8),
                                ],
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                              border: const Border(
                                bottom: BorderSide(
                                  color: Color(0xFFE2E8F0),
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Table(
                              columnWidths: const {
                                0: FlexColumnWidth(2.5),
                                1: FlexColumnWidth(1.5),
                                2: FlexColumnWidth(2),
                                3: FlexColumnWidth(1.8),
                                4: FlexColumnWidth(1.5),
                                5: FlexColumnWidth(1.5),
                                6: FlexColumnWidth(0.8),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    _buildTableHeader('Doctor Name'),
                                    _buildTableHeader('Date Join'),
                                    _buildTableHeader('Specialist'),
                                    _buildTableHeader('Schedule'),
                                    _buildTableHeader('Contact'),
                                    _buildTableHeader('Status'),
                                    _buildTableHeader(''),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Table Rows
                          ...viewModel.doctors.asMap().entries.map((entry) {
                            return _buildDoctorRow(entry.value, entry.key);
                          }),
                        ],
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: Color(0xFF475569),
              letterSpacing: 0.3,
            ),
          ),
          if (text.isNotEmpty) const SizedBox(width: 6),
          if (text.isNotEmpty)
            Icon(
              Icons.unfold_more_rounded,
              size: 18,
              color: const Color(0xFF94A3B8).withOpacity(0.7),
            ),
        ],
      ),
    );
  }

  Widget _buildDoctorRow(DoctorModel doctor, int index) {
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
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: const Color(0xFFE2E8F0).withOpacity(0.6),
              width: 1,
            ),
          ),
        ),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(2.5),
              1: FlexColumnWidth(1.5),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(1.8),
              4: FlexColumnWidth(1.5),
              5: FlexColumnWidth(1.5),
              6: FlexColumnWidth(0.8),
            },
            children: [
              TableRow(
                children: [
                  _buildDoctorNameCell(doctor),
                  _buildTableCell(
                    DateFormat('dd/MM/yyyy, hh:mm a').format(doctor.dateOfJoin),
                  ),
                  _buildTableCell(doctor.specialist),
                  _buildScheduleCell(doctor),
                  _buildTableCell(doctor.contactNumber),
                  _buildStatusCell(doctor.status),
                  _buildActionsCell(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  //         ],
  //       ),
  //     ],
  //   ),
  // );
}

Widget _buildDoctorNameCell(DoctorModel doctor) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    child: Row(
      children: [
        // Premium Avatar with shadow
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFEF4444).withOpacity(0.25),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
            image: doctor.avatarUrl.isNotEmpty &&
                    doctor.avatarUrl.startsWith('http')
                ? DecorationImage(
                    image: NetworkImage(doctor.avatarUrl),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: !doctor.avatarUrl.startsWith('http')
              ? Center(
                  child: Text(
                    doctor.name.split(' ').map((e) => e[0]).take(2).join(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              : null,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            doctor.name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
              letterSpacing: 0.1,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTableCell(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        color: Color(0xFF64748B),
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget _buildScheduleCell(DoctorModel doctor) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        gradient: doctor.appointmentCount > 0
            ? LinearGradient(
                colors: [
                  const Color(0xFFD1FAE5),
                  const Color(0xFFD1FAE5).withOpacity(0.8),
                ],
              )
            : null,
        color: doctor.appointmentCount == 0 ? const Color(0xFFF1F5F9) : null,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: doctor.appointmentCount > 0
              ? const Color(0xFF10B981)
              : const Color(0xFFCBD5E1),
          width: 1.5,
        ),
        boxShadow: doctor.appointmentCount > 0
            ? [
                BoxShadow(
                  color: const Color(0xFF10B981).withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Text(
        doctor.scheduleStatus,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: doctor.appointmentCount > 0
              ? const Color(0xFF047857)
              : const Color(0xFF64748B),
          letterSpacing: 0.2,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget _buildStatusCell(DoctorStatus status) {
  final isAvailable = status == DoctorStatus.available;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        gradient: isAvailable
            ? LinearGradient(
                colors: [
                  const Color(0xFFD1FAE5),
                  const Color(0xFFD1FAE5).withOpacity(0.8),
                ],
              )
            : LinearGradient(
                colors: [
                  const Color(0xFFFEE2E2),
                  const Color(0xFFFEE2E2).withOpacity(0.8),
                ],
              ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: isAvailable
                ? const Color(0xFF10B981).withOpacity(0.15)
                : const Color(0xFFEF4444).withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        isAvailable ? 'Available' : 'Unavailable',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color:
              isAvailable ? const Color(0xFF047857) : const Color(0xFF991B1B),
          letterSpacing: 0.2,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget _buildActionsCell() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    child: Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: PopupMenuButton(
        icon: const Icon(
          Icons.more_horiz_rounded,
          color: Color(0xFF64748B),
          size: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.1),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 'view',
            height: 44,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.visibility_outlined,
                    size: 16,
                    color: Color(0xFF3B82F6),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'View',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'edit',
            height: 44,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.edit_outlined,
                    size: 16,
                    color: Color(0xFF10B981),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Edit',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'delete',
            height: 44,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.delete_outline,
                    size: 16,
                    color: Color(0xFFEF4444),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Delete',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFEF4444),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildEmptyState() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Color(0xFFF1F5F9),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.medical_services_outlined,
            size: 64,
            color: Color(0xFF94A3B8),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'No doctors found',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF475569),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Try adjusting your search',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF94A3B8),
          ),
        ),
      ],
    ),
  );
}
// }
