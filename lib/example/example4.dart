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

    // String ui = '''
    //   import core.widgets;
    //   import material;

    //   widget root = Scaffold(
    //     appBar: AppBar(
    //       title: Text(text: ["RFW, ", data.header.title, ""]),
    //     ),

    //     body: Center(
    //       child: Column(
    //         mainAxisAlignment: "center",
    //         children: [
    //           Text(
    //             text: data.user.name,
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // ''';
    String ui = '''
import core.widgets;
import material;
import local;

widget root = Scaffold(
  appBar: AppBar(
    title: Text(
      text: ["User Profile - ", data.user.name],
    ),
  ),

  body: Padding(
    padding: EdgeInsets(all: 16),
    child: Column(
      crossAxisAlignment: "start",
      children: [

        Center(
          child: Column(
            children: [

              AppImage(
                name: data.user.image
                ),

              Card(
                child: ListTile(
                  title: Text(text: 'Name'),
                  subtitle: Text(text: data.user.name),
                  onTap: event "item_click" {
                    id: data.user.name,
                    title: data.user.name
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(text: 'Age'),
                  subtitle: Text(text: data.user.age),
                  onTap: event "item_click" {
                    id: data.user.name,
                    title: data.user.name
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(text: 'Mobile'),
                  subtitle: Text(text: data.user.phone),
                  onTap: event "item_click" {
                    id: data.user.name,
                    title: data.user.name
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(text: 'Location'),
                  subtitle: Text(text: data.user.location),
                  onTap: event "item_click" {
                    id: data.user.name,
                    title: data.user.name
                  },
                ),
              ),
            ],
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
      'name': 'Alex',
      'age': '16',
      'phone': '9090909090',
      'location': "BLR",
      'image': "https://fastly.picsum.photos/id/351/300/200.jpg?hmac=FKrLuzw81mZ_CqcRWthUXXe88wCF2d1rqAfUK-VVBZ4"
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