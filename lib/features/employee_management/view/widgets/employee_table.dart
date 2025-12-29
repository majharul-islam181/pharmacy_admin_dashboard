import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_strings.dart';
import '../../model/employee_model.dart';

class EmployeeTable extends StatelessWidget {
  final List<EmployeeModel> employees;
  final Function(EmployeeModel) onEdit;
  final Function(String) onDelete;

  const EmployeeTable({
    super.key,
    required this.employees,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF1F5F9), Color(0xFFE2E8F0)],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: const Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    AppStrings.menuEmployee,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E293B),
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Designation',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E293B),
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Contact',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E293B),
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Department',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E293B),
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Joining Date',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E293B),
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Status',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E293B),
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    'Actions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E293B),
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Rows
          ...List.generate(employees.length, (index) {
            return TweenAnimationBuilder<double>(
              key: ValueKey(employees[index].id),
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 200 + index * 30),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(20 * (1 - value), 0),
                    child: child,
                  ),
                );
              },
              child: _EmployeeRow(
                employee: employees[index],
                onEdit: () => onEdit(employees[index]),
                onDelete: () => onDelete(employees[index].id),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _EmployeeRow extends StatefulWidget {
  final EmployeeModel employee;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _EmployeeRow({
    required this.employee,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<_EmployeeRow> createState() => _EmployeeRowState();
}

class _EmployeeRowState extends State<_EmployeeRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: _isHovered ? const Color(0xFFF8FAFC) : Colors.white,
          border: Border(
            bottom: BorderSide(
              color: const Color(0xFFE2E8F0).withOpacity(0.5),
            ),
          ),
        ),
        child: Row(
          children: [
            // Employee Info
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6366F1).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(widget.employee.avatarUrl),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.employee.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        Text(
                          widget.employee.id,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Designation
            Expanded(
              flex: 2,
              child: Text(
                widget.employee.designation,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF475569),
                ),
              ),
            ),
            // Contact
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.employee.phone,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF475569),
                    ),
                  ),
                  Text(
                    widget.employee.email,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            // Department
            Expanded(
              flex: 2,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getDepartmentColor(widget.employee.department)
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.employee.departmentName,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getDepartmentColor(widget.employee.department),
                  ),
                ),
              ),
            ),
            // Joining Date
            Expanded(
              flex: 2,
              child: Text(
                DateFormat('dd MMM yyyy').format(widget.employee.joiningDate),
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF475569),
                ),
              ),
            ),
            // Status
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: widget.employee.status == EmployeeStatus.active
                        ? const LinearGradient(
                            colors: [Color(0xFF10B981), Color(0xFF059669)])
                        : const LinearGradient(
                            colors: [Color(0xFF64748B), Color(0xFF475569)]),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: (widget.employee.status == EmployeeStatus.active
                                ? const Color(0xFF10B981)
                                : const Color(0xFF64748B))
                            .withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    widget.employee.statusName,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            // Actions
            SizedBox(
              width: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 18),
                    color: const Color(0xFF6366F1),
                    onPressed: widget.onEdit,
                    tooltip: AppStrings.buttonEdit,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 18),
                    color: const Color(0xFFEF4444),
                    onPressed: widget.onDelete,
                    tooltip: AppStrings.buttonDelete,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getDepartmentColor(EmployeeDepartment department) {
    switch (department) {
      case EmployeeDepartment.sales:
        return const Color(0xFF3B82F6);
      case EmployeeDepartment.pharmacy:
        return const Color(0xFF10B981);
      case EmployeeDepartment.operations:
        return const Color(0xFFF59E0B);
      case EmployeeDepartment.management:
        return const Color(0xFF8B5CF6);
      case EmployeeDepartment.support:
        return const Color(0xFFEC4899);
    }
  }
}
