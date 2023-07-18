part of 'internet_cubit.dart';

enum InternetStatusState {
  initial,
  connected,
  disconnected,
}

class InternetState extends Equatable {
  final InternetStatusState status;
  final ConnectionType? connectionType;

  const InternetState({
    required this.status,
    this.connectionType,
  });

  static InternetState initial() => const InternetState(
        status: InternetStatusState.initial,
        connectionType: ConnectionType.None,
      );

  InternetState copyWith({
    InternetStatusState? status,
    ConnectionType? connectionType,
  }) =>
      InternetState(
        status: status ?? this.status,
        connectionType: connectionType ?? this.connectionType,
      );

  @override
  List<Object?> get props => [status, connectionType];
}
