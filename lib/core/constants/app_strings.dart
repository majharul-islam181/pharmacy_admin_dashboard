/// Global App Strings - Centralized Text Constants
/// 
/// This file contains all hardcoded UI strings used throughout the app.
/// Organized by feature/category for easy maintenance and future localization.
/// 
/// Usage: import 'package:pharmacy_admin_dashboard/core/constants/app_strings.dart';
///        Text(AppStrings.buttonSave)
/// 
/// For CodeCanyon quality standards - all UI text should reference this file.
class AppStrings {
  AppStrings._(); // Private constructor to prevent instantiation

  // ============================================================================
  // GENERAL & COMMON
  // ============================================================================
  static const String appName = 'Pharmacy Admin';
  static const String appTagline = 'Complete Management Solution';
  
  // ============================================================================
  // BUTTON LABELS
  // ============================================================================
  static const String buttonSave = 'Save';
  static const String buttonCancel = 'Cancel';
  static const String buttonEdit = 'Edit';
  static const String buttonDelete = 'Delete';
  static const String buttonView = 'View';
  static const String buttonSubmit = 'Submit';
  static const String buttonAddNew = 'Add New';
  static const String buttonAddEmployee = 'Add Employee';
  static const String buttonAddPatient = 'Add Patient';
  static const String buttonSaveProduct = 'Save Product';
  static const String buttonSaveReport = 'Save Report';
  static const String buttonSeeAll = 'See All';
  static const String buttonShowDetails = 'Show Details';
  static const String buttonExportPdf = 'Export PDF';
  static const String buttonExportCsv = 'Export CSV';
  static const String buttonUploadImages = 'Upload Images';
  static const String buttonSignInNow = 'Sign In Now';
  static const String buttonLoginWithAnimation = 'Login with Animation';
  static const String buttonToday = 'Today';
  static const String buttonThisWeek = 'This Week';
  static const String buttonThisMonth = 'This Month';
  static const String buttonCustomRange = 'Custom Range';
  static const String buttonAddTask = 'Add Task';
  static const String buttonEditTask = 'Edit Task';
  static const String buttonLogout = 'Logout';
  static const String buttonViewAll = 'View All';
  static const String buttonViewMore = 'View More..';
  static const String buttonSignIn = 'Sign In';
  static const String buttonSignUp = 'Sign Up';
  static const String buttonForgotPassword = 'Forgot Password?';
  static const String buttonRememberMe = 'Remember me';
  
  // ============================================================================
  // PAGE TITLES
  // ============================================================================
  static const String pageDashboard = 'Dashboard';
  static const String pageEmployeeManagement = 'Employee Management';
  static const String pageEmployeeManagementFull = 'Employee Management Page';
  static const String pageAttendanceManagement = 'Attendance Management';
  static const String pageCustomerManagement = 'Customer Management Page';
  static const String pageStockManagement = 'Stock Management Page';
  static const String pageKanbanBoard = 'Kanban Board';
  static const String pagePurchaseManagement = 'Purchase Management';
  static const String pagePatientManagement = 'Patient Management';
  static const String pageReportsAnalytics = 'Reports & Analytics';
  static const String pageCreateCustomReport = 'Create Custom Report';
  static const String pageManageSavedReports = 'Manage Saved Reports';
  static const String pageReportsOverview = 'Reports Overview & Analytics';
  static const String pageDispenserControl = 'Dispenser Control';
  static const String pageManageDispensers = 'Manage Dispensers';
  static const String pageDispenserAnalytics = 'Dispenser Analytics';
  static const String pageAddNewProduct = 'Add New Product';
  static const String pageAddNewDispenser = 'Add New Dispenser';
  static const String pageAddNewPatient = 'Add New Patient';
  static const String pageCrm = 'CRM';
  static const String pageModernLogin = 'Modern Login';
  static const String pageAnimatedLogin = 'Animated Login';
  static const String pageProductDetails = 'Product Details';
  static const String pageReportConfiguration = 'Report Configuration';
  static const String pageReportManagement = 'Report Management';
  static const String pageDispenserManagement = 'Dispenser Management';
  static const String pageDispenserReports = 'Dispenser Reports';
  static const String pageButtonElements = 'Button Elements';
  static const String pageLoginShowcase = 'Login Screen Showcase';
  static const String pageClassicLogin = 'Classic Login';
  
