import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:sunu_moulin_smarteco/l10n/app_localizations.dart';
import 'package:sunu_moulin_smarteco/widgets/modern_button.dart';
import 'package:sunu_moulin_smarteco/widgets/glass_card.dart';
import 'package:sunu_moulin_smarteco/providers/app_providers.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background decorative elements
          Positioned(
            top: -100,
            right: -100,
            child: FadeInDown(
              duration: const Duration(seconds: 2),
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),

          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        // Language Selector
                        Align(
                          alignment: Alignment.topRight,
                          child: FadeInRight(
                            child: IconButton.filledTonal(
                              icon: const Icon(Icons.translate),
                              onPressed: () => context.push('/languages'),
                            ),
                          ),
                        ),

                        const Spacer(),

                        // Logo Section
                        FadeInDown(
                          duration: const Duration(milliseconds: 800),
                          child: Hero(
                            tag: 'app_logo',
                            child: Image.asset(
                              'assets/images/logo.png',
                              height: 180,
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Welcome Text
                        FadeInUp(
                          delay: const Duration(milliseconds: 200),
                          child: Text(
                            l10n.welcomeMessage,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        FadeInUp(
                          delay: const Duration(milliseconds: 400),
                          child: Text(
                            l10n.loginPrompt,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ),

                        const SizedBox(height: 48),

                        // Login Options
                        FadeInUp(
                          delay: const Duration(milliseconds: 600),
                          child: GlassCard(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                ModernButton(
                                  label: l10n.scanQR,
                                  icon: Icons.qr_code_scanner_rounded,
                                  onPressed: () => context.push('/home'),
                                ),
                                const SizedBox(height: 16),
                                ModernButton(
                                  label: l10n.enterPIN,
                                  icon: Icons.pin_rounded,
                                  isSecondary: true,
                                  onPressed: () => context.push('/home'),
                                ),
                                const SizedBox(height: 16),
                                TextButton(
                                  onPressed: () => context.push('/home'),
                                  child: Text(
                                    l10n.guestAccess,
                                    style: TextStyle(
                                      color: theme.colorScheme.secondary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Spacer(),

                        // Footer
                        FadeInUp(
                          delay: const Duration(milliseconds: 800),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: Text(
                              l10n.needHelp,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                decoration: TextDecoration.underline,
                                color: theme.colorScheme.onSurface.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FadeInRight(
        delay: const Duration(milliseconds: 1000),
        child: FloatingActionButton.large(
          onPressed: () async {
            final voiceService = ref.read(voiceServiceProvider);
            await voiceService.speak(l10n.welcomeMessage);
          },
          backgroundColor: theme.colorScheme.tertiary,
          child: const Icon(Icons.mic_none_rounded, color: Colors.white, size: 36),
        ),
      ),
    );
  }
}
