import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sunu_moulin_smarteco/l10n/app_localizations.dart';
import 'package:sunu_moulin_smarteco/models/app_models.dart';
import 'package:sunu_moulin_smarteco/providers/app_providers.dart';
import 'package:sunu_moulin_smarteco/widgets/glass_card.dart';
import 'package:intl/intl.dart';

// Écran affichant l'historique des sessions de mouture.
class MillingHistoryScreen extends ConsumerWidget {
  const MillingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final storageService = ref.watch(storageServiceProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(l10n.historyTitle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // Barre de recherche.
            _buildSearchBar(context, l10n),
            const SizedBox(height: 16),
            // Liste des sessions depuis le stockage.
            Expanded(
              child: FutureBuilder<List<Session>>(
                future: Future.value(storageService.getAllSessions()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erreur: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        "Aucune session enregistrée", // Fallback text if localization misses
                        style: GoogleFonts.inter(color: Colors.grey),
                      ),
                    );
                  }

                  // Trier les sessions par date décroissante
                  final sessions = snapshot.data!;
                  sessions.sort((a, b) => b.startTime.compareTo(a.startTime));

                  return ListView.builder(
                    itemCount: sessions.length,
                    itemBuilder: (context, index) {
                      return _SessionCard(session: sessions[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Bouton d'action flottant pour l'export.
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Simulation d'export
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${l10n.historyTitle} exporté vers /Downloads/history.csv"),
              backgroundColor: Colors.green,
            ),
          );
        },
        label: Text(l10n.exportHistory),
        icon: const Icon(Icons.download),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // Construit la barre de recherche.
  Widget _buildSearchBar(BuildContext context, AppLocalizations l10n) {
    return TextField(
      decoration: InputDecoration(
        hintText: l10n.searchHint,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: const Icon(Icons.tune),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

// Widget pour afficher une seule carte de session.
class _SessionCard extends StatelessWidget {
  final Session session;

  const _SessionCard({required this.session});

  // Détermine le style (icône et couleur) en fonction du statut.
  Map<String, dynamic> _getStatusStyle(BuildContext context) {
    switch (session.status) {
      case 'completed':
        return {'icon': Icons.check_circle, 'color': Colors.green};
      case 'anomaly':
        return {'icon': Icons.warning, 'color': Colors.amber};
      case 'failed':
        return {'icon': Icons.cancel, 'color': Colors.red};
      default:
        return {'icon': Icons.help, 'color': Colors.grey};
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusStyle = _getStatusStyle(context);
    final dateStr = DateFormat('dd MMM yyyy, HH:mm').format(session.startTime);
    final l10n = AppLocalizations.of(context)!;

    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.zero,
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: statusStyle['color'].withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(statusStyle['icon'], color: statusStyle['color']),
        ),
        title: Text(
          session.sessionId,
          style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.sessionDetails(session.durationSeconds, 45)), // Température fictive pour l'instant
            Text(dateStr, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // TODO: Naviguer vers les détails de la session.
        },
      ),
    );
  }
}
