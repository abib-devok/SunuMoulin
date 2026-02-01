import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_wo.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
    Locale('wo')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Sunu Moulin SmartEco'**
  String get appTitle;

  /// No description provided for @languageSelectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get languageSelectionTitle;

  /// No description provided for @wolof.
  ///
  /// In en, this message translates to:
  /// **'Wolof'**
  String get wolof;

  /// No description provided for @french.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get french;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Sunu Moulin'**
  String get welcomeMessage;

  /// No description provided for @loginPrompt.
  ///
  /// In en, this message translates to:
  /// **'Choose how to log in'**
  String get loginPrompt;

  /// No description provided for @scanQR.
  ///
  /// In en, this message translates to:
  /// **'Scan QR'**
  String get scanQR;

  /// No description provided for @enterPIN.
  ///
  /// In en, this message translates to:
  /// **'Enter PIN'**
  String get enterPIN;

  /// No description provided for @guestAccess.
  ///
  /// In en, this message translates to:
  /// **'Guest Access'**
  String get guestAccess;

  /// No description provided for @needHelp.
  ///
  /// In en, this message translates to:
  /// **'Need Assistance?'**
  String get needHelp;

  /// No description provided for @connectToMill.
  ///
  /// In en, this message translates to:
  /// **'Connect to a Mill'**
  String get connectToMill;

  /// No description provided for @bluetooth.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth'**
  String get bluetooth;

  /// No description provided for @wifi.
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi'**
  String get wifi;

  /// No description provided for @enabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabled;

  /// No description provided for @nearbyMills.
  ///
  /// In en, this message translates to:
  /// **'Nearby Mills'**
  String get nearbyMills;

  /// No description provided for @scanForMills.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scanForMills;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @inUse.
  ///
  /// In en, this message translates to:
  /// **'In Use'**
  String get inUse;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// No description provided for @connect.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get connect;

  /// No description provided for @scanning.
  ///
  /// In en, this message translates to:
  /// **'Scanning for more mills...'**
  String get scanning;

  /// No description provided for @configureMilling.
  ///
  /// In en, this message translates to:
  /// **'Configure Your Milling'**
  String get configureMilling;

  /// No description provided for @step1Of3.
  ///
  /// In en, this message translates to:
  /// **'Step 1 of 3'**
  String get step1Of3;

  /// No description provided for @chooseCereal.
  ///
  /// In en, this message translates to:
  /// **'1. Choose your Cereal'**
  String get chooseCereal;

  /// No description provided for @selectFineness.
  ///
  /// In en, this message translates to:
  /// **'2. Select the Fineness'**
  String get selectFineness;

  /// No description provided for @setQuantity.
  ///
  /// In en, this message translates to:
  /// **'3. Set the Quantity (kg)'**
  String get setQuantity;

  /// No description provided for @fine.
  ///
  /// In en, this message translates to:
  /// **'Fine'**
  String get fine;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @coarse.
  ///
  /// In en, this message translates to:
  /// **'Coarse'**
  String get coarse;

  /// No description provided for @voiceHint.
  ///
  /// In en, this message translates to:
  /// **'Or, tap the mic and say \"Mill 5kg of fine mil.\"'**
  String get voiceHint;

  /// No description provided for @confirmMilling.
  ///
  /// In en, this message translates to:
  /// **'Confirm Milling'**
  String get confirmMilling;

  /// No description provided for @millControlTitle.
  ///
  /// In en, this message translates to:
  /// **'Mill 01 - Connected'**
  String get millControlTitle;

  /// No description provided for @millStarted.
  ///
  /// In en, this message translates to:
  /// **'Milling started successfully.'**
  String get millStarted;

  /// No description provided for @milling.
  ///
  /// In en, this message translates to:
  /// **'Milling...'**
  String get milling;

  /// No description provided for @temperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperature;

  /// No description provided for @vibration.
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get vibration;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @normal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get normal;

  /// No description provided for @startMilling.
  ///
  /// In en, this message translates to:
  /// **'Start Milling'**
  String get startMilling;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'Milling History'**
  String get historyTitle;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by date or ID...'**
  String get searchHint;

  /// No description provided for @exportHistory.
  ///
  /// In en, this message translates to:
  /// **'Export History'**
  String get exportHistory;

  /// No description provided for @sessionDetails.
  ///
  /// In en, this message translates to:
  /// **'Total Weight: {weight} kg | Duration: {duration} min'**
  String sessionDetails(Object duration, Object weight);

  /// No description provided for @statusFailed.
  ///
  /// In en, this message translates to:
  /// **'Status: Failed | Duration: {duration} min'**
  String statusFailed(Object duration);

  /// No description provided for @notImplemented.
  ///
  /// In en, this message translates to:
  /// **'Feature not yet implemented.'**
  String get notImplemented;

  /// No description provided for @cerealMil.
  ///
  /// In en, this message translates to:
  /// **'Mil'**
  String get cerealMil;

  /// No description provided for @cerealMaize.
  ///
  /// In en, this message translates to:
  /// **'Maize'**
  String get cerealMaize;

  /// No description provided for @cerealMais.
  ///
  /// In en, this message translates to:
  /// **'Corn'**
  String get cerealMais;

  /// No description provided for @cerealWheat.
  ///
  /// In en, this message translates to:
  /// **'Wheat'**
  String get cerealWheat;

  /// No description provided for @cerealArachide.
  ///
  /// In en, this message translates to:
  /// **'Peanut'**
  String get cerealArachide;

  /// No description provided for @cerealSorghum.
  ///
  /// In en, this message translates to:
  /// **'Sorghum'**
  String get cerealSorghum;

  /// No description provided for @cerealSorgho.
  ///
  /// In en, this message translates to:
  /// **'Sorghum'**
  String get cerealSorgho;

  /// No description provided for @resumeMilling.
  ///
  /// In en, this message translates to:
  /// **'Resume milling'**
  String get resumeMilling;

  /// No description provided for @bluetoothPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth permissions denied. Enable them in settings.'**
  String get bluetoothPermissionDenied;

  /// No description provided for @devicesFound.
  ///
  /// In en, this message translates to:
  /// **'{count} devices found'**
  String devicesFound(Object count);

  /// No description provided for @scanningDevices.
  ///
  /// In en, this message translates to:
  /// **'Scanning for BLE devices...'**
  String get scanningDevices;

  /// No description provided for @locationPermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Location permission required for Bluetooth scan'**
  String get locationPermissionRequired;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get appVersion;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fr', 'wo'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'fr': return AppLocalizationsFr();
    case 'wo': return AppLocalizationsWo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
