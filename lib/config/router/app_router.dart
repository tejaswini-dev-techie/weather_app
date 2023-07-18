import 'package:flutter/material.dart';
import 'package:sky_sense/constants/routing_constants.dart';
import 'package:sky_sense/config/router/route_exceptions.dart';
import 'package:sky_sense/modules/splash_screen/splash_screen.dart';
import 'package:sky_sense/modules/weather_screen/weather_screen.dart';

class AppRouter {
  const AppRouter._();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutingConstants.launchScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case RoutingConstants.weatherScreen:
        return MaterialPageRoute(
          builder: (_) => const WeatherScreen(),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
