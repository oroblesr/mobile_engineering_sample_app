import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:mobile_engineering_sample_app/di/di.dart';
import 'package:mobile_engineering_sample_app/generated/l10n.dart';
import 'package:mobile_engineering_sample_app/news_app.dart';
import 'package:mobile_engineering_sample_app/ui/ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  // Create the initialization Future outside of `build`:
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final Future _initialization = initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize app resources:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: ErrorMessage(
              message: S.of(context).errorWhileInitializing,
            ),
          );
        }

        // Once complete, show the application
        if (snapshot.connectionState == ConnectionState.done) {
          return const NewsApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const CircularProgress();
      },
    );
  }

  static Future initializeApp() async {
    EquatableConfig.stringify = foundation.kDebugMode;
    await setUpServiceLocator();
  }
}
