import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_sense/modules/weather_screen/models/weather_model.dart';
import 'package:sky_sense/utils/services/rest_api_service.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherState.initial()) {
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
                weatherModel: weatherModel, status: WeatherStateStatus.loaded))
            : emit(state.copyWith(status: WeatherStateStatus.noData));
      } else {
        emit(state.copyWith(status: WeatherStateStatus.loading));
      }
    } catch (e) {
      emit(state.copyWith(status: WeatherStateStatus.error));
    }
  }
}
