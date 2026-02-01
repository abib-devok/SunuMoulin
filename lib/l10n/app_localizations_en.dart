// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Sunu Moulin SmartEco';

  @override
  String get languageSelectionTitle => 'Choose your language';

  @override
  String get wolof => 'Wolof';

  @override
  String get french => 'French';

  @override
  String get english => 'English';

  @override
  String get continueButton => 'Continue';

  @override
  String get welcomeMessage => 'Welcome to Sunu Moulin';

  @override
  String get loginPrompt => 'Choose how to log in';

  @override
  String get scanQR => 'Scan QR';

  @override
  String get enterPIN => 'Enter PIN';

  @override
  String get guestAccess => 'Guest Access';

  @override
  String get needHelp => 'Need Assistance?';

  @override
  String get connectToMill => 'Connect to a Mill';

  @override
  String get bluetooth => 'Bluetooth';

  @override
  String get wifi => 'Wi-Fi';

  @override
  String get enabled => 'Enabled';

  @override
  String get nearbyMills => 'Nearby Mills';

  @override
  String get scanForMills => 'Scan';

  @override
  String get available => 'Available';

  @override
  String get inUse => 'In Use';

  @override
  String get offline => 'Offline';

  @override
  String get connect => 'Connect';

  @override
  String get scanning => 'Scanning for more mills...';

  @override
  String get configureMilling => 'Configure Your Milling';

  @override
  String get step1Of3 => 'Step 1 of 3';

  @override
  String get chooseCereal => '1. Choose your Cereal';

  @override
  String get selectFineness => '2. Select the Fineness';

  @override
  String get setQuantity => '3. Set the Quantity (kg)';

  @override
  String get fine => 'Fine';

  @override
  String get medium => 'Medium';

  @override
  String get coarse => 'Coarse';

  @override
  String get voiceHint => 'Or, tap the mic and say \"Mill 5kg of fine mil.\"';

  @override
  String get confirmMilling => 'Confirm Milling';

  @override
  String get millControlTitle => 'Mill 01 - Connected';

  @override
  String get millStarted => 'Milling started successfully.';

  @override
  String get milling => 'Milling...';

  @override
  String get temperature => 'Temperature';

  @override
  String get vibration => 'Vibration';

  @override
  String get progress => 'Progress';

  @override
  String get normal => 'Normal';

  @override
  String get startMilling => 'Start Milling';

  @override
  String get stop => 'Stop';

  @override
  String get historyTitle => 'Milling History';

  @override
  String get searchHint => 'Search by date or ID...';

  @override
  String get exportHistory => 'Export History';

  @override
  String sessionDetails(Object duration, Object weight) {
    return 'Total Weight: $weight kg | Duration: $duration min';
  }

  @override
  String statusFailed(Object duration) {
    return 'Status: Failed | Duration: $duration min';
  }

  @override
  String get notImplemented => 'Feature not yet implemented.';

  @override
  String get cerealMil => 'Mil';

  @override
  String get cerealMaize => 'Maize';

  @override
  String get cerealMais => 'Corn';

  @override
  String get cerealWheat => 'Wheat';

  @override
  String get cerealArachide => 'Peanut';

  @override
  String get cerealSorghum => 'Sorghum';

  @override
  String get cerealSorgho => 'Sorghum';

  @override
  String get resumeMilling => 'Resume milling';

  @override
  String get bluetoothPermissionDenied => 'Bluetooth permissions denied. Enable them in settings.';

  @override
  String devicesFound(Object count) {
    return '$count devices found';
  }

  @override
  String get scanningDevices => 'Scanning for BLE devices...';

  @override
  String get locationPermissionRequired => 'Location permission required for Bluetooth scan';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get notifications => 'Notifications';

  @override
  String get about => 'About';

  @override
  String get appVersion => 'App Version';

  @override
  String get changeLanguage => 'Change Language';
}
