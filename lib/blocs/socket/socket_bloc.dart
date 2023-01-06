import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socket_io_client/socket_io_client.dart';

part 'socket_event.dart';
part 'socket_state.dart';

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  late final Socket _socket;
  static int count = 1;

  SocketBloc() : super(const SocketInitialState()) {
    _socket = io(
      'http://localhost:3000',
      OptionBuilder()
          .setTimeout(3000)
          .setReconnectionDelay(5000)
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    _socket.onConnecting((data) => add(const ConnectingSocketEvent()));
    _socket.onConnect((_) => add(const OnConnectSocketEvent()));
    _socket.onConnectError((data) => add(const OnConnectErrorSocketEvent()));
    _socket
        .onConnectTimeout((data) => add(const OnConnectTimeoutSocketEvent()));
    _socket.onDisconnect((_) => add(const OnDisconnectSocketEvent()));
    _socket.onError((data) => add(const OnErrorSocketEvent()));
    _socket.on('joined', (data) => add(const OnJoinedSocketEvent()));
    _socket.on('message', (data) {
      print('Message from server: $data');
      add(ReceiveMessageSocketEvent(message: data));
    });

    _socket.onConnect((_) {
      print('onConnect');
      _socket.emit('message', 'Client message 20');
    });

    on<SendMessageSocketEvent>((event, emit) {
      _socket.emit('message', 'Client message ${20 * ++count}');
    });

    on<ReceiveMessageSocketEvent>((event, emit) {
      print('_SocketReceivedMessage event: ${event.message}');
      emit(SocketDataState(message: event.message));
    });

    // User events
    on<ConnectSocketEvent>((event, emit) {
      _socket.connect();
      print('Socket.connect...');
    });

    on<DisconnectSocketEvent>((event, emit) {
      _socket.disconnect();
      print('Socket.disconnect...');
    });
    // Socket events
    on<ConnectingSocketEvent>((event, emit) {
      emit(const SocketConnectedConnectingState());
      print('SocketState.connecte(Connecting)');
    });
    on<OnConnectSocketEvent>((event, emit) {
      emit(SocketConnectedSocketIdState(id: _socket.id!));
      print('SocketState.connected(${_socket.id})');
    });
    on<OnConnectErrorSocketEvent>((event, emit) {
      emit(const SocketConnectedConnectionErrorState());
      print('SocketState.connected(Connection Error)');
    });
    on<OnConnectTimeoutSocketEvent>((event, emit) {
      emit(const SocketConnectedConnectionTimeoutState());
      print('SocketState.connected(Connection timeout)');
    });
    on<OnErrorSocketEvent>((event, emit) {
      emit(const SocketConnectedErrorEventState());
      print('SocketState.connected(ErrorEvent)');
    });
    on<OnJoinedSocketEvent>((event, emit) {
      emit(const SocketConnectedJoinedEventState());
      print('SocketState.connected(JoinedEvent)');
    });
    on<OnDisconnectSocketEvent>((event, emit) {
      emit(const SocketDisconnectedState());
      print('SocketState.disconnected()');
    });
  }
  @override
  Future<void> close() {
    _socket.dispose();
    return super.close();
  }
}
