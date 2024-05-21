import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:instruction_arsenal/utils/dynamic_links_service.dart';
import 'package:instruction_arsenal/utils/theme.dart';
import 'package:instruction_arsenal/utils/theme_provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter/foundation.dart';
import 'error_screen.dart';
import 'features/authentication/auth_checker.dart';
import 'firebase_options.dart';
import 'package:responsive_framework/responsive_framework.dart';


import 'generated/l10n.dart';

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
 // MobileAds.instance.initialize();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  final initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  // MobileAds.instance.updateRequestConfiguration(
  //   RequestConfiguration(
  //     testDeviceIds: ['E9F63D566FDEF50BFB41E18F94E93C59'],
  //   ),
  // );
  runApp( ProviderScope(child: MyApp(initialLink)));
}

final firebaseinitializerProvider = FutureProvider<FirebaseApp>((ref) async {
  return await Firebase.initializeApp();
});


class MyApp extends ConsumerWidget {
  final PendingDynamicLinkData? initialLink;
  const MyApp(this.initialLink, {Key? key}) : super(key: key);


@override
  Widget build(BuildContext context, WidgetRef ref) {

    final initialize = ref.watch(firebaseinitializerProvider);
    final themeModeState = ref.watch(themesProvider);
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
          ),

      debugShowCheckedModeBanner: false,
      title: 'Instruction Arsenal',
      navigatorKey: DynamicLinkService.navigatorKey,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: themeModeState,
      home: initialize.when(
        data: (data) {
          return const AuthChecker();
        },
          loading: () => const CircularProgressIndicator(),
          error: (e, stackTrace) => ErrorScreen(e, stackTrace)),

      initialRoute: '/',
      // routes: {
      //   '/communitymadeinstructionsinfopage': (context) {
      //     final CommunityMadeInstructions communityMadeInstructions =
      //     ModalRoute.of(context)!.settings.arguments as CommunityMadeInstructions;
      //     final bool isMyPost =
      //     ModalRoute.of(context)!.settings.arguments as bool;
      //
      //     return CommunityMadeInstructionsInfoPage(
      //       communityMadeInstructions: communityMadeInstructions,
      //       isMyPost: isMyPost,
      //     );
      //   },
      // },
    );
  }
}




