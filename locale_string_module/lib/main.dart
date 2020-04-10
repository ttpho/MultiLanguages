import 'dart:async';

import 'package:flutter/material.dart';
import 'package:localestringmodule/text_localizations_delegate.dart';

import 'locale_config.dart';

void main() => runApp(MainApplication());

_MainApplication _globalStateMainApplication = _MainApplication();

class MainApplication extends StatefulWidget {
  @override
  _MainApplication createState() => _globalStateMainApplication;
}

class _MainApplication extends State<MainApplication> {
  StreamController<Locale> _localeStreamController;

  @override
  initState() {
    super.initState();
    _localeStreamController = new StreamController<Locale>();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _localeStreamController.stream,
      initialData: LocaleConfig.localeDefault(),
      builder: (context, localeSnapshot) {
        return MaterialApp(
          locale: localeSnapshot.data,
          localizationsDelegates: LocaleConfig.localizationsDelegates(),
          supportedLocales: LocaleConfig.supportedLocales(),
          title: 'Locale',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(),
        );
      },
    );
  }

  @override
  void dispose() {
    _localeStreamController.close();
    super.dispose();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _changeLocale() {
    setState(() {
      _counter++;
      final listLocale = LocaleConfig.supportedLocales().toList();
      final locale = listLocale[_counter % listLocale.length];
      _globalStateMainApplication._localeStreamController.add(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              TextLocalizations.of(context).getText("hello"),
              style: Theme.of(context).textTheme.headline1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeLocale,
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
