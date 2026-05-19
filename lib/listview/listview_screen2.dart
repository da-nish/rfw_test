import 'package:flutter/material.dart';
import 'package:rfw/formats.dart';
import 'package:rfw/rfw.dart';


class FixedInfiniteList extends StatefulWidget {
  const FixedInfiniteList({super.key});

  @override
  State<FixedInfiniteList> createState() =>
      _FixedInfiniteListState();
}

class _FixedInfiniteListState extends State<FixedInfiniteList> {
  final Runtime runtime = Runtime();
  final DynamicContent data = DynamicContent();

  final List<Map<String, dynamic>> items = [];

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

    /// Local widget (FIXED SAFE VERSION)
    runtime.update(
      const LibraryName(['local']),
      LocalWidgetLibrary({
        'InfiniteListView': (context, source) {
          final items = (source.v(['items']) as List?) ?? [];

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index] as Map;

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(item['title']),
                  subtitle: Text(item['subtitle']),
                ),
              );
            },
          );
        },
      }),
    );

    _loadMore();

    const ui = '''
import core.widgets;
import material;
import local;

widget root = Scaffold(
  appBar: AppBar(
    title: Text(text: "Working Infinite List"),
  ),

  body: InfiniteListView(
    items: data.items,
  ),
);
''';

    runtime.update(
      const LibraryName(['main']),
      parseLibraryFile(ui),
    );
  }

  void _loadMore() {
    setState(() {
      final start = items.length;

      for (int i = start; i < start + 20; i++) {
        items.add({
          'title': 'Item $i',
          'subtitle': 'Subtitle $i',
        });
      }

      /// IMPORTANT: pass as raw list (NOT v<List>)
      data.update('items', items);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RemoteWidget(
      runtime: runtime,
      data: data,
      widget: const FullyQualifiedWidgetName(
        LibraryName(['main']),
        'root',
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:rfw/formats.dart';
// import 'package:rfw/rfw.dart';


// class InfiniteScrollPage extends StatefulWidget {
//   const InfiniteScrollPage({super.key});

//   @override
//   State<InfiniteScrollPage> createState() =>
//       _InfiniteScrollPageState();
// }

// class _InfiniteScrollPageState
//     extends State<InfiniteScrollPage> {

//   final Runtime runtime = Runtime();
//   final DynamicContent data = DynamicContent();

//   final List<Map<String, dynamic>> items = [

//   ];

//   @override
//   void initState() {
//     super.initState();

//     runtime.update(
//       const LibraryName(['core', 'widgets']),
//       createCoreWidgets(),
//     );

//     runtime.update(
//       const LibraryName(['material']),
//       createMaterialWidgets(),
//     );

//     /// Register local widgets
//     runtime.update(
//       const LibraryName(['local']),
//       LocalWidgetLibrary({
//         'InfiniteListView': (
//           BuildContext context,
//           DataSource source,
//         ) {

//           // final list = source.v<List>(['items']) ?? []; // source.optionalChild(items);

//           _appendItems();
//           // final list = source.v<List>(['items']) ?? [];

//           final list =
//     source.v<List>(['items']) ?? [];
          


//           final loadMore =
//               source.voidHandler(['onLoadMore']) ?? (){};

//           return InfiniteListView(
//             items: list,
//             onLoadMore: loadMore,
//           );
//         },
//       }),
//     );

//     /// Initial data
    

//     /// RFW UI
//     const ui = '''
// import core.widgets;
// import material;
// import local;

// widget root = Scaffold(
//   appBar: AppBar(
//     title: Text(
//       text: "Infinite Scroll",
//     ),
//   ),

//   body: InfiniteListView(
//     items: data.items,
//     onLoadMore: event "load_more" {},
//   ),
// );
// ''';

//     runtime.update(
//       const LibraryName(['main']),
//       parseLibraryFile(ui),
//     );
//   }

//   void _appendItems() {

//     final start = items.length;

//     for (int i = start; i < start + 20; i++) {

//       items.add({
//         'id': i,
//         'title': 'Item $i',
//         'subtitle': 'Subtitle $i',
//       });
//     }

//     data.update('items', items);
//   }

//   @override
//   Widget build(BuildContext context) {

//     return RemoteWidget(
//       runtime: runtime,
//       data: data,
//       widget: const FullyQualifiedWidgetName(
//         LibraryName(['main']),
//         'root',
//       ),

//       onEvent: (
//         String name,
//         DynamicMap arguments,
//       ) {

//         if (name == 'load_more') {

//           setState(() {

//             _appendItems();

//           });
//         }
//       },
//     );
//   }
// }

// /// LOCAL FLUTTER WIDGET
// class InfiniteListView extends StatefulWidget {

//   final List items;
//   final VoidCallback onLoadMore;

//   const InfiniteListView({
//     super.key,
//     required this.items,
//     required this.onLoadMore,
//   });

//   @override
//   State<InfiniteListView> createState() =>
//       _InfiniteListViewState();
// }

// class _InfiniteListViewState
//     extends State<InfiniteListView> {

//   final ScrollController controller =
//       ScrollController();

//   @override
//   void initState() {
//     super.initState();

//     controller.addListener(_scrollListener);
//   }

//   void _scrollListener() {

//     if (controller.position.pixels >=
//         controller.position.maxScrollExtent - 200) {

//       widget.onLoadMore();
//     }
//   }

//   @override
//   void dispose() {

//     controller.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {

//     return Column(
//       children: [
//         SizedBox(height: 30,
//         child: TextButton(
//         child: const Text('Click Here'),
//         onPressed: () {
        
//         },
//         ),),
//         Expanded(
//           child: ListView.builder(
//             controller: controller,
          
//             itemCount: widget.items.length,
          
//             itemBuilder: (context, index) {
          
//               final item = widget.items[index];
          
//               return Card(
//                 margin: const EdgeInsets.all(10),
          
//                 child: ListTile(
//                   title: Text(item['title']),
//                   subtitle: Text(item['subtitle']),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }