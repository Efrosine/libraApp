import 'package:flutter/material.dart';
import 'package:myapp/entity/user_entity.dart';
import 'package:myapp/presentation/page/signin_page.dart';
import 'package:myapp/service/api_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final apiService = ApiService();
  late Future<UserEntity> user;

  @override
  void initState() {
    user = apiService.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Profile'), actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignInPage(),
                  ),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.logout))
        ]),
        body: FutureBuilder(
          future: user,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData) {
              return const Center(child: Text("No books available"));
            } else {
              final userData = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage('https://picsum.photos/200'),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      userData.name,
                      style:
                          const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    DefaultTextStyle(
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 18),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8)),
                        child: Table(
                          columnWidths: const {
                            0: FixedColumnWidth(100),
                            1: FlexColumnWidth(),
                          },
                          children: [
                            TableRow(children: [
                              const Text('Role'),
                              Text(userData.role),
                            ]),
                            TableRow(children: [
                              const Text('Email'),
                              Text(userData.email),
                            ]),
                            TableRow(children: [
                              const Text('Address'),
                              Text(userData.address),
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }
}
