import 'package:app_owner/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_owner/provider/internet/connectivity_provider.dart';

class ConnectivityHandler extends StatefulWidget {
  final Widget child;
  const ConnectivityHandler({super.key, required this.child});

  @override
  State<ConnectivityHandler> createState() => _ConnectivityHandlerState();
}

class _ConnectivityHandlerState extends State<ConnectivityHandler> {
  ConnectivityProvider? _provider;
  bool _isNoInternetShown = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = context.read<ConnectivityProvider>();
    if (_provider != provider) {
      _provider?.removeListener(_onConnectivityChanged);
      _provider = provider;
      _provider?.addListener(_onConnectivityChanged);
            _onConnectivityChanged();

    }
  }

  @override
  void dispose() {
    _provider?.removeListener(_onConnectivityChanged);
    super.dispose();
  }

  void _onConnectivityChanged() {
    final provider = _provider;
    if (provider == null) return;
    
    final nav = navigatorKey.currentState;
    if (nav == null) return;

if (!provider.isOnline) {
      if (!_isNoInternetShown) {
        _isNoInternetShown = true;
        nav.pushNamed('/NoInternet');
      }
    } else {
      if (_isNoInternetShown) {
        _isNoInternetShown = false;
     
        if (nav.canPop()) {
          final currentRoute = ModalRoute.of(nav.overlay!.context);
          if (currentRoute?.settings.name == '/NoInternet') {
            nav.pop();
          }
        } else {
          _isNoInternetShown = false;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}