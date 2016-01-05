library sleep_cycle_estimator.web.main;

import 'package:angular2/angular2.dart';
import 'package:angular2/bootstrap.dart';
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_flex_layout/classes/iron_flex_layout.dart';
import 'package:sleep_cycle_estimator/model/global.dart';
import 'package:sleep_cycle_estimator/views/main_app/main_app.dart';
import 'dart:html';

var APP_NAME = new OpaqueToken("APP_NAME");

main() async {
  await initPolymer();

  bootstrap(MainApp, [
    provide(APP_NAME, useValue: 'message_cipher'),

    provide(Mode, useFactory: initMode, deps: []),

    // logging
    provide(Level, useFactory: initLevel, deps: [Mode]),
    provide(Logger,
        useFactory: (level, APP_NAME) => initLog(level, APP_NAME),
        deps: [Level, APP_NAME])
  ]);
}

Mode initMode() =>
    window.location.host.contains('localhost') ? Mode.Develop : Mode.Production;

Level initLevel(Mode mode) => mode == Mode.Develop ? Level.ALL : Level.WARNING;

enum Mode { Production, Develop }
