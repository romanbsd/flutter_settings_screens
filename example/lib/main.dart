import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

import 'app_settings_page.dart';
import 'cache_provider.dart';

void main() {
  initSettings().then((accentColor) {
    runApp(MyApp(accentColor: accentColor));
  });
}

Future<ValueNotifier<Color>> initSettings() async {
  await Settings.init(
    cacheProvider: _isUsingHive ? HiveCache() : SharePreferenceCache(),
  );
  final _accentColor = ValueNotifier(Colors.blueAccent);
  return _accentColor;
}

bool _isDarkTheme = true;
bool _isUsingHive = true;

class MyApp extends StatelessWidget {
  final ValueNotifier<Color> accentColor;

  const MyApp({Key? key, required this.accentColor}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyHomePage(
      title: 'Flutter Demo Home Page',
      accentColor: accentColor,
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final ValueNotifier<Color> accentColor;

  const MyHomePage({
    Key? key,
    required this.accentColor,
    required this.title,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Color>(
      valueListenable: widget.accentColor,
      builder: (_, color, __) {
        final _darkTheme = ThemeData.dark();
        final _lightTheme = ThemeData.light();
        return MaterialApp(
          title: 'App Settings Demo',
          theme: _isDarkTheme
              ? _darkTheme.copyWith(
                  colorScheme: _darkTheme.colorScheme.copyWith(
                    secondary: color,
                  ),
                  checkboxTheme: CheckboxThemeData(
                    fillColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return null;
                      }
                      if (states.contains(MaterialState.selected)) {
                        return color;
                      }
                      return null;
                    }),
                  ),
                  radioTheme: RadioThemeData(
                    fillColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return null;
                      }
                      if (states.contains(MaterialState.selected)) {
                        return color;
                      }
                      return null;
                    }),
                  ),
                  switchTheme: SwitchThemeData(
                    thumbColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return null;
                      }
                      if (states.contains(MaterialState.selected)) {
                        return color;
                      }
                      return null;
                    }),
                    trackColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return null;
                      }
                      if (states.contains(MaterialState.selected)) {
                        return color;
                      }
                      return null;
                    }),
                  ),
                )
              : _lightTheme.copyWith(
                  colorScheme: _darkTheme.colorScheme.copyWith(
                    secondary: color,
                  ),
                  checkboxTheme: CheckboxThemeData(
                    fillColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return null;
                      }
                      if (states.contains(MaterialState.selected)) {
                        return color;
                      }
                      return null;
                    }),
                  ),
                  radioTheme: RadioThemeData(
                    fillColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return null;
                      }
                      if (states.contains(MaterialState.selected)) {
                        return color;
                      }
                      return null;
                    }),
                  ),
                  switchTheme: SwitchThemeData(
                    thumbColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return null;
                      }
                      if (states.contains(MaterialState.selected)) {
                        return color;
                      }
                      return null;
                    }),
                    trackColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return null;
                      }
                      if (states.contains(MaterialState.selected)) {
                        return color;
                      }
                      return null;
                    }),
                  ),
                ),
          home: Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: Center(
              child: Column(
                children: <Widget>[
                  _buildThemeSwitch(context),
                  _buildPreferenceSwitch(context),
                  SizedBox(
                    height: 50.0,
                  ),
                  AppBody(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPreferenceSwitch(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text('Shared Pref'),
        Switch(
            activeColor: Theme.of(context).colorScheme.secondary,
            value: _isUsingHive,
            onChanged: (newVal) {
              if (kIsWeb) {
                return;
              }
              _isUsingHive = newVal;
              setState(() {
                initSettings();
              });
            }),
        Text('Hive Storage'),
      ],
    );
  }

  Widget _buildThemeSwitch(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text('Light Theme'),
        Switch(
            activeColor: Theme.of(context).colorScheme.secondary,
            value: _isDarkTheme,
            onChanged: (newVal) {
              _isDarkTheme = newVal;
              setState(() {});
            }),
        Text('Dark Theme'),
      ],
    );
  }
}

class AppBody extends StatefulWidget {
  @override
  _AppBodyState createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildClearCacheButton(context),
        SizedBox(
          height: 25.0,
        ),
        ElevatedButton(
          onPressed: () {
            openAppSettings(context);
          },
          child: Text('Start Demo'),
        ),
      ],
    );
  }

  void openAppSettings(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AppSettings(),
    ));
  }

  Widget _buildClearCacheButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Settings.clearCache();
        showSnackBar(
          context,
          'Cache cleared for selected cache.',
        );
      },
      child: Text('Clear selected Cache'),
    );
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    ),
  );
}
