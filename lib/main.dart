import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/dark_mode/theme_provider.dart';
import 'package:test_drive/name/text_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => TextProvider())
      ],
      child: Consumer<ThemeProvider>(builder: (context, theme, _) {
        return const MaterialApp(
          title: 'Localizations Sample App',
          localizationsDelegates: [
            AppLocalizations.delegate, // Add this line
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en'), // English
            Locale('es'), // Spanish
          ],
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.helloWorld),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Localizations.override(
              context: context,
              locale: const Locale('es'),
              child: Builder(
                builder: (context) {
                  // Examples of internationalized strings.
                  return Column(
                    children: <Widget>[
                      // Returns 'Hello John'
                      Text(AppLocalizations.of(context)!.hello('John')),
                      // Returns 'no wombats'
                      Text(AppLocalizations.of(context)!.nWombats(0)),
                      // Returns '1 wombat'
                      Text(AppLocalizations.of(context)!.nWombats(1)),
                      // Returns '5 wombats'
                      Text(AppLocalizations.of(context)!.nWombats(5)),
                      // Returns 'he'
                      Text(AppLocalizations.of(context)!.pronoun('male')),
                      // Returns 'she'
                      Text(AppLocalizations.of(context)!.pronoun('female')),
                      // Returns 'they'
                      Text(AppLocalizations.of(context)!.pronoun('other')),
                      //Messages with number and currencies
                      Text(AppLocalizations.of(context)!
                          .numberOfDataPoints(250)),
                      //Messages with dates
                      Text(AppLocalizations.of(context)!
                          .helloWorldOn(DateTime.utc(1959, 7, 9))),


                      //A toy example for an internationalized Material widget.
                      CalendarDatePicker(
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                          onDateChanged: (value) {})
                    ],
                  );
                },
              ),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          theme.toggleDarkMode();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
