class AppLogger {
  // ANSI Colors
  static const String _reset = '\x1B[0m';
  static const String _red = '\x1B[31m';
  static const String _green = '\x1B[32m';
  static const String _yellow = '\x1B[33m';
  static const String _blue = '\x1B[34m';
  static const String _bold = '\x1B[1m';

  // Log Icons
  static const String _infoIcon = '🔵';
  static const String _errorIcon = '🔴';
  static const String _debugIcon = '🟢';
  static const String _warningIcon = '🟡';
  static const String _successIcon = '✅';
  static const String _failIcon = '❌';

  static void _log(String message, String tag, String color, String icon) {
    final timestamp = DateTime.now().toString().split(' ')[1].substring(0, 8);
    print('$color$icon [$timestamp] $_bold[$tag]$_reset$color $message$_reset');
  }

  static void info(String message) {
    _log(message, 'INFO', _blue, _infoIcon);
  }

  static void error(String message) {
    _log(message, 'ERROR', _red, _errorIcon);
  }

  static void debug(String message) {
    _log(message, 'DEBUG', _green, _debugIcon);
  }

  static void warning(String message) {
    _log(message, 'WARNING', _yellow, _warningIcon);
  }

  static void success(String message) {
    _log(message, 'SUCCESS', _green, _successIcon);
  }

  static void fail(String message) {
    _log(message, 'FAIL', _red, _failIcon);
  }

  // For development/testing purposes
  static void example() {
    info('This is an info message');
    error('This is an error message');
    debug('This is a debug message');
    warning('This is a warning message');
    success('This is a success message');
    fail('This is a fail message');
  }
}
