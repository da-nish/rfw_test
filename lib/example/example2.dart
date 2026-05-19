import 'package:flutter/material.dart';
import 'package:rfw/formats.dart';
import 'package:rfw/rfw.dart';


const String widgetLibrary = r'''
import core.widgets;
import core.material;

widget root = Center(
  child: ElevatedButton(
    onPressed: event "open_page"{id: 10},
    child: Text(
      text: "Open"
    ),
  ),
);
''';


class Example2 extends StatefulWidget {
  const Example2({super.key});

  @override
  State<Example2> createState() => _Example2State();
}

class _Example2State extends State<Example2> {
  final Runtime _runtime = Runtime();
  final DynamicContent _data = DynamicContent();

  @override
  void initState() {
    super.initState();

    final library = parseLibraryFile(widgetLibrary);

        // Local widget library:
    _runtime.update(coreName, createCoreWidgets());

    _runtime.update(libraryName, library);


  }

  static const LibraryName coreName = LibraryName(<String>['core', 'widgets']);
  static const LibraryName mainName = LibraryName(<String>['main']);

  static final LibraryName libraryName = LibraryName([
    'main',
  ]);

  @override
  Widget build(BuildContext context) {
    return RemoteWidget(
          runtime: _runtime,
          data: _data,
          // widget: FullyQualifiedWidgetName(
          //   libraryName,
          //   'root',
          // ),
          widget: const FullyQualifiedWidgetName(mainName, 'root'),

          // HANDLE EVENTS HERE
          onEvent: (String name, DynamicMap arguments) {
            if (name == 'button_clicked') {
              debugPrint('Button clicked!');

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Button tapped'),
                ),
              );
            }
          },
    );
  }
}