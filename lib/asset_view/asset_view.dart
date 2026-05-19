import 'package:flutter/material.dart';
import 'package:rfw/formats.dart';
import 'package:rfw/rfw.dart';

class RfwImagePage extends StatefulWidget {
  const RfwImagePage({super.key});

  @override
  State<RfwImagePage> createState() => _RfwImagePageState();
}

class _RfwImagePageState extends State<RfwImagePage> {
  final Runtime runtime = Runtime();
  final DynamicContent data = DynamicContent();

  @override
  void initState() {
    super.initState();

    /// Register core widgets
    runtime.update(const LibraryName(['core', 'widgets']), createCoreWidgets());

    /// Register material widgets
    runtime.update(const LibraryName(['material']), createMaterialWidgets());

    /// Register LOCAL widgets
    runtime.update(
      const LibraryName(['local']),
      LocalWidgetLibrary({
        'AppTextField1': (BuildContext context, DataSource source) {
          // return Text("Hello");
          // final url = source.v(['url']) as String? ?? '';
          // source.v<String>(['name']) ?? '';

          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              // "url",
              source.v<String>(['name']) ?? '',
              height: 180,
              width: double.infinity,
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

    /// Dynamic string UI
    String ui = '''
      import core.widgets;
      import material;
      import local;

      widget root = Center(
          child: Column(
          children: [
            AppTextField1(
             name: data.user.image
            )
          ]
        ),
      );
    ''';

    /// Parse UI string
    runtime.update(const LibraryName(['main']), parseLibraryFile(ui));

    /// Dynamic data
    data.update('user', {'image': 'https://picsum.photos/300/200?1'});
  }

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            SizedBox(
              // height: 180,
              child: RemoteWidget(
                runtime: runtime,
                data: data,
                widget: const FullyQualifiedWidgetName(
                  LibraryName(['main']),
                  'root',
                ),

                /// Handle events here
                onEvent: (String name, DynamicMap arguments) {
                  debugPrint('EVENT: $name');
                  debugPrint('ARGS: $arguments');

                  if (name == 'card_clicked') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Clicked User ${arguments['userId']}'),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
