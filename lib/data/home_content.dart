final Map<String, dynamic> homeContent = {
  "params": {
    'header1': 'Alex',
    "header2": "Search",
    "lastWeekText": "Last Week PnL",
    "lastWeekValue": "\$1,680.50",
  },
  "ui": '''
      import core.widgets;
      import material;
      import local;

      widget root = Center(
          child: Column(
          children: [
            
            UserCard(
              name: data.user.header1,
              onTap: event "card_clicked" {
                userId: 101,
                message: "Hello from RFW"
              },
            ),
            UserCard(
              name: data.user.header2,
              onTap: event "search_card_clicked" {
                userId: 101,
                message: "Hello from RFW"
              },
            ),

            AppSpace(height: 20.0),
            LastWeekView(
              text: data.user.lastWeekText,
              value: data.user.lastWeekValue,
            )

          ]
        ),
      );
    ''',
};
