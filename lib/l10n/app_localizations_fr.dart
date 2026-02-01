// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Sunu Moulin SmartEco';

  @override
  String get languageSelectionTitle => 'Choisissez votre langue';

  @override
  String get wolof => 'Wolof';

  @override
  String get french => 'Français';

  @override
  String get english => 'Anglais';

  @override
  String get continueButton => 'Continuer';

  @override
  String get welcomeMessage => 'Bienvenue à Sunu Moulin';

  @override
  String get loginPrompt => 'Choisissez comment vous connecter';

  @override
  String get scanQR => 'Scanner QR';

  @override
  String get enterPIN => 'Entrer PIN';

  @override
  String get guestAccess => 'Accès Invité';

  @override
  String get needHelp => 'Besoin d\'assistance ?';

  @override
  String get connectToMill => 'Connecter à un Moulin';

  @override
  String get bluetooth => 'Bluetooth';

  @override
  String get wifi => 'Wi-Fi';

  @override
  String get enabled => 'Activé';

  @override
  String get nearbyMills => 'Moulins à Proximité';

  @override
  String get scanForMills => 'Scanner';

  @override
  String get available => 'Disponible';

  @override
  String get inUse => 'En cours d\'utilisation';

  @override
  String get offline => 'Hors ligne';

  @override
  String get connect => 'Connecter';

  @override
  String get scanning => 'Recherche d\'autres moulins...';

  @override
  String get configureMilling => 'Configurez Votre Mouture';

  @override
  String get step1Of3 => 'Étape 1 sur 3';

  @override
  String get chooseCereal => '1. Choisissez votre Céréale';

  @override
  String get selectFineness => '2. Sélectionnez la Finesse';

  @override
  String get setQuantity => '3. Réglez la Quantité (kg)';

  @override
  String get fine => 'Fine';

  @override
  String get medium => 'Moyenne';

  @override
  String get coarse => 'Grosse';

  @override
  String get voiceHint => 'Ou, tapez sur le micro et dites \"Moudre 5kg de mil fin.\"';

  @override
  String get confirmMilling => 'Confirmer la Mouture';

  @override
  String get millControlTitle => 'Moulin 01 - Connecté';

  @override
  String get millStarted => 'Mouture démarrée avec succès.';

  @override
  String get milling => 'Mouture...';

  @override
  String get temperature => 'Température';

  @override
  String get vibration => 'Vibration';

  @override
  String get progress => 'Progression';

  @override
  String get normal => 'Normale';

  @override
  String get startMilling => 'Démarrer';

  @override
  String get stop => 'Arrêter';

  @override
  String get historyTitle => 'Historique des Moutures';

  @override
  String get searchHint => 'Rechercher par date ou ID...';

  @override
  String get exportHistory => 'Exporter l\'Historique';

  @override
  String sessionDetails(Object duration, Object weight) {
    return 'Poids total: $weight kg | Durée: $duration min';
  }

  @override
  String statusFailed(Object duration) {
    return 'Statut: Échec | Durée: $duration min';
  }

  @override
  String get notImplemented => 'Fonctionnalité pas encore implémentée.';

  @override
  String get cerealMil => 'Mil';

  @override
  String get cerealMaize => 'Maïs';

  @override
  String get cerealMais => 'Maïs';

  @override
  String get cerealWheat => 'Blé';

  @override
  String get cerealArachide => 'Arachide';

  @override
  String get cerealSorghum => 'Sorgho';

  @override
  String get cerealSorgho => 'Sorgho';

  @override
  String get resumeMilling => 'Retour à la mouture en cours';

  @override
  String get bluetoothPermissionDenied => 'Permissions Bluetooth refusées. Activez-les dans les paramètres.';

  @override
  String devicesFound(Object count) {
    return '$count appareils trouvés';
  }

  @override
  String get scanningDevices => 'Recherche d\'appareils BLE...';

  @override
  String get locationPermissionRequired => 'Permission de localisation requise pour le scan Bluetooth';

  @override
  String get settings => 'Paramètres';

  @override
  String get language => 'Langue';

  @override
  String get notifications => 'Notifications';

  @override
  String get about => 'À propos';

  @override
  String get appVersion => 'Version de l\'application';

  @override
  String get changeLanguage => 'Changer la langue';
}
