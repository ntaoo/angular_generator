import 'dart:async';
import 'dart:io';

import 'package:angular_generator/src/string_converters.dart';
import 'package:args/args.dart';
import 'package:path/path.dart' as p;

const String appName = 'angular_generator';

class AngularGenerator {
  run(List<String> args) async {
    var argParser = _createArgParser();

    ArgResults options;

    try {
      options = argParser.parse(args);
    } catch (error, stackTrace) {
      if (error is FormatException) {
        return Future.error(ArgumentError(error.message));
      } else {
        return Future.error(error, stackTrace);
      }
    }

    var generatorName = options.rest.first;
    final path = options.rest[1];
    final name = _getName(path);

    ComponentGenerator generator;
    if (generatorName == 'component') {
      generator = ComponentGenerator(name);
    } else {
      throw ArgumentError(
          'Invalid option: {$generatorName}. Only supports "component" option.');
    }

    await _createDirectory(path);
    _writeTo(generator.generateDart(), '$path/${name}.dart');
    _writeTo(generator.generateHtml(), '$path/${name}.html');
    _writeTo(generator.generateScss(), '$path/${name}.scss');
  }

  Future _createDirectory(String path) {
    return Directory(path).create(recursive: true);
  }

  void _writeTo(String fileContent, String path) {
    File(path).writeAsString(fileContent);
  }

  ArgParser _createArgParser() {
    var argParser = ArgParser();

    argParser.addFlag('help', abbr: 'h', negatable: false, help: 'Help!');

    return argParser;
  }

  String _getName(path) {
    return p.basename(path);
  }
}

class ComponentGenerator {
  ComponentGenerator(this._name);

  final String _name;

  String generateDart() {
    return _templateDart(_name);
  }

  String generateHtml() {
    return _templateHtml(_name);
  }

  String generateScss() {
    return _templateScss(_name);
  }

  String _templateDart(String name) {
    return '''import 'package:angular/angular.dart';

@Component(
  selector: '${toHyphenCase(name)}',
  templateUrl: '${name}.html',
  styleUrls: ['${name}.css'])
class ${toPascalCase(name)} implements OnInit {

  ${toPascalCase(name)}();

  @override
  void ngOnInit() {}

}
''';
  }

  String _templateHtml(String name) {
    return name;
  }

  String _templateScss(String name) {
    return '';
  }
}
