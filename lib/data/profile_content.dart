final Map<String, dynamic> profileContent = {
  "params": {
    'name': 'Alex',
    'age': '16',
    'phone': '9090909090',
    'location': "BLR",
    'image': "https://fastly.picsum.photos/id/351/300/200.jpg?hmac=FKrLuzw81mZ_CqcRWthUXXe88wCF2d1rqAfUK-VVBZ4",
  },
  "ui": '''
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
    ''',
};
