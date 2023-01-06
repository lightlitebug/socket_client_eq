part of 'socket_bloc.dart';

abstract class SocketEvent extends Equatable {
  const SocketEvent();

  @override
  List<Object> get props => [];
}

class ConnectSocketEvent extends SocketEvent {
  const ConnectSocketEvent();
}

class ConnectingSocketEvent extends SocketEvent {
  const ConnectingSocketEvent();
}

class OnConnectSocketEvent extends SocketEvent {
  const OnConnectSocketEvent();
}

class OnConnectErrorSocketEvent extends SocketEvent {
  const OnConnectErrorSocketEvent();
}

class OnConnectTimeoutSocketEvent extends SocketEvent {
  const OnConnectTimeoutSocketEvent();
}

class OnErrorSocketEvent extends SocketEvent {
  const OnErrorSocketEvent();
}

class OnJoinedSocketEvent extends SocketEvent {
  const OnJoinedSocketEvent();
}

class DisconnectSocketEvent extends SocketEvent {
  const DisconnectSocketEvent();
}

class OnDisconnectSocketEvent extends SocketEvent {
  const OnDisconnectSocketEvent();
}

class SendMessageSocketEvent extends SocketEvent {
  const SendMessageSocketEvent();
}

class ReceiveMessageSocketEvent extends SocketEvent {
  final String message;
  const ReceiveMessageSocketEvent({required this.message});
}
