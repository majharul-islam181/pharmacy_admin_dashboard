import 'package:flutter/material.dart';
import '../model/patient_model.dart';

class PatientViewModel extends ChangeNotifier {
  List<PatientModel> _patients = [];
  List<String> _availableDoctors = [];
  int _idCounter = 1000;

  List<PatientModel> get patients => _patients;
  List<String> get availableDoctors => _availableDoctors;

  PatientViewModel() {
    _initMockData();
  }

  void _initMockData() {
    final now = DateTime.now();

    _availableDoctors = [
      'Dr. Sarah Johnson',
      'Dr. Michael Chen',
      'Dr. Emily Roberts',
      'Dr. James Wilson',
      'Dr. Lisa Anderson',
      'Dr. Robert Taylor',
    ];

    _patients = [
      PatientModel(
        id: 'P001',
        date: now.subtract(const Duration(days: 1)),
        name: 'John Smith',
        doctorName: 'Dr. Sarah Johnson',
        alignment: 'Cardiology',
        roomNumber: '101',
        status: PatientStatus.progress,
      ),
      PatientModel(
        id: 'P002',
        date: now.subtract(const Duration(days: 2)),
        name: 'Maria Garcia',
        doctorName: 'Dr. Michael Chen',
        alignment: 'Neurology',
        roomNumber: '205',
        status: PatientStatus.complete,
      ),
      PatientModel(
        id: 'P003',
        date: now,
        name: 'David Lee',
        doctorName: 'Dr. Emily Roberts',
        alignment: 'Pediatrics',
        roomNumber: '312',
        status: PatientStatus.pending,
      ),
      PatientModel(
        id: 'P004',
        date: now.subtract(const Duration(days: 3)),
        name: 'Sarah Wilson',
        doctorName: 'Dr. Lisa Anderson',
        alignment: 'Dermatology',
        roomNumber: '108',
        status: PatientStatus.progress,
      ),
      PatientModel(
        id: 'P005',
        date: now.subtract(const Duration(days: 5)),
        name: 'Robert Brown',
        doctorName: 'Dr. Robert Taylor',
        alignment: 'General Medicine',
        roomNumber: '215',
        status: PatientStatus.complete,
      ),
    ];
  }

  void addPatient({
    required String name,
    required String doctorName,
    required String alignment,
    required String roomNumber,
    required PatientStatus status,
  }) {
    final newPatient = PatientModel(
      id: 'P${_idCounter++}',
      date: DateTime.now(),
      name: name,
      doctorName: doctorName,
      alignment: alignment,
      roomNumber: roomNumber,
      status: status,
    );
    _patients.insert(0, newPatient);
    notifyListeners();
  }

  void updatePatientStatus(String id, PatientStatus newStatus) {
    final index = _patients.indexWhere((p) => p.id == id);
    if (index != -1) {
      _patients[index] = _patients[index].copyWith(status: newStatus);
      notifyListeners();
    }
  }

  void deletePatient(String id) {
    _patients.removeWhere((patient) => patient.id == id);
    notifyListeners();
  }
}
