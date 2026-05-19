import 'package:flutter/material.dart';
import 'package:rfw/formats.dart';
import 'package:rfw/rfw.dart';

class DynamicScreen extends StatefulWidget {
  const DynamicScreen({super.key});

  @override
  State<DynamicScreen> createState() => _DynamicScreenState();
}

class _DynamicScreenState extends State<DynamicScreen> {

  final Runtime runtime = Runtime();
  final DynamicContent data = DynamicContent();

  @override
  void initState() {
    super.initState();

    runtime.update(
      const LibraryName(['core', 'widgets']),
      createCoreWidgets(),
    );

    runtime.update(
      const LibraryName(['material']),
      createMaterialWidgets(),
    );

    String ui = '''
      import core.widgets;
      import material;

      widget root = Scaffold(
        appBar: AppBar(
          title: Text(text: ["RFW, ", data.header.title, ""]),
        ),

        body: Center(
          child: Column(
            mainAxisAlignment: "center",

            children: [

              Text(
                text: data.user.name,
              ),

              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: event "login_click" {
                  userId: 500,
                  action: "login"
                },
                child: Text(
                  text: "Login"
                ),
              ),
            ],
          ),
        ),
      );
    ''';

    runtime.update(
      const LibraryName(['main']),
      parseLibraryFile(ui),
    );

    data.update('user', {
      'name': 'Darshan',
    });
    data.update('header', {
      'title': 'App v1',
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: RemoteWidget(
        runtime: runtime,
        data: data,
        widget: const FullyQualifiedWidgetName(
          LibraryName(['main']),
          'root',
        ),

        onEvent: (String name, DynamicMap arguments) {

          debugPrint(name);

          if (name == 'login_click') {

            debugPrint(arguments.toString());

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Login clicked ${arguments['userId']}',
                ),
              ),
            );
          }
        },
      ),
    );
  }
}