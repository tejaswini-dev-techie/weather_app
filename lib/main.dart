import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sky_sense/bloc_components/internet_cubit/internet_cubit.dart';
import 'package:sky_sense/bloc_components/utility/bloc_observer.dart';
import 'package:sky_sense/config/themes/app_themes.dart';
import 'package:sky_sense/constants/routing_constants.dart';
import 'package:sky_sense/constants/string_constants.dart';
import 'package:sky_sense/config/router/app_router.dart';
import 'package:sky_sense/modules/weather_screen/weather_bloc/weather_bloc.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  /* BlocObserver: Debug and Observe the Bloc easily */
  Bloc.observer = AppBlocObserver();

  runApp(
    MyApp(connectivity: Connectivity()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.connectivity,
  });

  final Connectivity connectivity;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (internetCubitContext) => InternetCubit(
            connectivity: connectivity,
          ),
        ),
        BlocProvider<WeatherBloc>(
          create: (weatherBlocContext) => WeatherBloc(),
        ),
      ],
      child: MaterialApp(
        title: StringConstants.appTitle,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        initialRoute: RoutingConstants.launchScreen,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