  // ============================================================================
  // SIDEBAR MENU ITEMS
  // ============================================================================
  static const String menuChat = 'Chat';
  static const String menuHospital = 'Hospital';
  static const String menuAttendance = 'Attendance';
  static const String menuEmployee = 'Employee';
  static const String menuComponents = 'Components';
  static const String menuWidgets = 'Widgets';
  static const String menuLoginScreens = 'Login Screens';
  static const String menuCrm = 'CRM';
  static const String menuPurchases = 'Purchases';
  static const String menuProducts = 'Products';
  static const String menuReports = 'Reports';
  static const String menuSettings = 'Settings';
  
  // Submenu Items
  static const String submenuDashboard = 'Dashboard';
  static const String submenuDoctor = 'Doctor';
  static const String submenuReview = 'Review';
  static const String submenuPatient = 'Patient';
  static const String submenuTodayAttendance = 'Today Attendance';
  static const String submenuEmployeeAttendance = 'Employee Attendance';
  static const String submenuEmployeeList = 'Employee List';
  static const String submenuAddEmployee = 'Add Employee';
  static const String submenuToast = 'Toast';
  static const String submenuButtonElement = 'Button Element';
  static const String submenuRatingBar = 'Rating Bar';
  static const String submenuBadge = 'Badge';
  static const String submenuModal = 'Modal';
  static const String submenuClassicLogin = 'Classic Login';
  static const String submenuModernLogin = 'Modern Login';
  static const String submenuAnimatedLogin = 'Animated Login';
  
  // ============================================================================
  // FORM FIELD LABELS & HINTS
  // ============================================================================
  static const String labelEmail = 'Email';
  static const String labelEmailAddress = 'Email Address';
  static const String labelPassword = 'Password';
  static const String labelProductName = 'Product Name';
  static const String labelCategory = 'Category';
  static const String labelSku = 'SKU';
  static const String labelUnitPrice = 'Unit Price';
  static const String labelStockQuantity = 'Stock Quantity';
  static const String labelProductImages = 'Product Images *';
  static const String labelPatientName = 'Patient Name *';
  static const String labelDoctor = 'Doctor *';
  static const String labelTitle = 'Title';
  static const String labelDescription = 'Description';
  static const String labelStatus = 'Status';
  static const String labelPriority = 'Priority';
  static const String labelSave = 'Save';
  static const String labelAdd = 'Add';
  
  // Hints
  static const String hintEmailPlaceholder = 'your@email.com';
  static const String hintPasswordPlaceholder = '••••••••';
  static const String hintSearchHere = 'Search here';
  static const String hintEnterProductName = 'Enter product name';
  static const String hintSelectCategory = 'Select category';
  static const String hintEnterSku = 'Enter SKU';
  static const String hintEnterUnitPrice = 'Enter unit price';
  static const String hintEnterQuantity = 'Enter available quantity';
  static const String hintEnterYourEmail = 'Enter your email';
  static const String hintEnterYourPassword = 'Enter your password';
  
  // ============================================================================
  // TABLE HEADERS
  // ============================================================================
  static const String headerDoctorName = 'Doctor Name';
  static const String headerDateJoin = 'Date Join';
  static const String headerSpecialist = 'Specialist';
  static const String headerSchedule = 'Schedule';
  static const String headerContact = 'Contact';
  static const String headerStatus = 'Status';
  static const String headerMedicineName = 'Medicine name';
  static const String headerBatchNo = 'Batch No';
  static const String headerQuantity = 'Quantity';
  static const String headerPrice = 'Price';
  static const String headerExpireDate = 'Expire Date';
  static const String headerChart = 'Chart';
  static const String headerReturn = 'Return';
  static const String headerId = 'ID';
  static const String headerDate = 'Date';
  static const String headerName = 'Name';
  static const String headerDoctor = 'Doctor';
  static const String headerDepartment = 'Department';
  static const String headerRoom = 'Room';
  static const String headerProduct = 'Product';
  static const String headerCategory = 'Category';
  static const String headerUnitsSold = 'Units Sold';
  static const String headerRevenue = 'Revenue';
  
  // ============================================================================
  // STATUS LABELS
  // ============================================================================
  static const String statusAvailable = 'Available';
  static const String statusUnavailable = 'Unavailable';
  static const String statusDelivered = 'delivered';
  static const String statusPending = 'pending';
  static const String statusCancelled = 'cancelled';
  static const String statusActive = 'Active';
  static const String statusCompleted = 'Completed';
  static const String statusTodo = 'Todo';
  static const String statusInProgress = 'In Progress';
  static const String statusReview = 'Review';
  static const String statusDone = 'Done';
  static const String statusEditTask = 'Edit Task';
  static const String statusAddTask = 'Add Task';
  
