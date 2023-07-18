part of 'weather_bloc.dart';

enum WeatherStateStatus {
  loading,
  loaded,
  searching,
  noData,
  offline,
  error,
}

class WeatherState extends Equatable {
  final WeatherStateStatus status;
  final WeatherDataModel? weatherModel;

  const WeatherState({
    required this.status,
    required this.weatherModel,
  });

  static WeatherState initial() => const WeatherState(
        status: WeatherStateStatus.loading,
        weatherModel: null,
      );

  WeatherState copyWith({
    WeatherStateStatus? status,
    WeatherDataModel? weatherModel,
  }) =>
      WeatherState(
        status: status ?? this.status,
        weatherModel: weatherModel ?? this.weatherModel,
      );

  @override
  List<Object?> get props => [status, weatherModel];
}
