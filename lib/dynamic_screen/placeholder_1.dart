import 'package:flutter/material.dart';
import 'package:rfw/formats.dart';
import 'package:rfw/rfw.dart';
import 'package:test_stac/data/profile_content.dart';

class Placeholder1 extends StatefulWidget {
  const Placeholder1({super.key});

  @override
  State<Placeholder1> createState() => _Placeholder1State();
}

class _Placeholder1State extends State<Placeholder1> {

  final Runtime runtime = Runtime();
  final DynamicContent data = DynamicContent();

  @override
  void initState() {
    super.initState();

    if(!hasProfileContent){return;}

    runtime.update(
      const LibraryName(['core', 'widgets']),
      createCoreWidgets(),
    );

    runtime.update(
      const LibraryName(['material']),
      createMaterialWidgets(),
    );


    runtime.update(
      const LibraryName(['local']),
      LocalWidgetLibrary({
        'AppImage': (BuildContext context, DataSource source) {

          return ClipRRect(
            borderRadius: BorderRadius.circular(100),

            child: Image.network(
              // "url",
              source.v<String>(['name']) ?? '',
              height: 180,
              width: 180,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 180,
                  color: Colors.grey.shade300,
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image),
                );
              },
            ),
          );
        },
      }),
    );

    String ui = profileContent["ui"];

    runtime.update(
      const LibraryName(['main']),
      parseLibraryFile(ui),
    );

    data.update('user', profileContent["params"]);
  }

  bool get hasProfileContent => (profileContent['ui'] ?? "").isNotEmpty;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: !hasProfileContent ? Center(child: Text("No Data"))  :
        RemoteWidget(
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
      ),
    );
  }
}