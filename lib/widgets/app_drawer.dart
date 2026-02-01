import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sunu_moulin_smarteco/l10n/app_localizations.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Drawer(
      backgroundColor: theme.colorScheme.background,
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 20),
          _DrawerItem(
            icon: Icons.home_rounded,
            label: l10n.connectToMill,
            onTap: () => context.go('/home'),
          ),
          _DrawerItem(
            icon: Icons.history_rounded,
            label: l10n.historyTitle,
            onTap: () => context.push('/history'),
          ),
          _DrawerItem(
            icon: Icons.settings_rounded,
            label: l10n.settings,
            onTap: () => context.push('/settings'),
          ),
          const Spacer(),
          const Divider(indent: 20, endIndent: 20),
          _DrawerItem(
            icon: Icons.logout_rounded,
            label: "Déconnexion",
            onTap: () => context.go('/'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, left: 24, bottom: 30),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white,
            child: Icon(Icons.person_rounded, size: 40, color: Color(0xFF3C2415)),
          ),
          const SizedBox(height: 16),
          Text(
            "Utilisateur Sunu",
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "smart-eco@sunumoulin.com",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.secondary),
      title: Text(
        label,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
          color: theme.colorScheme.onSurface,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
