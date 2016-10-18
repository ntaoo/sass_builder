import 'dart:async';
import 'dart:io';
import 'settings.dart';

// TODO: Consider using ArgParser and CommandRunner.
class SassRunner {
  SassSettings _settings;

  SassRunner([SassSettings settings])
      : _settings = settings ?? new SassSettings();

  Future<ProcessResult> run(String inputFilePath, String outputFilePath) {
    return Process.run(
        _settings.executable,
        _settings.options.toArguments()
          ..add(inputFilePath)
          ..add(outputFilePath));
  }
}
