import 'package:flutter/material.dart';
import 'package:rfw/formats.dart';
import 'package:rfw/rfw.dart';


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
      {'title': 'Banana', 'subtitle': 'Yellow fruit', 'id': 2},
      {'title': 'Mango', 'subtitle': 'King of fruits', 'id': 3},
      {'title': 'Apple', 'subtitle': 'Red fruit', 'id': 1},
      {'title': 'Banana', 'subtitle': 'Yellow fruit', 'id': 2},
      {'title': 'Mango', 'subtitle': 'King of fruits', 'id': 3},
      {'title': 'Apple', 'subtitle': 'Red fruit', 'id': 1},
      {'title': 'Banana', 'subtitle': 'Yellow fruit', 'id': 2},
      {'title': 'Mango', 'subtitle': 'King of fruits', 'id': 3},
      {'title': 'Apple', 'subtitle': 'Red fruit', 'id': 1},
      {'title': 'Banana', 'subtitle': 'Yellow fruit', 'id': 2},
      {'title': 'Mango', 'subtitle': 'King of fruits', 'id': 3},
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

    // data.update('hasMore', true);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // data.update('showButton', _buildButton());
    // });

    /// RFW UI string
//     const String ui = '''
// import core.widgets;
// import material;

// widget root = Scaffold(

//   body: ListView(
//     children: [
//       for item in data.items
//         Text(item.title)
        // Card(
        //   child: ListTile(
        //     title: Text(text: item.title),
        //     subtitle: Text(text: item.subtitle),
        //     onTap: event "item_click" {
        //       id: item.id,
        //       title: item.title
        //     },
        //   ),
        // ),
//     ],
//   ),
// );
// ''';
String ui = '''
      import core.widgets;
      import material;

      widget root = Scaffold(
        appBar: AppBar(
          title: Text(text: ["RFW, "]),
        ),
        body: ListView(
          children: [

          ...for item in data.items:
            // Text(text: ["item"]),
             Card(
              child: ListTile(
                title: Text(text: item.title),
                subtitle: Text(text: item.subtitle),
                onTap: event "item_click" {
                  id: item.id,
                  title: item.title
                },
              ),
            ),
          
            // data.showButton
              // data.hasMore
              // ElevatedButton(
              //   child: Text(text: "View More"),

              //   onPressed: event "load_more" {
              //     action: "load_more_clicked"
              //   },
              // ),
          
          ]
        ),
        
      );
    ''';

    runtime.update(
      const LibraryName(['main']),
      parseLibraryFile(ui),
    );
  }


  Map<String, dynamic> _buildButton() {
    if (false) {
      return {
        "widget": "SizedBox",
        "height": 0,
      };
    }

    return {
      "widget": "Padding",
      "padding": 16,
      "child": {
        "widget": "ElevatedButton",
        "child": {"widget": "Text", "text": "View More"},
        "onPressed": {
          "event": "load_more"
        }
      }
    };
  }



  void updateList(){
    data.update('items', [
      ...displayItems,
      {'title': 'Apple1', 'subtitle': 'Red fruit', 'id': 1},
      {'title': 'Banana2', 'subtitle': 'Yellow fruit', 'id': 2},
      {'title': 'Mango3', 'subtitle': 'King of fruits', 'id': 3},
      {'title': 'Mango4', 'subtitle': 'King of fruits', 'id': 4},
      {'title': 'Mango5', 'subtitle': 'King of fruits', 'id': 5},
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: TextButton(
              child: const Text('Click Here', style: TextStyle(color: Colors.black),),
              onPressed: () {
                updateList();
              },
            ),
          ),
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
    );
  }
}