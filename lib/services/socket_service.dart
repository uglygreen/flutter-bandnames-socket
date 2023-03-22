


import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;



enum ServerStatus {
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier {

 ServerStatus _serverStatus = ServerStatus.Connecting;


get serverStatus => _serverStatus;

  SocketService(){
    _initConfig();
  }

  void _initConfig(){
    IO.Socket socket = IO.io('http://localhost:3000',
    IO.OptionBuilder()
      .setTransports(['websocket'])
      .enableAutoConnect()  // disable auto-connection
      .build()
    );
    

      socket.onConnect((_) {
        _serverStatus = ServerStatus.Online;
        notifyListeners();
      });
      socket.onDisconnect((_) {
        _serverStatus = ServerStatus.Offline;
        notifyListeners();
      });

  }
}