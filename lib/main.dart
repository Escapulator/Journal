import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:journal/Screens/AddNote.dart';
import 'package:journal/Screens/Home.dart';
import 'package:journal/Screens/Splash.dart';

void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => ThemeData(brightness: brightness),
      themedWidgetBuilder: (context, theme){
       return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Journal',
      theme: theme,
      home: Splash(),
      routes: {
        'Splash': (BuildContext context) => new Splash(),
        'Home': (BuildContext context) => new Home(),
        'AddNote': (BuildContext context) => new AddNote(),
        'Drawer': (BuildContext context) => new DrawNav(),
      },
    );
      },
      );
  }
}

class DrawNav extends StatefulWidget {
  @override
  _DrawNavState createState() => _DrawNavState();
}

class _DrawNavState extends State<DrawNav> {
  @override
  Widget build(BuildContext context) {
   bool isOn = false;
    return Drawer(
      child: ListView(
        children: <Widget>[
          Switch(
            value: isOn,
            onChanged: (val){
              toggle();
              setState(() {
                isOn = val;
              });
            },
          )
        ],
      ),
    );
  }
  void toggle(){
    DynamicTheme.of(context).setBrightness(Theme.of(context).brightness == Brightness.dark ? 
    Brightness.light : 
    Brightness.dark);
  }
}
/**import 'package:flutter/material.dart';
import 'package:journal/Screens/AddNote.dart';
import 'package:journal/Screens/Home.dart';
import 'package:journal/Screens/Splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  runApp(
      ChangeNotifierProvider(create: (context) => ThemeMode(), child: MyApp()));
}

class ThemeMode with ChangeNotifier {
  bool lightmode = true;
  changemode() {
    
    lightmode = !lightmode;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final thmode = Provider.of<ThemeMode>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Journal',
      theme: ThemeData(
          brightness: thmode.lightmode ? Brightness.light : Brightness.dark),
      home: Splash(),
      routes: {
        'Splash': (BuildContext context) => new Splash(),
        'Home': (BuildContext context) => new Home(),
        'AddNote': (BuildContext context) => new AddNote(),
        'Drawer': (BuildContext context) => new DrawNav(),
      },
    );
  }
}

class DrawNav extends StatefulWidget {
  @override
  _DrawNavState createState() => _DrawNavState();
}

class _DrawNavState extends State<DrawNav> {
  @override
  Widget build(BuildContext context) {
    final thmode = Provider.of<ThemeMode>(context);
    return Drawer(
      child: ListView(
        children: <Widget>[
          Switch(
            value: thmode.lightmode,
            onChanged: (bool val) async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              thmode.changemode();
            },
          )
        ],
      ),
    );
  }
}
 */
