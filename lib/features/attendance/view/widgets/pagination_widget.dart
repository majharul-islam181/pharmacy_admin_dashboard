import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class PaginationWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;
  final int pageSize;
  final Function(int) onPageSizeChanged;
  final int totalRecords;

  const PaginationWidget({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    required this.pageSize,
    required this.onPageSizeChanged,
    required this.totalRecords,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.borderLight,
            width: 1,
          ),
        ),
      ),
      child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildPageInfo(),
        const SizedBox(height: 12),
        _buildPageControls(),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildPageSizeSelector(),
        _buildPageInfo(),
        _buildPageControls(),
      ],
    );
  }

  Widget _buildPageSizeSelector() {
    return Row(
      children: [
        const Text(
          'Show',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.gray500,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color:  AppColors.borderLight,
            ),
          ),
          child: DropdownButton<int>(
            value: pageSize,
            underline: const SizedBox(),
            isDense: true,
            items: [5, 10, 20, 50].map((size) {
              return DropdownMenuItem(
                value: size,
                child: Text(
                  '$size',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) onPageSizeChanged(value);
            },
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          'entries',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.gray500,
          ),
        ),
      ],
    );
  }

  Widget _buildPageInfo() {
    final start = (currentPage - 1) * pageSize + 1;
    final end = (currentPage * pageSize) > totalRecords
        ? totalRecords
        : currentPage * pageSize;

    return Text(
      'Showing $start to $end of $totalRecords entries',
      style: const TextStyle(
        fontSize: 14,
        color: AppColors.gray600,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildPageControls() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildPageButton(
          icon: Icons.chevron_left,
          onTap: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
        ),
        const SizedBox(width: 8),
        ..._buildPageNumbers(),
        const SizedBox(width: 8),
        _buildPageButton(
          icon: Icons.chevron_right,
          onTap: currentPage < totalPages
              ? () => onPageChanged(currentPage + 1)
              : null,
        ),
      ],
    );
  }

  List<Widget> _buildPageNumbers() {
    final pages = <Widget>[];
    final startPage = (currentPage - 2).clamp(1, totalPages);
    final endPage = (currentPage + 2).clamp(1, totalPages);

    if (startPage > 1) {
      pages.add(_buildPageNumberButton(1));
      if (startPage > 2) {
        pages.add(const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Text('...', style: TextStyle(color: AppColors.gray500)),
        ));
      }
    }

    for (int i = startPage; i <= endPage; i++) {
      pages.add(_buildPageNumberButton(i));
    }

    if (endPage < totalPages) {
      if (endPage < totalPages - 1) {
        pages.add(const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Text('...', style: TextStyle(color: AppColors.gray500)),
        ));
      }
      pages.add(_buildPageNumberButton(totalPages));
    }

    return pages;
  }

  Widget _buildPageNumberButton(int page) {
    final isActive = page == currentPage;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: InkWell(
        onTap: () => onPageChanged(page),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            gradient: isActive
                ? const LinearGradient(
                    colors: [Color(0xFF14B8A6), Color(0xFF0D9488)],
                  )
                : null,
            color: isActive ? null : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isActive ? AppColors.transparent :  AppColors.borderLight,
            ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: const Color(0xFF14B8A6).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Text(
            '$page',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isActive ? AppColors.white :  AppColors.gray600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageButton({
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    final isEnabled = onTap != null;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isEnabled ? const Color(0xFFF8FAFC) : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:  AppColors.borderLight,
          ),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isEnabled ?  AppColors.gray600 : const Color(0xFFCBD5E1),
        ),
      ),
    );
  }
}
