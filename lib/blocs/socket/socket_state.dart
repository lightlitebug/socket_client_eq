part of 'socket_bloc.dart';

abstract class SocketState extends Equatable {
  const SocketState();

  @override
  List<Object> get props => [];
}

class SocketInitialState extends SocketState {
  const SocketInitialState();
}

class SocketConnectedConnectingState extends SocketState {
  const SocketConnectedConnectingState();
}

class SocketConnectedSocketIdState extends SocketState {
  final String? id;
  const SocketConnectedSocketIdState({this.id});
}

class SocketConnectedConnectionErrorState extends SocketState {
  const SocketConnectedConnectionErrorState();
}

class SocketConnectedConnectionTimeoutState extends SocketState {
  const SocketConnectedConnectionTimeoutState();
}

class SocketConnectedErrorEventState extends SocketState {
  const SocketConnectedErrorEventState();
}

class SocketConnectedJoinedEventState extends SocketState {
  const SocketConnectedJoinedEventState();
}

class SocketDisconnectedState extends SocketState {
  const SocketDisconnectedState();
}

class SocketDataState extends SocketState {
  final String message;
  const SocketDataState({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'SocketDataState(message: $message)';
}
