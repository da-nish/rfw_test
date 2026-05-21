import 'package:flutter/material.dart';
import 'package:rfw/formats.dart';
import 'package:rfw/rfw.dart';
import 'package:test_stac/asset_view/asset_view.dart';
import 'package:test_stac/common/text_field.dart';
import 'package:test_stac/common/user_card.dart';
import 'package:test_stac/data/home_content.dart';
import 'package:test_stac/dynamic_screen/placeholder_1.dart';
import 'package:test_stac/example/example4.dart';
import 'package:test_stac/dynamic_screen/placeholder_2.dart';
import 'package:test_stac/dynamic_screen/placeholder_3.dart';

class FintechHomeScreen extends StatefulWidget {
  const FintechHomeScreen({super.key});

  @override
  State<FintechHomeScreen> createState() => _FintechHomeScreenState();
}

class _FintechHomeScreenState extends State<FintechHomeScreen> {
  final Runtime runtime = Runtime();
  final DynamicContent data = DynamicContent();

  bool get hasUI => (homeContent["ui"] ?? "").isNotEmpty;

  @override
  void initState() {
    super.initState();


    if(!hasUI){return;}

    /// Register core widgets
    runtime.update(const LibraryName(['core', 'widgets']), createCoreWidgets());

    /// Register material widgets
    runtime.update(const LibraryName(['material']), createMaterialWidgets());

    /// Register LOCAL widgets
    runtime.update(
      const LibraryName(['local']),
      LocalWidgetLibrary({
        'UserCard': (BuildContext context, DataSource source) {
          return UserCard(
            name: source.v<String>(['name']) ?? '',
            onTap:
                source.voidHandler(['onTap']) ??
                () {
                  print("====> ${source}");
                },
          );
        },
        'AppTextField': (BuildContext context, DataSource source) {
          return AppTextField(
            controller: emailController,
            label: source.v<String>(['label']) ?? '',
            hintText: source.v<String>(['name']) ?? '',
            onChanged: (value) {
              debugPrint("RFW onChanged: $value");
              final handler = source.voidHandler(['onChanged']);
              // handler();
            },
          );
        },
        'LastWeekView': (BuildContext context, DataSource source) {
          return LastWeekView(
            text: source.v<String>(['text']) ?? '', 
            value: source.v<String>(['value']) ?? ''
            );
        },
        'AppSpace': (context, source) {
          final h = source.v<double>(['height']) ?? 0;

            return AppSpace(height: h);
          },
      }),
    );

    /// Dynamic string UI
    
    String ui = homeContent["ui"];

    /// Parse UI string
    runtime.update(const LibraryName(['main']), parseLibraryFile(ui));

    /// Dynamic data
    data.update('user', homeContent["params"]);

  }

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Welcome Back",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Alex Morgan",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white12,
                    child: Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              if (hasUI)
              const SizedBox(height: 20),
              if (hasUI)
              RemoteWidget(
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
                    Navigator.push(
                    context,
                    // MaterialPageRoute(builder: (context) => DynamicListPage()),
                    MaterialPageRoute(builder: (context) => Placeholder1()),
                  );
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     content: Text('Clicked User ${arguments['userId']}'),
                    //   ),
                    // );
                  }
                  else  if (name == 'search_card_clicked') {
                    Navigator.push(
                    context,
                    // MaterialPageRoute(builder: (context) => DynamicListPage()),
                    MaterialPageRoute(builder: (context) => DynamicListPage2()),
                  );}
                },
              ),

              // const SizedBox(height: 28),

              // BALANCE CARD
              // Container(
              //   padding: const EdgeInsets.all(24),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(28),
              //     gradient: const LinearGradient(
              //       colors: [Color(0xFF7C3AED), Color(0xFF4F46E5)],
              //     ),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       const Text(
              //         "Total Balance",
              //         style: TextStyle(color: Colors.white70, fontSize: 16),
              //       ),
              //       const SizedBox(height: 12),
              //       const Text(
              //         "\$24,680.50",
              //         style: TextStyle(
              //           fontSize: 36,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.white,
              //         ),
              //       ),
              //       const SizedBox(height: 24),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           _buildSmallStat(
              //             title: "Income",
              //             value: "+\$8,240",
              //             icon: Icons.arrow_downward_rounded,
              //             color: Colors.greenAccent,
              //           ),
              //           _buildSmallStat(
              //             title: "Expense",
              //             value: "-\$1,420",
              //             icon: Icons.arrow_upward_rounded,
              //             color: Colors.redAccent,
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),

              const SizedBox(height: 28),

              // QUICK ACTIONS
              const Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _actionButton(Icons.send_rounded, "Send", null),
                  _actionButton(
                    Icons.account_balance_wallet_rounded,
                    "Wallet",
                    null,
                  ),
                  _actionButton(Icons.qr_code_scanner_rounded, "Scan", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DynamicListPage2()),
                      // MaterialPageRoute(builder: (context) => RfwImagePage()),
                    );
                  }),
                  _actionButton(Icons.more_horiz_rounded, "More", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DynamicListPage()),
                      // MaterialPageRoute(
                      //   builder: (context) => FixedInfiniteList(),
                      // ),
                    );
                  }),
                ],
              ),

              // const SizedBox(height: 32),

              // INVESTMENTS
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: const [
              //     Text(
              //       "Investment Portfolio",
              //       style: TextStyle(
              //         fontSize: 20,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.grey,
              //       ),
              //     ),
              //     Text(
              //       "See all",
              //       style: TextStyle(color: Colors.deepPurpleAccent),
              //     ),
              //   ],
              // ),

              // const SizedBox(height: 18),

              // Container(
              //   padding: const EdgeInsets.all(20),
              //   decoration: BoxDecoration(
              //     color: const Color(0xFF1E293B),
              //     borderRadius: BorderRadius.circular(24),
              //   ),
              //   child: Column(
              //     children: [
              //       _investmentTile(
              //         name: "Bitcoin",
              //         symbol: "BTC",
              //         value: "\$12,420",
              //         growth: "+4.2%",
              //         color: Colors.orange,
              //       ),
              //       const SizedBox(height: 18),

              //       _investmentTile(
              //         name: "Ethereum",
              //         symbol: "ETH",
              //         value: "\$8,120",
              //         growth: "+2.8%",
              //         color: Colors.purpleAccent,
              //       ),
              //       const SizedBox(height: 18),

              //       _investmentTile(
              //         name: "Apple",
              //         symbol: "AAPL",
              //         value: "\$4,380",
              //         growth: "-1.1%",
              //         color: Colors.blueAccent,
              //       ),
              //     ],
              //   ),
              // ),

              // const SizedBox(height: 32),

              // CARDS SECTION
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Your Cards",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              SizedBox(
                height: 190,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _creditCard(
                      color1: const Color(0xFF06B6D4),
                      color2: const Color(0xFF3B82F6),
                      number: "**** 4821",
                      holder: "Alex Morgan",
                    ),
                    const SizedBox(width: 16),
                    _creditCard(
                      color1: const Color(0xFFF59E0B),
                      color2: const Color(0xFFEF4444),
                      number: "**** 9824",
                      holder: "Alex Morgan",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // TRANSACTIONS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Recent Transactions",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "View all",
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              _transactionTile(
                icon: Icons.shopping_bag_rounded,
                title: "Dribbble Pro",
                subtitle: "Subscription",
                amount: "- \$19.00",
                color: Colors.pinkAccent,
              ),

              _transactionTile(
                icon: Icons.fastfood_rounded,
                title: "Starbucks",
                subtitle: "Coffee",
                amount: "- \$8.50",
                color: Colors.orangeAccent,
              ),

              _transactionTile(
                icon: Icons.attach_money_rounded,
                title: "Salary",
                subtitle: "Monthly Income",
                amount: "+ \$3,200",
                color: Colors.greenAccent,
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildSmallStat({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white24,
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white70)),
            Text(
              value,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Widget _actionButton(
    IconData icon,
    String label,
    VoidCallback? onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  static Widget _creditCard({
    required Color color1,
    required Color color2,
    required String number,
    required String holder,
  }) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "VISA",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.wifi, color: Colors.white),
            ],
          ),
          const Spacer(),
          Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(holder, style: const TextStyle(color: Colors.white70)),
              const Text("09/28", style: TextStyle(color: Colors.white70)),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _transactionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String amount,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.white54)),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: amount.contains("+")
                  ? Colors.greenAccent
                  : Colors.redAccent,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _analyticsItem({
    required String title,
    required String amount,
    required Color color,
  }) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: color.withOpacity(0.2),
          child: Icon(Icons.pie_chart, color: color),
        ),
        const SizedBox(height: 10),
        Text(
          amount,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(color: Colors.white54)),
      ],
    );
  }

  static Widget _investmentTile({
    required String name,
    required String symbol,
    required String value,
    required String growth,
    required Color color,
  }) {
    return Row(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: color.withOpacity(0.2),
          child: Text(
            symbol,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(symbol, style: const TextStyle(color: Colors.white54)),
            ],
          ),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              growth,
              style: TextStyle(
                color: growth.contains("+")
                    ? Colors.greenAccent
                    : Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class LastWeekView extends StatelessWidget {
  const LastWeekView({
    super.key,
    required this.text,
    required this.value,
  });

  final String text;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: const Color.fromARGB(255, 198, 210, 209),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              color: Color.fromARGB(179, 71, 70, 70),
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 75, 75, 75),
            ),
          ),
        ],
      ),
    );
  }
}


class AppSpace extends StatelessWidget {
  final double height;

  const AppSpace({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}