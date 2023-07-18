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

  // static WeatherState initial() => const WeatherState(
  //       status: WeatherStateStatus.loading,
  //       weatherModel: null,
  //     );

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

  Map<String, dynamic> toMap() {
    return {
      'status': status.toString(),
      'weatherModel': weatherModel,
    };
  }

  factory WeatherState.fromMap(Map<String, dynamic> map) {
    return WeatherState(
      status: map['status'] ?? WeatherStateStatus.loading,
      weatherModel: map['weatherModel'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherState.fromJson(String source) =>
      WeatherState.fromMap(json.decode(source));

  @override
  String toString() =>
      'WeatherState(status: $status, weatherModel: $weatherModel)';
}
