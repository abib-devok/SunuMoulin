import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunu_moulin_smarteco/services/ble_service.dart';
import 'package:sunu_moulin_smarteco/services/storage_service.dart';
import 'package:sunu_moulin_smarteco/services/voice_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// --- App Providers ---

// Gère la locale (langue) actuelle de l'application.
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  // La locale par défaut est le français.
  LocaleNotifier() : super(const Locale('fr')) {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('selected_locale');
    if (langCode != null) {
      state = Locale(langCode);
    }
  }

  Future<void> setLocale(String languageCode) async {
    state = Locale(languageCode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_locale', languageCode);
  }
}

// --- Service Providers ---

// Fournit une instance unique du StorageService.
final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

// Fournit une instance unique du VoiceService.
final voiceServiceProvider = Provider<VoiceService>((ref) {
  return VoiceService();
});

// Fournit une instance unique du BleService.
final bleServiceProvider = ChangeNotifierProvider<BleService>((ref) {
  return BleService();
});
