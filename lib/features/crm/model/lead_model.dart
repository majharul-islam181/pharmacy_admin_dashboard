class LeadModel {
  final String id;
  final String serialNumber;
  final String leadName;
  final String companyName;
  final String phoneNumber;
  final LeadStatus status;
  final String location;

  LeadModel({
    required this.id,
    required this.serialNumber,
    required this.leadName,
    required this.companyName,
    required this.phoneNumber,
    required this.status,
    required this.location,
  });
}

enum LeadStatus {
  won,
  lost,
  pending,
}

extension LeadStatusExtension on LeadStatus {
  String get displayName {
    switch (this) {
      case LeadStatus.won:
        return 'Won Lead';
      case LeadStatus.lost:
        return 'Lost Lead';
      case LeadStatus.pending:
        return 'Pending';
    }
  }
}
