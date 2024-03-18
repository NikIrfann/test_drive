import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/dark_mode/theme_provider.dart';
import 'package:test_drive/name/text_provider.dart';
import 'package:test_drive/sample.dart';
import 'package:test_drive/utils.dart';

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
        return MaterialApp(
          title: 'Flutter Demo',
          theme: theme.isDarkMode
              ? ThemeData.dark()
              : ThemeData(
                  cardColor: Colors.orange,
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Consumer<TextProvider>(builder: (context, tp, _) {
          return Text(tp.title);
        }),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Flexible(
              child: Container(
                width: 200,
                color: Theme.of(context).cardColor,
              ),
            ),
            const Text("Input Image SRC"),
            Image.network(
                "https://th.bing.com/th/id/OIP.avb9nDfw3kq7NOoP0grM4wHaEK?rs=1&pid=ImgDetMain"),
            TextFormField(),
            ElevatedButton(
                onPressed: () {
                  go(context,const SampleScreen());
                },
                child: const Text("Next Screen")),
            Flexible(
              child: Container(
                width: 200,
                color: Colors.blue,
              ),
            ),
            Flexible(
              child: Container(
                width: 200,
                color: Colors.green,
              ),
            )
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
