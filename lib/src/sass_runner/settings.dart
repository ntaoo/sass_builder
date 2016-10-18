import 'dart:io';
import 'package:path/path.dart' as path;

class SassSettings {
  /// 'sass', 'sassc', or '/path/to/<executable>'
  String executable;
  _Options options;
  SassSettings(
      {String executable,
      bool scss,
      String style,
      bool lineNumbers,
      Set<String> loadPaths,
      String sourcemap,
      int precision})
      : executable = executable ?? Platform.operatingSystem == "windows"
            ? "sass.bat"
            : "sass",
        options = new _Options(
            scss: scss,
            style: style,
            lineNumbers: lineNumbers,
            loadPaths: loadPaths,
            sourcemap: sourcemap,
            precision: precision);
}

class _Options {
  /// This should be null if the executable is sassc.
  final bool scss;
  // nested (default), compact, compressed, or expanded.
  final String style;
  final bool lineNumbers;
  final Set<String> loadPaths;
  final String sourcemap;
  final int precision;
  List<String> _arguments;
  _Options(
      {this.scss,
      this.style,
      this.lineNumbers,
      this.loadPaths,
      this.sourcemap,
      this.precision}) {
    _arguments = [];
    if (scss != null && scss) _arguments.add('--scss');
    if (style != null) _arguments..add('--style')..add(style);
    if (lineNumbers != null && lineNumbers) _arguments.add('--line-numbers');
    if (loadPaths != null && loadPaths.isNotEmpty) {
      List l = loadPaths.map((loadPath) {
        return path.joinAll(path.posix.split(loadPath));
      });
      _arguments
        ..add('--load-path')
        ..addAll(l);
    }
    if (sourcemap != null) _arguments.add('--sourcemap=$sourcemap');
    if (precision != null) _arguments..add('--precision')..add('$precision');
  }
  List toArguments() => new List.from(_arguments);
}
