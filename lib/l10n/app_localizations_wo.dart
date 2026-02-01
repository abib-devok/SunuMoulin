// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Wolof (`wo`).
class AppLocalizationsWo extends AppLocalizations {
  AppLocalizationsWo([String locale = 'wo']) : super(locale);

  @override
  String get appTitle => 'Sunu Moulin SmartEco';

  @override
  String get languageSelectionTitle => 'Tànnal sa làkk';

  @override
  String get wolof => 'Wolof';

  @override
  String get french => 'Français';

  @override
  String get english => 'Anglais';

  @override
  String get continueButton => 'Kontiñe';

  @override
  String get welcomeMessage => 'Dalal-jàmm ci Sunu Moulin';

  @override
  String get loginPrompt => 'Tàannal nou ngay dougguée';

  @override
  String get scanQR => 'Skanne QR';

  @override
  String get enterPIN => 'Duggal PIN';

  @override
  String get guestAccess => 'Duggu ni Gan';

  @override
  String get needHelp => 'Soo bëggee ndimbal?';

  @override
  String get connectToMill => 'Jokkoo ak ab Moulin';

  @override
  String get bluetooth => 'Bluetooth';

  @override
  String get wifi => 'Wi-Fi';

  @override
  String get enabled => 'Takk na';

  @override
  String get nearbyMills => 'Moulin yu Jege yi';

  @override
  String get scanForMills => 'Skanne';

  @override
  String get available => 'Mën naa Jëfandikoo';

  @override
  String get inUse => 'Ci Jëfandikoo';

  @override
  String get offline => 'Takkul';

  @override
  String get connect => 'Jokkoo';

  @override
  String get scanning => 'Gni ngi weur yeneen moulin...';

  @override
  String get configureMilling => 'Saytu Sa Sumaale';

  @override
  String get step1Of3 => 'Jéego 1 ci 3';

  @override
  String get chooseCereal => '1. Tànnal sa Cereale';

  @override
  String get selectFineness => '2. Tànnal Finesse bi';

  @override
  String get setQuantity => '3. Saytu Lim bi (kg)';

  @override
  String get fine => 'Fin';

  @override
  String get medium => 'Diggu';

  @override
  String get coarse => 'Rëy';

  @override
  String get voiceHint => 'Wala, taqal micro bi te wax \"Sumaal 5kg dugub fin.\"';

  @override
  String get confirmMilling => 'Sentu Sumaale bi';

  @override
  String get millControlTitle => 'Moulin 01 - Jokkoo na';

  @override
  String get millStarted => 'Sumaale bi door na ci jàmm.';

  @override
  String get milling => 'Sumaale...';

  @override
  String get temperature => 'Tàngaay';

  @override
  String get vibration => 'Yëngu-yëngu';

  @override
  String get progress => 'Avancement';

  @override
  String get normal => 'Normaal';

  @override
  String get startMilling => 'Door Sumaale';

  @override
  String get stop => 'Tàllil';

  @override
  String get historyTitle => 'Historiku Sumaale yi';

  @override
  String get searchHint => 'Weur ci bis wala ID...';

  @override
  String get exportHistory => 'Ekspòrtee Historik bi';

  @override
  String sessionDetails(Object duration, Object weight) {
    return 'Poids Total: $weight kg | Durée: $duration min';
  }

  @override
  String statusFailed(Object duration) {
    return 'Statut: Echec | Durée: $duration min';
  }

  @override
  String get notImplemented => 'Fonctionnalité bi sotti gul.';

  @override
  String get cerealMil => 'Mil';

  @override
  String get cerealMaize => 'Mais';

  @override
  String get cerealMais => 'Mbok';

  @override
  String get cerealWheat => 'Géej';

  @override
  String get cerealArachide => 'Gerte';

  @override
  String get cerealSorghum => 'Sorgho';

  @override
  String get cerealSorgho => 'Bassi';

  @override
  String get resumeMilling => 'Dellu ci sumaale bi';

  @override
  String get bluetoothPermissionDenied => 'Yoon Bluetooth yi makkul. Tàkku koo ci paramètres yi.';

  @override
  String devicesFound(Object count) {
    return '$count appareils yees nañu';
  }

  @override
  String get scanningDevices => 'Gni ngi weur appareils BLE...';

  @override
  String get locationPermissionRequired => 'Yoon géolocalisation la ñu soxla ngir scan Bluetooth';

  @override
  String get settings => 'Paramètres';

  @override
  String get language => 'Làkk';

  @override
  String get notifications => 'Notifications yi';

  @override
  String get about => 'Ci Biti';

  @override
  String get appVersion => 'Version application bi';

  @override
  String get changeLanguage => 'Soppi làkk';
}
