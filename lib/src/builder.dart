import 'dart:async';

import 'package:build/build.dart';
import 'package:build/src/generate/input_set.dart';
import 'package:build/src/generate/phase.dart';

import 'sass_runner/sass_runner.dart';
import 'sass_runner/settings.dart';

class SassBuilder extends Builder {
  SassRunner _runner;

  SassBuilder([SassSettings settings]) : _runner = new SassRunner(settings);

  @override
  Future build(BuildStep buildStep) async {
    var input = buildStep.input;
    await _runner.run(input.id.path, input.id.addExtension('.css').path);
  }

  @override
  List<AssetId> declareOutputs(AssetId inputId) => _cssAssetId(inputId);

  /// Only runs on the root package, and copies all *.scss files.
  static void addPhases(PhaseGroup group, PackageGraph graph,
      [SassSettings settings]) {
    group.newPhase().addAction(new SassBuilder(settings),
        new InputSet(graph.root.name, ['**/*.scss']));
  }
}

List<AssetId> _cssAssetId(AssetId inputId) {
  if (inputId.extension == '.scss' &&
      !(inputId.path.split('/').last.startsWith('_'))) {
    return [inputId.addExtension('.css')];
  }
  return [];
}
