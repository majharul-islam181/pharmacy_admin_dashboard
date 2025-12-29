import 'package:flutter/material.dart';
import '../../model/attendance_model.dart';
import '../../../../core/constants/app_colors.dart';

class FilterPanel extends StatelessWidget {
  final String searchQuery;
  final Function(String) onSearchChanged;
  final String? selectedDepartment;
  final List<String> departments;
  final Function(String?) onDepartmentChanged;
  final AttendanceStatus? selectedStatus;
  final Function(AttendanceStatus?) onStatusChanged;
  final VoidCallback onClearFilters;

  const FilterPanel({
    super.key,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.selectedDepartment,
    required this.departments,
    required this.onDepartmentChanged,
    required this.selectedStatus,
    required this.onStatusChanged,
    required this.onClearFilters,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:  AppColors.borderLight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildSearchField(),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildDepartmentFilter()),
            const SizedBox(width: 8),
            Expanded(child: _buildStatusFilter()),
          ],
        ),
        const SizedBox(height: 12),
        _buildClearButton(),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(flex: 3, child: _buildSearchField()),
        const SizedBox(width: 12),
        Expanded(flex: 2, child: _buildDepartmentFilter()),
        const SizedBox(width: 12),
        Expanded(flex: 2, child: _buildStatusFilter()),
        const SizedBox(width: 12),
        _buildClearButton(),
      ],
    );
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:  AppColors.borderLight,
        ),
      ),
      child: TextField(
        onChanged: onSearchChanged,
        decoration: InputDecoration(
          hintText: 'Search by name or ID...',
          hintStyle: const TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 14,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.gray500,
            size: 20,
          ),
          suffixIcon: searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 18),
                  onPressed: () => onSearchChanged(''),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildDepartmentFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:  AppColors.borderLight,
        ),
      ),
      child: DropdownButton<String>(
        value: selectedDepartment,
        isExpanded: true,
        underline: const SizedBox(),
        hint: const Text(
          'All Departments',
          style: TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 14,
          ),
        ),
        icon: const Icon(Icons.arrow_drop_down, color: AppColors.gray500),
        items: [
          const DropdownMenuItem<String>(
            value: null,
            child: Text('All Departments'),
          ),
          ...departments.map((dept) {
            return DropdownMenuItem<String>(
              value: dept,
              child: Text(dept),
            );
          }),
        ],
        onChanged: onDepartmentChanged,
      ),
    );
  }

  Widget _buildStatusFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:  AppColors.borderLight,
        ),
      ),
      child: DropdownButton<AttendanceStatus>(
        value: selectedStatus,
        isExpanded: true,
        underline: const SizedBox(),
        hint: const Text(
          'All Status',
          style: TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 14,
          ),
        ),
        icon: const Icon(Icons.arrow_drop_down, color: AppColors.gray500),
        items: [
          const DropdownMenuItem<AttendanceStatus>(
            value: null,
            child: Text('All Status'),
          ),
          ...AttendanceStatus.values.map((status) {
            return DropdownMenuItem<AttendanceStatus>(
              value: status,
              child:
                  Text(status.name[0].toUpperCase() + status.name.substring(1)),
            );
          }),
        ],
        onChanged: onStatusChanged,
      ),
    );
  }

  Widget _buildClearButton() {
    return ElevatedButton.icon(
      onPressed: onClearFilters,
      icon: const Icon(Icons.filter_alt_off, size: 18),
      label: const Text('Clear'),
      style: ElevatedButton.styleFrom(
        backgroundColor:  AppColors.errorDark,
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
      ),
    );
  }
}
