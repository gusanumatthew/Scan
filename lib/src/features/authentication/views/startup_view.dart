import 'package:alome/src/core/constants/colors.dart';
import 'package:alome/src/core/routes.dart';
import 'package:alome/src/repositories/authentication_repository.dart';
import 'package:alome/src/repositories/user_repository.dart';
import 'package:alome/src/services/navigation_service.dart';
import 'package:alome/src/widgets/status_bar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    decideNavigation();
    super.initState();
  }

  void decideNavigation() async {
    await Future.delayed(const Duration(seconds: 3), () async {
      final user = ref.watch(authenticationRepository).currentUser;
      if (user == null) {
        ref.read(navigationService).navigateOffNamed(Routes.login);
      } else {
        final appUser = await ref.watch(userRepository).getFutureUser(user.uid);
        ref
            .read(navigationService)
            .navigateOffNamed(Routes.alome, arguments: appUser);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Statusbar(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Alome',
                  style: textTheme.headline2,
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Emmanuel',
                      textStyle: textTheme.headline2?.copyWith(
                        color: AppColors.lightBlue,
                        fontSize: 28,
                      ),
                      speed: const Duration(milliseconds: 200),
                    ),
                  ],
                  totalRepeatCount: 1,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
