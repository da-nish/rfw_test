import 'package:flutter/material.dart';
import 'package:rfw/formats.dart';
import 'package:rfw/rfw.dart';
import 'package:test_stac/common/text_field.dart';
import 'package:test_stac/data/search_list_content.dart';

class DynamicListPage2 extends StatefulWidget {
  const DynamicListPage2({super.key});

  @override
  State<DynamicListPage2> createState() => _DynamicListPage2State();
}

class _DynamicListPage2State extends State<DynamicListPage2> {
  final Runtime runtime = Runtime();
  final DynamicContent data = DynamicContent();

  List displayItems = [
    // {'title': 'Apple', 'subtitle': 'Red fruit', 'id': 1},
    // {'title': 'Banana', 'subtitle': 'Yellow fruit', 'id': 2},
    // {'title': 'Mango', 'subtitle': 'King of fruits', 'id': 3},
    // {'title': 'Apple', 'subtitle': 'Red fruit', 'id': 1},
  ];

  @override
  void initState() {
    super.initState();

    /// Core + Material widgets
    runtime.update(const LibraryName(['core', 'widgets']), createCoreWidgets());

    runtime.update(const LibraryName(['material']), createMaterialWidgets());

    runtime.update(
      const LibraryName(['local']),
      LocalWidgetLibrary({
        'AppTextField': (BuildContext context, DataSource source) {
          return AppTextField(
            controller: textController,
            label: source.v<String>(['label']) ?? '',
            hintText: source.v<String>(['label']) ?? '',
            onChanged: (value) {
              debugPrint("RFW onChanged: $value");
              final handler = source.voidHandler(['onChanged']);

              if(!isViewMoreLoading){
                updateList();
              }
              // handler();
            },
          );
        },
      }),
    );

    /// Sample list data
    data.update('items', []);

    String ui = searchListContent["ui"];

    runtime.update(const LibraryName(['main']), parseLibraryFile(ui));
  }

  bool isViewMoreLoading = false;
  Future<void> updateList() async {
    if(textController.text.isEmpty){
       data.update('items', []);
       return;
    }
    isViewMoreLoading = true;
    setState(() {});



    await Future.delayed(Duration(seconds: 2), (){
      displayItems = [
      ...displayItems,
      {'title': 'Apple1', 'subtitle': 'Red fruit', 'id': 1},
      {'title': 'Banana2', 'subtitle': 'Yellow fruit', 'id': 2},
      {'title': 'Mango3', 'subtitle': 'King of fruits', 'id': 3},
      {'title': 'Mango4', 'subtitle': 'King of fruits', 'id': 4},
      {'title': 'Mango5', 'subtitle': 'King of fruits', 'id': 5},
    ];
    isViewMoreLoading = false;
    setState(() {});

    });

    

    data.update('items', displayItems);
  }

  final TextEditingController textController = TextEditingController();

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
                    SnackBar(content: Text("Clicked: $title (ID: $id)")),
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: isViewMoreLoading ? 
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
          ],
        ) :
        TextButton(
          onPressed: () {
            updateList();
          },
          child: Text("View more"),
        ),
      ),
    );
  }
}
