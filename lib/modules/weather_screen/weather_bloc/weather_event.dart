part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchWeatherDetails extends WeatherEvent {
  final String? location;

  const FetchWeatherDetails({required this.location});
}
