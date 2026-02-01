import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunu_moulin_smarteco/l10n/app_localizations.dart';
import 'package:sunu_moulin_smarteco/providers/app_providers.dart';
import 'package:sunu_moulin_smarteco/widgets/glass_card.dart';

// Écran des paramètres de l'application
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Section: Langue
          _buildSectionTitle(context, l10n.language),
          _buildLanguageSelector(context, ref, currentLocale, l10n),
          const SizedBox(height: 24),

          // Section: Notifications (placeholder)
          _buildSectionTitle(context, l10n.notifications),
          _buildNotificationToggle(context, l10n),
          const SizedBox(height: 24),

          // Section: À propos
          _buildSectionTitle(context, l10n.about),
          _buildAboutCard(context, l10n),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildLanguageSelector(
    BuildContext context,
    WidgetRef ref,
    Locale currentLocale,
    AppLocalizations l10n,
  ) {
    final languages = [
      {'code': 'fr', 'name': l10n.french, 'icon': '🇫🇷'},
      {'code': 'en', 'name': l10n.english, 'icon': '🇬🇧'},
      {'code': 'wo', 'name': l10n.wolof, 'icon': '🇸🇳'},
    ];

    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: languages.map((lang) {
          final isSelected = currentLocale.languageCode == lang['code'];
          return ListTile(
            leading: Text(
              lang['icon']!,
              style: const TextStyle(fontSize: 28),
            ),
            title: Text(
              lang['name']!,
              style: GoogleFonts.inter(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            trailing: isSelected
                ? Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary)
                : null,
            onTap: () {
              ref.read(localeProvider.notifier).setLocale(lang['code']!);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${l10n.language}: ${lang['name']}'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNotificationToggle(BuildContext context, AppLocalizations l10n) {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: SwitchListTile(
        title: Text(
          l10n.notifications,
          style: GoogleFonts.inter(),
        ),
        subtitle: Text(
          'Recevoir les notifications de mouture',
          style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
        ),
        value: true, // Placeholder
        onChanged: (value) {
          // TODO: Implement notification toggle
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.notImplemented)),
          );
        },
      ),
    );
  }

  Widget _buildAboutCard(BuildContext context, AppLocalizations l10n) {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(l10n.appTitle, style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
            subtitle: Text('${l10n.appVersion}: 1.0.0', style: GoogleFonts.inter(fontSize: 12)),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.code),
            title: const Text('Développé avec Flutter'),
            subtitle: Text('Prototype SmartEco', style: GoogleFonts.inter(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
