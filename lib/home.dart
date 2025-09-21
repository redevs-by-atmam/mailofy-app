// import 'package:flutter/material.dart';
// import 'package:mailofly_android/screens/accounts.dart';
// import 'package:mailofly_android/screens/campaigns.dart';
// import 'package:mailofly_android/screens/list_view.dart';
// import 'package:mailofly_android/screens/login.dart';
// import 'package:mailofly_android/screens/profile.dart';
// import 'package:mailofly_android/screens/templates.dart';
// import 'package:mailofly_android/screens/usage.dart';
// import 'package:mailofly_android/services/api_service.dart';
// import 'package:mailofly_android/services/user_service.dart';
// import 'package:mailofly_android/supabase/types/functions/user_profile_details.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// // New Comments added
// // checking by sanat
// class Home extends StatefulWidget {
//   const Home({super.key});
//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   late UserProfileDetails user;

//   void logout(BuildContext context) async {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => LoginPage()),
//     );
//   }

//   @override
//   void initState() {
//     Future.microtask(() async {
//       final api = ApiClient();
//       final userService = UserService(api);
//       final response = await userService.getUserDetails();
//       if (response.success) user = response.data!;
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final session = Supabase.instance.client.auth.currentSession;
//     // final accessToken = session?.accessToken ?? 'Not available';
//     final email = session?.user.email ?? 'Unknown';

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Mailofly',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () => logout(context),
//             icon: const Icon(Icons.logout_outlined),
//           ),
//         ],
//       ),

//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             // DrawerHeader(
//             //   decoration: const BoxDecoration(color: Colors.blue),
//             //   child: Text(
//             //     'MailoFly',
//             //     style: const TextStyle(color: Colors.white, fontSize: 20),
//             //   ),

//             // ),
//             UserAccountsDrawerHeader(
//               decoration: const BoxDecoration(color: Colors.blue),
//               accountName: Text('Test Account'),
//               accountEmail: Text('mailoFly@gmail.com'),
//               currentAccountPicture: CircleAvatar(
//                 backgroundColor: Colors.white,
//                 child: Icon(Icons.person, size: 40, color: Colors.blue),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(18, 8, 0, 4),
//               child: Text(
//                 "ANALYTICS",
//                 style: TextStyle(
//                   color: Colors.grey,
//                   letterSpacing: 1.0,
//                   fontWeight: FontWeight.w100,
//                   fontSize: 10,
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.home),
//               title: const Text('Home'),
//               onTap: () => Navigator.pop(context),
//             ),
//             ListTile(
//               leading: const Icon(Icons.person),
//               title: const Text("Accounts"),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const AccountsPage()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.person),
//               title: const Text('Templates'),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const TemplatesPage()),
//                 );
//               },
//             ),

//             ListTile(
//               leading: const Icon(Icons.person),
//               title: const Text('Campaigns'),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const CampaignsPage()),
//                 );
//               },
//             ),
//             Padding(
//               padding: EdgeInsets.fromLTRB(18, 8, 0, 4),
//               child: Text(
//                 'ACCOUNT',
//                 style: TextStyle(
//                   color: Colors.grey,
//                   letterSpacing: 1.0,
//                   fontWeight: FontWeight.w100,
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.person),
//               title: const Text("Usage"),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const usage_Page()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.dock_outlined),
//               title: const Text("Billing"),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const usage_Page()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           ProfileCard(email: email),
//           Expanded(child: CustomListView()),
//         ],
//       ),
//     );
//   }
// }

// class ProfileCard extends StatefulWidget {
//   final String email;
//   const ProfileCard({super.key, required this.email});

//   @override
//   State<ProfileCard> createState() => _ProfileCardState();
// }

// class _ProfileCardState extends State<ProfileCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 120,

