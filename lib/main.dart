import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/dark_mode/theme_provider.dart';
import 'package:test_drive/name/text_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
        return  MaterialApp(
          title: 'Localizations Sample App',
          localizationsDelegates: const [
            AppLocalizations.delegate, // Add this line
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('es'), // Spanish
            Locale('ms'), // Malaysia
          ],
          home: MyHomePage(title: 'Flutter Demo Home Page'),
          locale: theme.currentLocale,
        );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int? _selectedLanguageIndex;
  late Locale _currentLocale;

  @override
  void initState() {
    super.initState();
    _selectedLanguageIndex = 0; // Set default language index
    _currentLocale = const Locale('en'); // Set default locale
  }


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
            ToggleSwitch(
              minWidth: 50.0,
              cornerRadius: 20.0,
              activeBgColors: [[Colors.green[800]!], [Colors.red[800]!], [Colors.yellow[800]!]],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              initialLabelIndex: _selectedLanguageIndex,
              totalSwitches: 3,
              labels: ['EN', 'ES', 'MY'],
              radiusStyle: true,
              onToggle: (index) {
                print('Index: $index');
                setState(() {
                  _selectedLanguageIndex = index;
                  if (index == 0) {
                    _currentLocale = const Locale('en');
                  } else if (index == 1) {
                    _currentLocale = const Locale('es');
                  } else {
                    _currentLocale = const Locale('ms');
                  }
                  theme.updateLocale(_currentLocale);
                });
              },

            ),
            Builder(
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
                    Text(AppLocalizations.of(context)!.numberOfDataPoints(250)),
                    //Messages with dates
                    Text(AppLocalizations.of(context)!.helloWorldOn(DateTime.utc(1959, 7, 9))),
                    //A toy example for an internationalized Material widget.
                    CalendarDatePicker(
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                        onDateChanged: (value) {}),
                  ],
                );
              },
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
