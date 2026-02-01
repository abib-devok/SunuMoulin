import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:sunu_moulin_smarteco/l10n/app_localizations.dart';
import 'package:sunu_moulin_smarteco/widgets/modern_button.dart';
import 'package:sunu_moulin_smarteco/widgets/glass_card.dart';

class MillingSetupScreen extends ConsumerStatefulWidget {
  const MillingSetupScreen({super.key});

  @override
  ConsumerState<MillingSetupScreen> createState() => _MillingSetupScreenState();
}

class _MillingSetupScreenState extends ConsumerState<MillingSetupScreen> {
  String _selectedGrain = 'Céréales';
  double _quantity = 1.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.configureMilling)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              child: Text(
                l10n.chooseCereal,
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            _buildGrainSelector(theme),
            const SizedBox(height: 40),
            FadeInDown(
              delay: const Duration(milliseconds: 200),
              child: Text(
                l10n.setQuantity,
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            _buildQuantitySelector(theme),
            const SizedBox(height: 60),
            FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: ModernButton(
                label: l10n.startMilling,
                icon: Icons.play_arrow_rounded,
                onPressed: () => context.push('/milling-control'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrainSelector(ThemeData theme) {
    final grains = ['Maïs', 'Mil', 'Sorgho', 'Riz'];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: grains.map((grain) {
        final isSelected = _selectedGrain == grain;
        return InkWell(
          onTap: () => setState(() => _selectedGrain = grain),
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? theme.colorScheme.primary : theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface.withOpacity(0.1),
                width: 2,
              ),
            ),
            child: Text(
              grain,
              style: TextStyle(
                color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildQuantitySelector(ThemeData theme) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            "${_quantity.toStringAsFixed(1)} kg",
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.secondary,
            ),
          ),
          Slider(
            value: _quantity,
            min: 0.5,
            max: 10.0,
            divisions: 19,
            activeColor: theme.colorScheme.primary,
            onChanged: (val) => setState(() => _quantity = val),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("0.5 kg", style: theme.textTheme.bodySmall),
              Text("10 kg", style: theme.textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}
