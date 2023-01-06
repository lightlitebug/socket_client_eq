import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/socket/socket_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<SocketBloc>().add(const ConnectSocketEvent());
                  },
                  child: const Text(
                    'Connect',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<SocketBloc>()
                        .add(const DisconnectSocketEvent());
                  },
                  child: const Text(
                    'Disconnect',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                context.read<SocketBloc>().add(const SendMessageSocketEvent());
              },
              child: const Text(
                'Send Message',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            const SizedBox(height: 20.0),
            BlocBuilder<SocketBloc, SocketState>(
              builder: (context, state) {
                print('state: $state');
                if (state is SocketInitialState) {
                  return const Text(
                    'initial',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  );
                } else if (state is SocketDisconnectedState) {
                  return const Text(
                    'disconnected',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  );
                } else if (state is SocketDataState) {
                  return Text(
                    state.message,
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                  );
                }
                // If you want more fine grained control, refine connected state
                return const Text(
                  'connected',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