  // Priority Labels
  static const String priorityHigh = 'High';
  static const String priorityMedium = 'Medium';
  static const String priorityLow = 'Low';
  
  // ============================================================================
  // DIALOG & SNACKBAR MESSAGES
  // ============================================================================
  static const String messageLoginSuccessModern = 'Login successful! (Modern UI Demo)';
  static const String messageLoginSuccessAnimated = 'Login successful! (Animated UI Demo)';
  static const String messageUploadImageRequired = 'Please upload at least one product image.';
  static const String messageDragDropError = 'Drag & drop error:';
  static const String messageGoogleLoginUiOnly = 'Google login UI only';
  static const String messageFacebookLoginUiOnly = 'Facebook login UI only';
  static const String messageLogoutConfirmation = 'Logout Confirmation';
  static const String messageLogoutConfirmationDesc = 'Are you sure you want to logout from your account?';
  static const String messageDeleteTask = 'Delete Task';
  static const String messageDeleteTaskConfirm = 'Are you sure you want to delete this task?';
  static const String messageDeleteEmployee = 'Delete Employee';
  static const String messageDeleteEmployeeConfirm = 'Are you sure you want to delete this employee?';
  
  // ============================================================================
  // EMPTY STATE MESSAGES
  // ============================================================================
  static const String emptyDoctorsNotFound = 'No doctors found';
  static const String emptyTryAdjustingSearch = 'Try adjusting your search';
  static const String emptySelectConversation = 'Select a conversation to start chatting';
  static const String emptyNoPatientsYet = 'No patients yet';
  
  // ============================================================================
  // ERROR & VALIDATION MESSAGES
  // ============================================================================
  static const String errorValidEmail = 'Please enter a valid email';
  static const String errorPasswordLength = 'Password must be at least 6 characters';
  static const String errorEmailRequired = 'Email is required';
  static const String errorInvalidEmailFormat = 'Invalid email format';
  static const String errorPasswordRequired = 'Password is required';
  static const String errorEnterEmail = 'Please enter your email';
  static const String errorEnterPassword = 'Please enter your password';
  
  // ============================================================================
  // GENERAL UI TEXT
  // ============================================================================
  static const String textRecentOrders = 'Recent Orders';
  static const String textExpiringList = 'Expiring List';
  static const String textTodaysReport = 'Today\'s Report';
  static const String textTotalEarning = 'Total Earning';
  static const String textNotifications = 'Notifications';
  static const String textProducts = 'Products';
  static const String textAddProduct = 'Add Product';
  static const String textOrContinueWith = 'OR CONTINUE WITH';
  static const String textGlassmorphicDesign = 'Glassmorphic Design';
  static const String textExperienceSmoothAnimations = 'Experience smooth animations';
  static const String textWelcomeBack = 'Welcome Back';
  static const String textSignInToAdmin = 'Sign in to your admin account';
  static const String textOrContinueWithLower = 'Or continue with';
  static const String textDontHaveAccount = "Don't have an account? ";
  static const String textSignUpUiOnly = 'Sign up feature - UI only';
  static const String textForgotPasswordUiOnly = 'Forgot password feature - UI only';
  static const String textLoginSuccessClassic = 'Login successful! (UI Demo)';
  static const String textInProgress = 'In Progress';
  static const String textComplete = 'Complete';
  static const String textChooseLoginStyle = 'Choose your preferred login style';
  static const String textClassicLoginDesc = 'Professional admin-style login with traditional layout';
  static const String textModernLoginDesc = 'Glassmorphic design with floating labels and modern aesthetic';
  static const String textAnimatedLoginDesc = 'Stunning animations with rotating logo and staggered inputs';
  static const String textViewDemo = 'View Demo';
  
