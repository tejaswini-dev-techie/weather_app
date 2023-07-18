import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_sense/bloc_components/internet_cubit/internet_cubit.dart';
import 'package:sky_sense/constants/string_constants.dart';
import 'package:sky_sense/modules/weather_screen/weather_bloc/weather_bloc.dart';
import 'package:sky_sense/modules/weather_screen/widgets/weather_info_tile.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Timer? searchOnStoppedTyping;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchOnStoppedTyping?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final internetState = context.watch<InternetCubit>().state;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: SizedBox.shrink(),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /* Search Text Field */
                TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    hintMaxLines: 2,
                    hintText: StringConstants.hintText,
                    suffixIconConstraints: const BoxConstraints(
                        maxWidth: 60,
                        maxHeight: 60,
                        minHeight: 50,
                        minWidth: 50),
                    suffixIcon: (context.watch<WeatherBloc>().state.status ==
                            WeatherStateStatus.searching)
                        ? Transform.scale(
                            scale: 0.45,
                            child: const CircularProgressIndicator(
                              strokeWidth: 5,
                            ),
                          )
                        : const Icon(
                            Icons.search,
                            color: Colors.black45,
                          ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    enabled: true,
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      const duration = Duration(milliseconds: 800);
                      if (searchOnStoppedTyping != null) {
                        searchOnStoppedTyping?.cancel();
                      }
                      searchOnStoppedTyping = Timer(
                        duration,
                        () async {
                          if (internetState.status ==
                              InternetStatusState.connected) {
                            context
                                .read<WeatherBloc>()
                                .add(FetchWeatherDetails(location: value));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(StringConstants.noInternet),
                                duration: Duration(milliseconds: 300),
                              ),
                            );
                          }
                        },
                      );
                    }
                  },
                ),
                /* Search Text Field */
                const SizedBox(
                  height: 15.0,
                ),
                BlocBuilder<WeatherBloc, WeatherState>(
                  bloc: context.read<WeatherBloc>(),
                  builder: (weatherBlocContext, state) {
                    return (state.status == WeatherStateStatus.loaded)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                StringConstants.weatherNowText,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.blue,
                                    size: 20.0,
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "${state.weatherModel?.location?.name}, ${state.weatherModel?.location?.region}, ${state.weatherModel?.location?.country}",
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Text(
                                "${state.weatherModel?.current?.condition?.text}",
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(weatherBlocContext)
                                            .size
                                            .width *
                                        0.45,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        WeatherInfoTile(
                                          iconWidget: const Text(
                                            StringConstants.degreeCelcius,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          label: StringConstants.feelsLikeText,
                                          value: state.weatherModel?.current
                                                  ?.feelslikeC
                                                  .toString() ??
                                              "",
                                        ),
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                        WeatherInfoTile(
                                          iconWidget: const Text(
                                            StringConstants.wind,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          label: StringConstants.windText,
                                          value:
                                              "${state.weatherModel?.current?.windKph} km/h",
                                        ),
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                        WeatherInfoTile(
                                          iconWidget: const Text(
                                            StringConstants.umbrella,
                                            style: TextStyle(
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          label:
                                              StringConstants.percipitationText,
                                          value:
                                              "${state.weatherModel?.current?.precipMm}mm",
                                        ),
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                        WeatherInfoTile(
                                          iconWidget: const Text(
                                            StringConstants.uv,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          label: StringConstants.uvText,
                                          value: state.weatherModel?.current?.uv
                                                  .toString() ??
                                              "",
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(weatherBlocContext)
                                            .size
                                            .width *
                                        0.45,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        WeatherInfoTile(
                                          iconWidget: const Text(
                                            StringConstants.degreefarenheit,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          label: StringConstants.feelsLikeText,
                                          value: state.weatherModel?.current
                                                  ?.feelslikeF
                                                  .toString() ??
                                              "",
                                        ),
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                        WeatherInfoTile(
                                          iconWidget: const Text(
                                            StringConstants.cloud,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          label: StringConstants.cloudText,
                                          value:
                                              "${state.weatherModel?.current?.cloud}%",
                                        ),
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                        WeatherInfoTile(
                                          iconWidget: const Text(
                                            StringConstants.humidity,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          label: StringConstants.humidityText,
                                          value:
                                              "${state.weatherModel?.current?.humidity}%",
                                        ),
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                        WeatherInfoTile(
                                          iconWidget: const Text(
                                            StringConstants.pressure,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          label: StringConstants.pressureText,
                                          value:
                                              "${state.weatherModel?.current?.pressureMb}mb",
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : (state.status == WeatherStateStatus.searching)
                            ? const Center(
                                child: Text(
                                  StringConstants.loadingText,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            : (state.status == WeatherStateStatus.noData)
                                ? const Center(
                                    child: Text(
                                      StringConstants.noDataFound,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                : (state.status == WeatherStateStatus.error)
                                    ? const Center(
                                        child: Text(
                                          StringConstants.somethingWrongText,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
