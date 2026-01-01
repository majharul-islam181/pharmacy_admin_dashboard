import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../model/review_model.dart';
import '../../view_model/review_view_model.dart';

class ReviewView extends StatelessWidget {
  const ReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ReviewViewModel>();

    return Container(
      color: const Color(0xFFF9FAFB),
      child: Column(
        children: [
          // Status Filter Tabs
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            child: Row(
              children: [
                _buildStatusTab(
                  context,
                  viewModel,
                  ReviewStatus.all,
                  'All Reviews',
                ),
                const SizedBox(width: 12),
                _buildStatusTab(
                  context,
                  viewModel,
                  ReviewStatus.published,
                  'Published',
                ),
                const SizedBox(width: 12),
                _buildStatusTab(
                  context,
                  viewModel,
                  ReviewStatus.deleted,
                  'Deleted',
                ),
              ],
            ),
          ),
          // Review List
          Expanded(
            child: viewModel.reviews.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
                    padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                    itemCount: viewModel.reviews.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final review = viewModel.reviews[index];
                      return _buildReviewCard(context, viewModel, review);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTab(
    BuildContext context,
    ReviewViewModel viewModel,
    ReviewStatus status,
    String label,
  ) {
    final isSelected = viewModel.selectedStatus == status;
    return GestureDetector(
      onTap: () => viewModel.setStatusFilter(status),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF14B8A6) : const Color(0xFFE5E7EB),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF6B7280),
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildReviewCard(
    BuildContext context,
    ReviewViewModel viewModel,
    ReviewModel review,
  ) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 400),
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
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFEF4444),
                  image: review.avatarUrl.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(review.avatarUrl),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: review.avatarUrl.isEmpty
                    ? Center(
                        child: Text(
                          review.patientName[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Name & Stars
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review.patientName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF111827),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    index < review.rating.floor()
                                        ? Icons.star
                                        : Icons.star_border,
                                    size: 16,
                                    color: const Color(0xFFFBBF24),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                        // Actions
                        Row(
                          children: [
                            if (review.status != ReviewStatus.published)
                              _buildActionButton(
                                icon: Icons.upload,
                                label: 'Publish',
                                color: const Color(0xFF14B8A6),
                                onTap: () => viewModel.publishReview(review.id),
                              ),
                            const SizedBox(width: 8),
                            _buildDeleteButton(
                              context,
                              viewModel,
                              review.id,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Date
                    Text(
                      DateFormat('EEEE, dd MMMM yyyy HH:mm')
                          .format(review.date),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF9CA3AF),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Department
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF14B8A6),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        review.department,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Review Text
                    Text(
                      review.reviewText,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4B5563),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteButton(
    BuildContext context,
    ReviewViewModel viewModel,
    String reviewId,
  ) {
    return InkWell(
      onTap: () => _confirmDelete(context, viewModel, reviewId),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFEF4444)),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Icon(
          Icons.delete_outline,
          size: 20,
          color: Color(0xFFEF4444),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.rate_review_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No reviews found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Reviews will appear here once added',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(
    BuildContext context,
    ReviewViewModel viewModel,
    String reviewId,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Delete Review',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        content: const Text(
          'Are you sure you want to delete this review? This action cannot be undone.',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF6B7280),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF6B7280)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              viewModel.deleteReview(reviewId);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
