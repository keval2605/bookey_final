class Functions {
  static bool checkConnectionError(e) {
    if (e.toString().contains('SocketException') || e.toString().contains('HandshakeException')) {
      return true;
    } else {
      return false;
    }
  }
}
