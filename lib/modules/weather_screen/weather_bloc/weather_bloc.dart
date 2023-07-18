import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:sky_sense/modules/weather_screen/models/weather_model.dart';
import 'package:sky_sense/utils/services/rest_api_service.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> with HydratedMixin {
  WeatherBloc()
      : super(const WeatherState(
          status: WeatherStateStatus.loading,
          weatherModel: null,
        )) {
    on<FetchWeatherDetails>((event, emit) async {
      await _onWeatherApiCallEvent(event, emit);
    });
  }

  Future<void> _onWeatherApiCallEvent(
    FetchWeatherDetails event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      emit(state.copyWith(
          status: (event.location != null && event.location!.isNotEmpty)
              ? WeatherStateStatus.searching
              : WeatherStateStatus.loading));
      if (event.location != null &&
          event.location!.isNotEmpty &&
          event.location!.length > 2) {
        WeatherDataModel? weatherModel =
            await RestAPIService().fetchCurrentWeatherDetails(
          location: event.location ?? "",
        );
        (weatherModel != null)
            ? emit(state.copyWith(
                weatherModel: weatherModel,
                status: WeatherStateStatus.loaded,
              ))
            : emit(state.copyWith(
                status: WeatherStateStatus.noData, weatherModel: null));
      } else {
        emit(state.copyWith(
            status: WeatherStateStatus.loading, weatherModel: null));
      }
    } catch (e) {
      emit(
          state.copyWith(status: WeatherStateStatus.error, weatherModel: null));
    }
  }

  @override
  WeatherState? fromJson(Map<String, dynamic> json) {
    try {
      final weather = WeatherDataModel.fromJson(json);
      return WeatherState(
        status: WeatherStateStatus.loaded,
        weatherModel: weather,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(WeatherState state) {
    if (state.status == WeatherStateStatus.loaded) {
      return state.weatherModel?.toJson();
    } else {
      return null;
    }
  }
}
