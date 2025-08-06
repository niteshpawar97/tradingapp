import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'no_internet_widget.dart';

class ConnectivityWrapper extends StatelessWidget {
  final Widget child;
  final String? offlineMessage;

  const ConnectivityWrapper({
    Key? key,
    required this.child,
    this.offlineMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        final hasConnection = snapshot.data != ConnectivityResult.none;
        if (snapshot.hasData && !hasConnection) {
          return NoInternetWidget(
            onRetry: () {},
            message: offlineMessage,
          );
        }
        return child;
      },
    );
  }
}
