import 'package:flutter/material.dart';
import 'package:rfw/formats.dart';
import 'package:rfw/rfw.dart';

class Example3 extends StatefulWidget {
  const Example3({super.key});

  @override
  State<Example3> createState() => _Example3State();
}

class _Example3State extends State<Example3> {
  final Runtime _runtime = Runtime();
  final DynamicContent _data = DynamicContent();

  // Normally this would be obtained dynamically, but for this example3
  // we hard-code the "remote" widgets into the app.
  //
  // Also, normally we would decode this with [decodeLibraryBlob] rather than
  // parsing the text version using [parseLibraryFile]. However, to make it
  // easier to demo, this uses the slower text format.
static final RemoteWidgetLibrary _remoteWidgets = parseLibraryFile('''
  import core.widgets;

  widget root = Center(
    child: GestureDetector(
      onTap: EventHandler(
        event: "hello",
      ),
      child: Container(
        padding: EdgeInsets.all(20.0),
        color: 0xFF2196F3,
        child: Text(
          text: "Click Me",
          textDirection: "ltr",
        ),
      ),
    ),
  );
''');

  static const LibraryName coreName = LibraryName(<String>['core', 'widgets']);
  static const LibraryName mainName = LibraryName(<String>['main']);

  @override
  void initState() {
    super.initState();
    // Local widget library:
    _runtime.update(coreName, createCoreWidgets());
    // Remote widget library:
    _runtime.update(mainName, _remoteWidgets);
    // Configuration data:
    _data.update('greet', <String, Object>{'name': 'World'});
  }

  @override
  Widget build(BuildContext context) {
    return RemoteWidget(
      runtime: _runtime,
      data: _data,
      widget: const FullyQualifiedWidgetName(mainName, 'root'),
    
      onEvent: (String name, DynamicMap arguments) {
        print("object");
        // The example3 above does not have any way to trigger events, but if it
        // did, they would result in this callback being invoked.
        debugPrint('user triggered event "$name" with data: $arguments');
      },
    );
  }
}