  // Descriptions
  static const String descTrackAttendance = 'Track and manage employee attendance';
  static const String descManageTeamMembers = 'Manage your team members';
  static const String descReportConfiguration = 'Design and save a reusable analytics report layout.';
  static const String descReportManagement = 'Here you can list, edit, duplicate or delete saved report configurations.';
  static const String descRecentReportActivity = 'Quick history of report exports and scheduled summaries.';
  static const String descSalesOverview = 'High level view of revenue and orders over time.';
  static const String descTopProducts = 'Best performing medicines and items for the selected period.';
  static const String descMonitorSalesPerformance = 'Monitor sales performance, inventory movement and financial metrics.';
  static const String descTrackProductTasks = 'Track product-related tasks across Todo, In Progress, Review and Done.';
  static const String descConfigureDispenser = 'Configure a new dispenser unit for your system.';
  static const String descMonitorDispensers = 'Monitor and control all dispenser units.';
  static const String descDispenserAnalytics = 'View detailed analytics and reports for dispensers.';
  static const String descAddReportPage = 'This is a placeholder Add Report page. You can extend it with filters, metrics selection, and export options to match your business needs.';
  static const String descDispenserControl = 'This is where dispenser control functionality will be implemented.';
  static const String descPurchaseManagement = 'This is where purchase management functionality will be implemented.';
  static const String descButtonElements = 'Showcase primary, secondary, outline, and icon buttons here.';
  
  // ============================================================================
  // DASHBOARD STATS & METRICS
  // ============================================================================
  static const String statsTotalSales = 'Total Sales';
  static const String statsLast30Days = 'Last 30 days';
  static const String statsTotalOrders = 'Total Orders';
  static const String statsCompletedPaid = 'Completed & paid';
  static const String statsNetProfit = 'Net Profit';
  static const String statsAfterDiscounts = 'After discounts & tax';
  static const String statsRefunds = 'Refunds';
  static const String statsProcessedThisPeriod = 'Processed this period';
  static const String statsTotalReports = 'Total Reports';
  static const String statsScheduled = 'Scheduled';
  static const String statsShared = 'Shared';
  static const String statsLast30DaysExports = 'Last 30 Days Exports';
  
  // Trend Text
  static const String trendVsLastPeriod = 'vs last period';
  static const String trendPositive124 = '+12.4% vs last period';
  static const String trendPositive41 = '+4.1% vs last period';
  static const String trendPositive78 = '+7.8% vs last period';
  static const String trendNegative23 = '-2.3% vs last period';
  
  // ============================================================================
  // TABS
  // ============================================================================
  static const String tabRevenue = 'Revenue';
  static const String tabOrders = 'Orders';
  
  // ============================================================================
  // TOOLTIP TEXT
  // ============================================================================
  static const String tooltipToggleSidebar = 'Toggle sidebar';
  static const String tooltipSwitchToLightMode = 'Switch to light mode';
  static const String tooltipSwitchToDarkMode = 'Switch to dark mode';
  
  // ============================================================================
  // SOCIAL LOGIN
  // ============================================================================
  static const String socialGoogle = 'Google';
  static const String socialFacebook = 'Facebook';
  
  // ============================================================================
  // FILE UPLOAD
  // ============================================================================
  static const String uploadClickOrDragDrop = 'Click to upload or drag & drop one or multiple images (PNG, JPG, JPEG).';
  static const String uploadDragDropMultiple = 'Upload one or multiple images (PNG, JPG, JPEG).';
  
  // ============================================================================
  // REPORT ACTIVITY SAMPLES
  // ============================================================================
  static const String reportMonthlySalesExported = 'Monthly sales report exported';
  static const String reportExportedByAdmin = 'Exported by Admin on 24 Dec, 10:14 AM';
  static const String reportLabelPdf = 'PDF';
  static const String reportWeeklyEmailScheduled = 'Weekly email summary scheduled';
  static const String reportSentMonday = 'Will be sent every Monday at 9:00 AM';
  static const String reportLabelAutomation = 'Automation';
  static const String reportInventoryExported = 'Inventory valuation exported';
  static const String reportExportedByManager = 'Exported by Manager on 22 Dec, 4:32 PM';
  static const String reportLabelCsv = 'CSV';
  
  // ============================================================================
  // PLACEHOLDERS
  // ============================================================================
  static const String placeholderChartIntegration = 'Chart placeholder – integrate fl_chart or Syncfusion here.';
  static const String placeholderPurchaseContent = 'Purchase Management Content';
  
  // Sample Data
  static const String sampleParacetamol = 'Paracetamol 500mg';
  static const String samplePainRelief = 'Pain Relief';
  
  // ============================================================================
  // PROFILE MENU
  // ============================================================================
  static const String profileMyProfile = 'My Profile';
  static const String profileChangeLanguage = 'Change Language';
  static const String profileAccountSettings = 'Account Settings';
  static const String profileLogout = 'Logout';
  
  // ============================================================================
  // BREADCRUMBS
  // ============================================================================
  static const String breadcrumbProducts = 'Products';
  static const String breadcrumbAddProduct = 'Add Product';
}
