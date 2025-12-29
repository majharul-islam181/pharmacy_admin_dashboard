import 'package:flutter/material.dart';
import '../model/purchase_model.dart';
import '../model/purchase_statistics_model.dart';

class PurchaseViewModel extends ChangeNotifier {
  // Purchase List
  List<PurchaseModel> _purchases = [];
  List<PurchaseModel> get purchases => _purchases;

  // Statistics
  PurchaseStatisticsModel? _statistics;
  PurchaseStatisticsModel? get statistics => _statistics;

  // Loading State
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Search and Filter
  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  PurchaseStatus? _filterStatus;
  PurchaseStatus? get filterStatus => _filterStatus;

  // Form State
  final TextEditingController supplierController = TextEditingController();
  final TextEditingController productController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController unitPriceController = TextEditingController();

  PurchaseViewModel() {
    _initializeData();
  }

  void _initializeData() {
    _loadPurchases();
    _loadStatistics();
  }

  void _loadPurchases() {
    _purchases = [
      PurchaseModel(
        id: '1',
        orderId: 'PO-001',
        supplierName: 'Supplier ABC',
        productName: 'Medicine A',
        quantity: 100,
        unitPrice: 12.00,
        totalAmount: 1200.00,
        status: PurchaseStatus.pending,
        orderDate: DateTime.now().subtract(const Duration(days: 2)),
      ),
      PurchaseModel(
        id: '2',
        orderId: 'PO-002',
        supplierName: 'Supplier XYZ',
        productName: 'Medicine B',
        quantity: 50,
        unitPrice: 17.00,
        totalAmount: 850.00,
        status: PurchaseStatus.completed,
        orderDate: DateTime.now().subtract(const Duration(days: 5)),
        deliveryDate: DateTime.now().subtract(const Duration(days: 1)),
      ),
      PurchaseModel(
        id: '3',
        orderId: 'PO-003',
        supplierName: 'Supplier DEF',
        productName: 'Medicine C',
        quantity: 150,
        unitPrice: 14.00,
        totalAmount: 2100.00,
        status: PurchaseStatus.inProgress,
        orderDate: DateTime.now().subtract(const Duration(days: 1)),
      ),
      PurchaseModel(
        id: '4',
        orderId: 'PO-004',
        supplierName: 'Supplier GHI',
        productName: 'Medicine D',
        quantity: 75,
        unitPrice: 20.00,
        totalAmount: 1500.00,
        status: PurchaseStatus.completed,
        orderDate: DateTime.now().subtract(const Duration(days: 7)),
        deliveryDate: DateTime.now().subtract(const Duration(days: 3)),
      ),
      PurchaseModel(
        id: '5',
        orderId: 'PO-005',
        supplierName: 'Supplier JKL',
        productName: 'Medicine E',
        quantity: 200,
        unitPrice: 8.50,
        totalAmount: 1700.00,
        status: PurchaseStatus.pending,
        orderDate: DateTime.now().subtract(const Duration(hours: 12)),
      ),
    ];
    notifyListeners();
  }

  void _loadStatistics() {
    final total = _purchases.length;
    final pending =
        _purchases.where((p) => p.status == PurchaseStatus.pending).length;
    final completed =
        _purchases.where((p) => p.status == PurchaseStatus.completed).length;
    final cancelled =
        _purchases.where((p) => p.status == PurchaseStatus.cancelled).length;
    final totalValue =
        _purchases.fold(0.0, (sum, item) => sum + item.totalAmount);
    final avgValue = total > 0 ? totalValue / total : 0.0;

    _statistics = PurchaseStatisticsModel(
      totalOrders: total,
      pendingOrders: pending,
      completedOrders: completed,
      cancelledOrders: cancelled,
      totalValue: totalValue,
      averageOrderValue: avgValue,
    );
    notifyListeners();
  }

  List<PurchaseModel> get filteredPurchases {
    var filtered = _purchases;

    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where((p) =>
              p.orderId.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              p.supplierName
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              p.productName.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    if (_filterStatus != null) {
      filtered = filtered.where((p) => p.status == _filterStatus).toList();
    }

    return filtered;
  }

  void searchPurchases(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  void setFilterStatus(PurchaseStatus? status) {
    _filterStatus = status;
    notifyListeners();
  }

  Future<void> addPurchase({
    required String supplierName,
    required String productName,
    required int quantity,
    required double unitPrice,
  }) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    final newPurchase = PurchaseModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      orderId: 'PO-${(_purchases.length + 1).toString().padLeft(3, '0')}',
      supplierName: supplierName,
      productName: productName,
      quantity: quantity,
      unitPrice: unitPrice,
      totalAmount: quantity * unitPrice,
      status: PurchaseStatus.pending,
      orderDate: DateTime.now(),
    );

    _purchases.insert(0, newPurchase);
    _loadStatistics();

    _isLoading = false;
    notifyListeners();

    // Clear form
    supplierController.clear();
    productController.clear();
    quantityController.clear();
    unitPriceController.clear();
  }

  Future<void> updatePurchaseStatus(String id, PurchaseStatus newStatus) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    final index = _purchases.indexWhere((p) => p.id == id);
    if (index != -1) {
      final purchase = _purchases[index];
      _purchases[index] = PurchaseModel(
        id: purchase.id,
        orderId: purchase.orderId,
        supplierName: purchase.supplierName,
        productName: purchase.productName,
        quantity: purchase.quantity,
        unitPrice: purchase.unitPrice,
        totalAmount: purchase.totalAmount,
        status: newStatus,
        orderDate: purchase.orderDate,
        deliveryDate:
            newStatus == PurchaseStatus.completed ? DateTime.now() : null,
      );
      _loadStatistics();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> deletePurchase(String id) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    _purchases.removeWhere((p) => p.id == id);
    _loadStatistics();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> refreshData() async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    _loadPurchases();
    _loadStatistics();

    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    supplierController.dispose();
    productController.dispose();
    quantityController.dispose();
    unitPriceController.dispose();
    super.dispose();
  }
}
