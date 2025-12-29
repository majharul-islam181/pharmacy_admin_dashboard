import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../view_model/employee_view_model.dart';
import '../model/employee_model.dart';
import 'widgets/employee_table.dart';
import 'widgets/employee_card.dart';
import 'widgets/employee_search_bar.dart';
import 'widgets/employee_pagination_widget.dart';

class EmployeeListView extends StatelessWidget {
  const EmployeeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeViewModel>(
      builder: (context, viewModel, child) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF8FAFC), Color(0xFFE2E8F0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 600),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(-20 * (1 - value), 0),
                            child: child,
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF6366F1),
                                      Color(0xFF8B5CF6)
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF6366F1)
                                          .withOpacity(0.3),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.people_outline,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 16),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppStrings.pageEmployeeManagement,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF1E293B),
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    AppStrings.descManageTeamMembers,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          ElevatedButton.icon(
                            onPressed: () => context.go('/employee/add'),
                            icon: const Icon(Icons.add, size: 20),
                            label: const Text(AppStrings.buttonAddEmployee),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6366F1),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                              shadowColor:
                                  const Color(0xFF6366F1).withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Search Bar
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 700),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, 20 * (1 - value)),
                            child: child,
                          ),
                        );
                      },
                      child: EmployeeSearchBar(
                        searchQuery: viewModel.searchQuery,
                        onSearchChanged: viewModel.searchEmployees,
                        onClearSearch: viewModel.clearSearch,
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isDesktop = constraints.maxWidth > 800;

                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          if (viewModel.employees.isEmpty)
                            _buildEmptyState()
                          else if (isDesktop)
                            TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0.0, end: 1.0),
                              duration: const Duration(milliseconds: 800),
                              builder: (context, value, child) {
                                return Opacity(
                                  opacity: value,
                                  child: Transform.translate(
                                    offset: Offset(0, 30 * (1 - value)),
                                    child: child,
                                  ),
                                );
                              },
                              child: EmployeeTable(
                                employees: viewModel.employees,
                                onEdit: (employee) =>
                                    _handleEdit(context, employee),
                                onDelete: (id) =>
                                    _handleDelete(context, viewModel, id),
                              ),
                            )
                          else
                            Column(
                              children: List.generate(
                                viewModel.employees.length,
                                (index) => EmployeeCard(
                                  employee: viewModel.employees[index],
                                  index: index,
                                  onTap: () {},
                                  onEdit: () => _handleEdit(
                                      context, viewModel.employees[index]),
                                  onDelete: () => _handleDelete(context,
                                      viewModel, viewModel.employees[index].id),
                                ),
                              ),
                            ),
                          const SizedBox(height: 16),
                          if (viewModel.employees.isNotEmpty)
                            TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0.0, end: 1.0),
                              duration: const Duration(milliseconds: 900),
                              builder: (context, value, child) {
                                return Opacity(
                                  opacity: value,
                                  child: child,
                                );
                              },
                              child: EmployeePaginationWidget(
                                currentPage: viewModel.currentPage,
                                totalPages: viewModel.totalPages,
                                pageSize: viewModel.pageSize,
                                totalRecords: viewModel.totalRecords,
                                onPageChanged: viewModel.changePage,
                                onPageSizeChanged: viewModel.changePageSize,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6366F1).withOpacity(0.3),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                Icons.search_off,
                size: 56,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No employees found',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Try adjusting your search to find what you\'re looking for',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleEdit(BuildContext context, EmployeeModel employee) {
    context.go('/employee/edit/${employee.id}');
  }

  void _handleDelete(
      BuildContext context, EmployeeViewModel viewModel, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(AppStrings.messageDeleteEmployee),
        content: const Text(AppStrings.messageDeleteEmployeeConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(AppStrings.buttonCancel),
          ),
          ElevatedButton(
            onPressed: () {
              viewModel.deleteEmployee(id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Employee deleted successfully'),
                  backgroundColor: Color(0x0010b981),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
            ),
            child: const Text(AppStrings.buttonDelete),
          ),
        ],
      ),
    );
  }
}
