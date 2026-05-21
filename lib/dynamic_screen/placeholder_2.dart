import 'package:flutter/material.dart';
import 'package:rfw/formats.dart';
import 'package:rfw/rfw.dart';
import 'package:test_stac/data/list_content.dart';


class DynamicListPage extends StatefulWidget {
  const DynamicListPage({super.key});

  @override
  State<DynamicListPage> createState() => _DynamicListPageState();
}

class _DynamicListPageState extends State<DynamicListPage> {
  final Runtime runtime = Runtime();
  final DynamicContent data = DynamicContent();


  List displayItems = [
      {'title': 'Apple', 'subtitle': 'Red fruit', 'id': 1},
      {'title': 'Banana', 'subtitle': 'Yellow fruit', 'id': 2},
      {'title': 'Mango', 'subtitle': 'King of fruits', 'id': 3},
      {'title': 'Apple', 'subtitle': 'Red fruit', 'id': 1},
    ];

  @override
  void initState() {
    super.initState();

    /// Core + Material widgets
    runtime.update(
      const LibraryName(['core', 'widgets']),
      createCoreWidgets(),
    );

    runtime.update(
      const LibraryName(['material']),
      createMaterialWidgets(),
    );

    /// Sample list data
    data.update('items', displayItems);

String ui = listContent["ui"];

    runtime.update(
      const LibraryName(['main']),
      parseLibraryFile(ui),
    );
  }



  void updateList(){
    displayItems = [
      ...displayItems,
      {'title': 'Apple1', 'subtitle': 'Red fruit', 'id': 1},
      {'title': 'Banana2', 'subtitle': 'Yellow fruit', 'id': 2},
      {'title': 'Mango3', 'subtitle': 'King of fruits', 'id': 3},
      {'title': 'Mango4', 'subtitle': 'King of fruits', 'id': 4},
      {'title': 'Mango5', 'subtitle': 'King of fruits', 'id': 5},
    ];

    data.update('items', displayItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: RemoteWidget(
              runtime: runtime,
              data: data,
              widget: const FullyQualifiedWidgetName(
                LibraryName(['main']),
                'root',
              ),
              onEvent: (name, arguments) {
                debugPrint("EVENT: $name");
                debugPrint("ARGS: $arguments");
            
                if (name == 'item_click') {
                  final id = arguments['id'];
                  final title = arguments['title'];
            
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Clicked: $title (ID: $id)"),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(child: TextButton(onPressed: (){updateList();}, child: Text("View more"))),
    );
  }
}