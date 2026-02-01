import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'dart:async';

// Service pour gérer la synthèse vocale (TTS) et la reconnaissance vocale (STT).
class VoiceService {
  final FlutterTts _flutterTts = FlutterTts();
  final SpeechToText _speechToText = SpeechToText();

  Future<void> init() async {
    await _flutterTts.setLanguage("fr-FR");
    await _speechToText.initialize();
  }

  Future<void> speak(String text) async {
    await _flutterTts.speak(text);
  }

  // Écoute les commandes vocales réelles (avec fallback simulation).
  Future<String> listen() async {
    bool available = false;
    try {
      available = await _speechToText.initialize();
    } catch (e) {
      available = false;
    }

    if (!available) {
      // Fallback : Simulation pour démo si le matériel n'est pas supporté (ex: émulateur)
      await Future.delayed(const Duration(seconds: 2));
      return "Simulation: Stop"; // Retourne une commande par défaut pour tester
    }

    final completer = Completer<String>();

    _speechToText.listen(
      onResult: (result) {
        if (result.finalResult) {
          completer.complete(result.recognizedWords);
        }
      },
      localeId: "fr_FR",
      listenFor: const Duration(seconds: 5),
      pauseFor: const Duration(seconds: 2),
      cancelOnError: true,
    );

    // Timeout de sécurité si rien n'est entendu ou erreur silencieuse
    Future.delayed(const Duration(seconds: 6), () {
      if (!completer.isCompleted) {
        _speechToText.stop();
        // Fallback simulation si timeout (souvent le cas sur émulateur)
        completer.complete("Simulation: Stop");
      }
    });

    return completer.future;
  }
}
