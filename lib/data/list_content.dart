final Map<String, dynamic> listContent = {
  "params": {},
  "ui": '''
      import core.widgets;
      import material;

      widget root = Scaffold(
        appBar: AppBar(
          title: Text(text: ["Listview"]),
        ),
        body: 
        ListView(
          children: [

          ...for item in data.items:
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
          ]
        ),
      );
    ''',
};
