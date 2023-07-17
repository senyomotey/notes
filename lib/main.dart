import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'providers/user_state_provider.dart';
import 'storage/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'adapters/user_adapter.dart';
import 'providers/app_state_provider.dart';
import 'routes/route_generator.dart';
import 'routes/route_names.dart';

late FirebaseFirestore firestore;
late UserStateProvider userStateProvider;
late AppStateProvider appStateProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox('user');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  firestore = FirebaseFirestore.instance;
  firestore.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  userStateProvider = UserStateProvider();
  appStateProvider = AppStateProvider();

  runApp(const NotesApp());
}

class NotesApp extends StatefulWidget {
  const NotesApp({Key? key}) : super(key: key);

  @override
  State<NotesApp> createState() => NotesAppState();
}

class NotesAppState extends State<NotesApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {}
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appStateProvider.fetchNotes();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: userStateProvider,
        ),
        ChangeNotifierProvider.value(
          value: appStateProvider,
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes',
        // theme: AppThemeData.lightTheme,
        // darkTheme: AppThemeData.darkTheme,
        // themeMode: appProvider.themeMode,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', ''), // English
          Locale('fr', ''), // French
        ],
        initialRoute: RouteNames.launchScreenRoute,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
