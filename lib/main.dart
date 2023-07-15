import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'storage/objectbox.dart';

late FirebaseFirestore firestore;
late ObjectBox objectbox;
late AppStateProvider appStateProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  firestore = FirebaseFirestore.instance;
  firestore.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  objectbox = await ObjectBox.create();
  appStateProvider = AppStateProvider();

  Hive.registerAdapter(UserAdapter());

  try {
    await Hive.openBox('user');
  } catch (e) {
    log(e.toString());
  }

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
          value: appStateProvider,
        ),
        // ChangeNotifierProvider<UserProvider>.value(
        //   value: UserProvider.initialize(),
        // ),
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
