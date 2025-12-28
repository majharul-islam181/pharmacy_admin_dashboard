enum ReviewStatus { all, published, deleted }

class ReviewModel {
  final String id;
  final String patientName;
  final String doctorName;
  final String reviewText;
  final double rating;
  final DateTime date;
  final String avatarUrl;
  final String department;
  final String treatmentInfo;
  final ReviewStatus status;

  ReviewModel({
    required this.id,
    required this.patientName,
    required this.doctorName,
    required this.reviewText,
    required this.rating,
    required this.date,
    this.avatarUrl = '',
    this.department = 'Physical Therapy',
    this.treatmentInfo = '',
    this.status = ReviewStatus.all,
  });

  ReviewModel copyWith({
    String? id,
    String? patientName,
    String? doctorName,
    String? reviewText,
    double? rating,
    DateTime? date,
    String? avatarUrl,
    String? department,
    String? treatmentInfo,
    ReviewStatus? status,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      patientName: patientName ?? this.patientName,
      doctorName: doctorName ?? this.doctorName,
      reviewText: reviewText ?? this.reviewText,
      rating: rating ?? this.rating,
      date: date ?? this.date,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      department: department ?? this.department,
      treatmentInfo: treatmentInfo ?? this.treatmentInfo,
      status: status ?? this.status,
    );
  }
}
