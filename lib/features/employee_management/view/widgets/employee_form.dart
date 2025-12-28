import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/employee_model.dart';

class EmployeeForm extends StatefulWidget {
  final EmployeeModel? employee;
  final Function(EmployeeModel) onSubmit;

  const EmployeeForm({
    super.key,
    this.employee,
    required this.onSubmit,
  });

  @override
  State<EmployeeForm> createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _designationController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  DateTime? _joiningDate;
  EmployeeDepartment _department = EmployeeDepartment.pharmacy;
  EmployeeStatus _status = EmployeeStatus.active;
  String _avatarUrl = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.employee?.name ?? '');
    _designationController =
        TextEditingController(text: widget.employee?.designation ?? '');
    _phoneController =
        TextEditingController(text: widget.employee?.phone ?? '');
    _emailController =
        TextEditingController(text: widget.employee?.email ?? '');
    _joiningDate = widget.employee?.joiningDate ?? DateTime.now();
    _department = widget.employee?.department ?? EmployeeDepartment.pharmacy;
    _status = widget.employee?.status ?? EmployeeStatus.active;
    _avatarUrl = widget.employee?.avatarUrl ??
        'https://i.pravatar.cc/150?img=${DateTime.now().millisecond % 70}';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _designationController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar Section
            Center(
              child: Column(
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
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(_avatarUrl),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _avatarUrl =
                            'https://i.pravatar.cc/150?img=${DateTime.now().millisecond % 70}';
                      });
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Change Avatar'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Name Field
            _buildTextField(
              controller: _nameController,
              label: 'Full Name',
              icon: Icons.person_outline,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter employee name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // Designation Field
            _buildTextField(
              controller: _designationController,
              label: 'Designation',
              icon: Icons.work_outline,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter designation';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // Phone Field
            _buildTextField(
              controller: _phoneController,
              label: 'Mobile Number',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter phone number';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // Email Field
            _buildTextField(
              controller: _emailController,
              label: 'Email Address',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter email address';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // Department Dropdown
            _buildDropdownField<EmployeeDepartment>(
              value: _department,
              label: 'Department',
              icon: Icons.business_outlined,
              items: EmployeeDepartment.values,
              itemLabel: (dept) {
                switch (dept) {
                  case EmployeeDepartment.sales:
                    return 'Sales';
                  case EmployeeDepartment.pharmacy:
                    return 'Pharmacy';
                  case EmployeeDepartment.operations:
                    return 'Operations';
                  case EmployeeDepartment.management:
                    return 'Management';
                  case EmployeeDepartment.support:
                    return 'Support';
                }
              },
              onChanged: (value) => setState(() => _department = value!),
            ),
            const SizedBox(height: 20),

            // Status Dropdown
            _buildDropdownField<EmployeeStatus>(
              value: _status,
              label: 'Status',
              icon: Icons.check_circle_outline,
              items: EmployeeStatus.values,
              itemLabel: (status) =>
                  status == EmployeeStatus.active ? 'Active' : 'Inactive',
              onChanged: (value) => setState(() => _status = value!),
            ),
            const SizedBox(height: 20),

            // Joining Date Picker
            _buildDateField(),
            const SizedBox(height: 32),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  shadowColor: const Color(0xFF6366F1).withOpacity(0.4),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        widget.employee == null
                            ? 'Add Employee'
                            : 'Update Employee',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF6366F1)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEF4444)),
        ),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
      ),
    );
  }

  Widget _buildDropdownField<T>({
    required T value,
    required String label,
    required IconData icon,
    required List<T> items,
    required String Function(T) itemLabel,
    required void Function(T?) onChanged,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF6366F1)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
        ),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
      ),
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(itemLabel(item)),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildDateField() {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: _joiningDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
        if (date != null) {
          setState(() => _joiningDate = date);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Joining Date',
          prefixIcon: const Icon(Icons.calendar_today_outlined,
              color: Color(0xFF6366F1)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          filled: true,
          fillColor: const Color(0xFFF8FAFC),
        ),
        child: Text(
          _joiningDate != null
              ? DateFormat('dd MMM yyyy').format(_joiningDate!)
              : 'Select Date',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 800));

      final employee = EmployeeModel(
        id: widget.employee?.id ??
            'EMP${DateTime.now().millisecondsSinceEpoch}',
        name: _nameController.text,
        designation: _designationController.text,
        phone: _phoneController.text,
        email: _emailController.text,
        joiningDate: _joiningDate!,
        avatarUrl: _avatarUrl,
        department: _department,
        status: _status,
      );

      widget.onSubmit(employee);

      setState(() => _isLoading = false);
    }
  }
}
