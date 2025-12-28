import 'package:flutter/material.dart';
import '../model/review_model.dart';

class ReviewViewModel extends ChangeNotifier {
  List<ReviewModel> _reviews = [];
  int _idCounter = 100;
  ReviewStatus _selectedStatus = ReviewStatus.all;

  List<ReviewModel> get reviews {
    if (_selectedStatus == ReviewStatus.all) {
      return _reviews.where((r) => r.status != ReviewStatus.deleted).toList();
    }
    return _reviews.where((r) => r.status == _selectedStatus).toList();
  }

  ReviewStatus get selectedStatus => _selectedStatus;

  ReviewViewModel() {
    _initMockData();
  }

  void _initMockData() {
    final now = DateTime.now();
    _reviews = [
      ReviewModel(
        id: '1',
        patientName: 'Olivia Smith',
        doctorName: 'Dr. Sarah Johnson',
        reviewText:
            'Thanks for all the services, no doubt it is the best hospital. My kidney, BP, diabetes problem',
        rating: 4.0,
        date: DateTime(2020, 7, 24, 4, 55),
        avatarUrl: 'https://i.pravatar.cc/150?img=5',
        department: 'Physical Therapy',
        treatmentInfo: 'My kidney, BP, diabetes problem',
        status: ReviewStatus.all,
      ),
      ReviewModel(
        id: '2',
        patientName: 'Olivia Smith',
        doctorName: 'Dr. Michael Chen',
        reviewText:
            'Thanks for all the services, no doubt it is the best hospital. My kidney, BP, diabetes problem',
        rating: 4.0,
        date: DateTime(2020, 7, 24, 4, 55),
        avatarUrl: 'https://i.pravatar.cc/150?img=5',
        department: 'Physical Therapy',
        treatmentInfo: 'My kidney, BP, diabetes problem',
        status: ReviewStatus.all,
      ),
      ReviewModel(
        id: '3',
        patientName: 'Olivia Smith',
        doctorName: 'Dr. Emily Roberts',
        reviewText:
            'Thanks for all the services, no doubt it is the best hospital. My kidney, BP, diabetes problem',
        rating: 4.0,
        date: DateTime(2020, 7, 24, 4, 55),
        avatarUrl: 'https://i.pravatar.cc/150?img=5',
        department: 'Physical Therapy',
        treatmentInfo: 'My kidney, BP, diabetes problem',
        status: ReviewStatus.all,
      ),
      ReviewModel(
        id: '4',
        patientName: 'Olivia Smith',
        doctorName: 'Dr. Lisa Anderson',
        reviewText:
            'Thanks for all the services, no doubt it is the best hospital. My kidney, BP, diabetes problem',
        rating: 4.0,
        date: DateTime(2020, 7, 24, 4, 55),
        avatarUrl: 'https://i.pravatar.cc/150?img=5',
        department: 'Physical Therapy',
        treatmentInfo: 'My kidney, BP, diabetes problem',
        status: ReviewStatus.published,
      ),
      ReviewModel(
        id: '5',
        patientName: 'Olivia Smith',
        doctorName: 'Dr. James Wilson',
        reviewText:
            'Thanks for all the services, no doubt it is the best hospital. My kidney, BP, diabetes problem',
        rating: 4.0,
        date: DateTime(2020, 7, 24, 4, 55),
        avatarUrl: 'https://i.pravatar.cc/150?img=5',
        department: 'Physical Therapy',
        treatmentInfo: 'My kidney, BP, diabetes problem',
        status: ReviewStatus.all,
      ),
    ];
  }

  void addReview({
    required String patientName,
    required String doctorName,
    required String reviewText,
    required double rating,
  }) {
    final newReview = ReviewModel(
      id: '${_idCounter++}',
      patientName: patientName,
      doctorName: doctorName,
      reviewText: reviewText,
      rating: rating,
      date: DateTime.now(),
    );
    _reviews.insert(0, newReview);
    notifyListeners();
  }

  void deleteReview(String id) {
    final index = _reviews.indexWhere((review) => review.id == id);
    if (index != -1) {
      _reviews[index] = _reviews[index].copyWith(status: ReviewStatus.deleted);
      notifyListeners();
    }
  }

  void publishReview(String id) {
    final index = _reviews.indexWhere((review) => review.id == id);
    if (index != -1) {
      _reviews[index] =
          _reviews[index].copyWith(status: ReviewStatus.published);
      notifyListeners();
    }
  }

  void setStatusFilter(ReviewStatus status) {
    _selectedStatus = status;
    notifyListeners();
  }
}
