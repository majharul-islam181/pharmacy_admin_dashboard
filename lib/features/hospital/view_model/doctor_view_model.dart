import 'package:flutter/material.dart';
import '../model/doctor_model.dart';

class DoctorViewModel extends ChangeNotifier {
  List<DoctorModel> _allDoctors = [];
  List<DoctorModel> _filteredDoctors = [];
  String _searchQuery = '';

  List<DoctorModel> get doctors => _filteredDoctors;
  String get searchQuery => _searchQuery;

  DoctorViewModel() {
    _initMockData();
  }

  void _initMockData() {
    _allDoctors = [
      DoctorModel(
        id: '1',
        name: 'Dr. Samantha',
        specialist: 'Dentist',
        dateOfJoin: DateTime(2020, 2, 26, 12, 42),
        appointmentCount: 5,
        contactNumber: '+12 4124 5125',
        rating: 4.5,
        avatarUrl: 'https://i.pravatar.cc/150?img=47',
        status: DoctorStatus.unavailable,
      ),
      DoctorModel(
        id: '2',
        name: 'Dr. Johnson',
        specialist: 'Orthopedic Surgeon',
        dateOfJoin: DateTime(2020, 2, 27, 14, 30),
        appointmentCount: 3,
        contactNumber: '+15 6123 7890',
        rating: 4.8,
        avatarUrl: 'https://i.pravatar.cc/150?img=12',
        status: DoctorStatus.available,
      ),
      DoctorModel(
        id: '3',
        name: 'Dr. Smith',
        specialist: 'Cardiologist',
        dateOfJoin: DateTime(2020, 2, 28, 9, 15),
        appointmentCount: 0,
        contactNumber: '+18 9876 5432',
        rating: 4.9,
        avatarUrl: 'https://i.pravatar.cc/150?img=33',
        status: DoctorStatus.available,
      ),
      DoctorModel(
        id: '4',
        name: 'Dr. Anderson',
        specialist: 'Pediatrician',
        dateOfJoin: DateTime(2020, 3, 1, 16, 0),
        appointmentCount: 4,
        contactNumber: '+21 3456 7890',
        rating: 4.7,
        avatarUrl: 'https://i.pravatar.cc/150?img=20',
        status: DoctorStatus.unavailable,
      ),
      DoctorModel(
        id: '5',
        name: 'Dr. Williams',
        specialist: 'Ophthalmologist',
        dateOfJoin: DateTime(2020, 3, 2, 10, 30),
        appointmentCount: 6,
        contactNumber: '+24 5678 9012',
        rating: 4.6,
        avatarUrl: 'https://i.pravatar.cc/150?img=26',
        status: DoctorStatus.available,
      ),
      DoctorModel(
        id: '6',
        name: 'Dr. Turner',
        specialist: 'Dermatologist',
        dateOfJoin: DateTime(2020, 3, 3, 13, 15),
        appointmentCount: 0,
        contactNumber: '+27 8901 2345',
        rating: 4.5,
        avatarUrl: 'https://i.pravatar.cc/150?img=45',
        status: DoctorStatus.unavailable,
      ),
      DoctorModel(
        id: '7',
        name: 'Dr. Martinez',
        specialist: 'Neurologist',
        dateOfJoin: DateTime(2020, 3, 4, 11, 0),
        appointmentCount: 5,
        contactNumber: '+30 1234 5678',
        rating: 4.8,
        avatarUrl: 'https://i.pravatar.cc/150?img=32',
        status: DoctorStatus.available,
      ),
      DoctorModel(
        id: '8',
        name: 'Dr. Brown',
        specialist: 'Gynecologist',
        dateOfJoin: DateTime(2020, 3, 5, 15, 45),
        appointmentCount: 0,
        contactNumber: '+33 5678 9012',
        rating: 4.7,
        avatarUrl: 'https://i.pravatar.cc/150?img=44',
        status: DoctorStatus.unavailable,
      ),
      DoctorModel(
        id: '9',
        name: 'Dr. Taylor',
        specialist: 'Urologist',
        dateOfJoin: DateTime(2020, 3, 6, 9, 30),
        appointmentCount: 4,
        contactNumber: '+36 9012 3456',
        rating: 4.9,
        avatarUrl: 'https://i.pravatar.cc/150?img=15',
        status: DoctorStatus.available,
      ),
      DoctorModel(
        id: '10',
        name: 'Dr. White',
        specialist: 'Psychiatrist',
        dateOfJoin: DateTime(2020, 3, 7, 14, 0),
        appointmentCount: 6,
        contactNumber: '+39 2345 6789',
        rating: 4.8,
        avatarUrl: 'https://i.pravatar.cc/150?img=28',
        status: DoctorStatus.available,
      ),
    ];
    _filteredDoctors = List.from(_allDoctors);
  }

  void searchDoctors(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      _filteredDoctors = List.from(_allDoctors);
    } else {
      _filteredDoctors = _allDoctors.where((doctor) {
        return doctor.name.toLowerCase().contains(query.toLowerCase()) ||
            doctor.specialist.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _filteredDoctors = List.from(_allDoctors);
    notifyListeners();
  }
}
