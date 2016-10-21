import 'dart:async';
import 'dart:io';
import 'settings.dart';

// TODO: Consider using ArgParser and CommandRunner.
class SassRunner {
  SassSettings _settings;

  SassRunner([SassSettings settings])
      : _settings = settings ?? new SassSettings();

  Future<ProcessResult> run(String inputFilePath, [String outputFilePath]) {
    String _outputFilePath =
        outputFilePath ??= _settings.outputFilePath(inputFilePath);
    return Process.run(
        _settings.executable,
        _settings.options.toArguments()
          ..add(inputFilePath)
          ..add(_outputFilePath));
  }
}
