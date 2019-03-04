import 'package:args/args.dart';
import 'dart:io';

import 'generator/dart_generator.dart';

final cmdGenerate = 'generate';

void main(List<String> args) {
  ArgParser parser = ArgParser();

  // "generate" command
  ArgParser generateParser = ArgParser();
  generateParser.addFlag('verbose', abbr: 'v', negatable: false, help: 'Output more information');
  parser.addCommand(cmdGenerate, generateParser);

  var results = parser.parse(args);

  if (results.command != null) {
    if (results.command.name == cmdGenerate) {
      _performGenerate(results.command['verbose']);
      return;
    }
  }

  _printUsage(parser);
}

void _printUsage(ArgParser parser) {
  print('Serverpod is a utility for generating serverpod bindings, testing and deploying serverpods.\n');
  print('Usage: serverpod <command> [arguments]\n');
  print('Available commands:\n');

  print('$cmdGenerate: Generate code from yaml files for server and clients');
  print(parser.commands[cmdGenerate].usage);
}

void _performGenerate(bool verbose) {
  // Generate server side code
  print('Generating server side code.');
  var generator = DartGenerator('bin/protocol/', 'bin/protocol/', verbose, true);
  generator.generate();
  print('Done.');
}