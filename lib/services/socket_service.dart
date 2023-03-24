import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

enum ServerStatus {
  // ignore: constant_identifier_names
  Online,
  // ignore: constant_identifier_names
  Offline,
  // ignore: constant_identifier_names
  Connecting
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late Socket _socket;

  ServerStatus get serverStatus => _serverStatus;
  Socket get socket => _socket;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    _socket = io('http://192.168.1.201:4500/', {
      'transports': ['websocket'],
      'autoConnect': true
    });

    // _socket.on('connect', (_) {
    //   _serverStatus = ServerStatus.Online;
    //   notifyListeners();
    // });
    _socket.on('connect', (_) {
      print('connect');
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    // _socket.on('disconnect', (_) {
    //   _serverStatus = ServerStatus.Offline;
    //   notifyListeners();
    // });

    socket.on('nuevo-mensaje', (payload) {
      print(payload);
    });

    // add this line
    socket.connect();
  }
}