//       margin: const EdgeInsets.all(16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 96, 167, 238),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
//       ),
//       child: Row(
//         children: [
//           const CircleAvatar(
//             radius: 32,
//             backgroundColor: Colors.white,
//             child: Icon(Icons.person, size: 40, color: Colors.lightBlue),
//           ),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       "Test Account",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 8,
//                         vertical: 2,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       child: Text(
//                         "Pro",
//                         style: TextStyle(
//                           color: Colors.lightBlue,
//                           fontSize: 13,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   widget.email,
//                   style: TextStyle(color: Colors.white70, fontSize: 14),
//                 ),
//                 SizedBox(height: 8),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: Colors.green,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(Icons.check_circle, color: Colors.white, size: 16),
//                       SizedBox(width: 4),
//                       Text(
//                         "active",
//                         style: TextStyle(color: Colors.white, fontSize: 12),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:mailofly_android/screens/accounts.dart';
import 'package:mailofly_android/screens/campaigns.dart';
import 'package:mailofly_android/screens/list_view.dart';
import 'package:mailofly_android/screens/login.dart';
// ignore: unused_import
import 'package:mailofly_android/screens/profile.dart';
import 'package:mailofly_android/screens/templates.dart';
import 'package:mailofly_android/screens/usage.dart';
import 'package:mailofly_android/services/api_service.dart';
import 'package:mailofly_android/services/user_service.dart';
import 'package:mailofly_android/supabase/types/functions/user_profile_details.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// New Comments added
// checking by sanat
class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late UserProfileDetails user;

  void logout(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
  }

  @override
  void initState() {
    Future.microtask(() async {
      final api = ApiClient();
      final userService = UserService(api);
      final response = await userService.getUserDetails();
      if (response.success) user = response.data!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;
    // final accessToken = session?.accessToken ?? 'Not available';
    final email = session?.user.email ?? 'Unknown';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mailofly',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () => logout(context),
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),

      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // DrawerHeader(
                  //   decoration: const BoxDecoration(color: Colors.blue),
                  //   child: Text(
                  //     'MailoFly',
                  //     style: const TextStyle(color: Colors.white, fontSize: 20),
                  //   ),

                  // ),
                  UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(color: Colors.blue),
                    accountName: Text('Test Account'),
                    accountEmail: Text('mailoFly@gmail.com'),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 40, color: Colors.blue),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 8, 0, 4),
                    child: Text(
                      "ANALYTICS",
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w100,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text("Accounts"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AccountsPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Templates'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TemplatesPage(),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Campaigns'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CampaignsPage(),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(18, 8, 0, 4),
                    child: Text(
                      'ACCOUNT',
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w100,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text("Usage"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const usage_Page()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.dock_outlined),
                    title: const Text("Billing"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const usage_Page()),
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              alignment: Alignment.center,
              child: const Text(
                'All rights reserved @ reDevs 2024',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 0.9,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          ProfileCard(email: email),
          Expanded(child: CustomListView()),
          Footer(),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class ProfileCard extends StatefulWidget {
  final String email;
  const ProfileCard({super.key, required this.email});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,

      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 96, 167, 238),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 32,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 40, color: Colors.lightBlue),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Test Account",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "Pro",
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  widget.email,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text(
                        "active",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 18),
        Text(
          "What you'll be able to track",
          style: TextStyle(
            color: const Color.fromARGB(255, 88, 84, 84),
            fontWeight: FontWeight.w100,
            letterSpacing: 0.2,
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _TrackingCard(icon: Icons.show_chart, label: "Performance"),
            _TrackingCard(icon: Icons.auto_graph, label: "Engagement"),
            _TrackingCard(icon: Icons.groups, label: "Audience"),
          ],
        ),
        SizedBox(height: 10),
        Text(
          'All rights reserved @ reDevs 2025',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w100,
            fontSize: 10,
            letterSpacing: 0.9,
          ),
        ),
      ],
    );
  }
}

class _TrackingCard extends StatelessWidget {
  final IconData icon;
  final String label;
  const _TrackingCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 80,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 91, 175, 243),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: Colors.purple),
          SizedBox(height: 0),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
