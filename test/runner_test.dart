@TestOn('vm')
import 'dart:io';
import 'package:test/test.dart';
import '../lib/src/sass_runner/sass_runner.dart';
import '../lib/src/sass_runner/settings.dart';

main() {
  group('Runner', () {
    var input = 'test/styles/test.scss';
    var output = 'test/styles/test.scss.css';

    test('run with nested style', () async {
      var runner = new SassRunner();
      ProcessResult result = await runner.run(input, output);
      expect(result.exitCode, 0);
      expect(new File(output).existsSync(), isTrue);
    });
    test('run with compressed style', () async {
      var runner = new SassRunner(new SassSettings(style: 'compressed'));
      ProcessResult result = await runner.run(input, output);
      expect(result.exitCode, 0);
      expect(new File(output).existsSync(), isTrue);
    });
  });
}
