final Map<String, dynamic> searchListContent = {
  "params": {},
  "ui": '''
      import core.widgets;
      import material;
      import local;

      widget root = Scaffold(
      appBar: AppBar(
          title: AppTextField(
              label: "Search",
              hintText: "Search",
              onChanged: event "email_changed" {
                value: "typed"
              },
            ),
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
