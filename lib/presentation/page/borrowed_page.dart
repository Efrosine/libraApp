import 'package:flutter/material.dart';
import 'package:myapp/entity/lending_entity.dart';
import 'package:myapp/presentation/component/lending_list_tile.dart';
import 'package:myapp/presentation/page/crud_lending_page.dart';
import 'package:myapp/service/api_service.dart';

class BorrowedPage extends StatefulWidget {
  const BorrowedPage({super.key});

  @override
  State<BorrowedPage> createState() => _BorrowedPageState();
}

class _BorrowedPageState extends State<BorrowedPage> {
  final apiService = ApiService();
  late Future<List<LendingEntity>> userLendings;
  String role = 'user';

  @override
  void initState() {
    userLendings = apiService.getUserLending();
    getRole();
    super.initState();
  }

  Future<void> getRole() async {
    role = await apiService.getRole() ?? 'user';
    setState(() {});
  }

  void onDelete(int id) async {
    String msg = '';
    try {
      msg = await apiService.deleteLending(id);
      // setState(() {});
    } catch (e) {
      msg = e.toString();
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Borrowed Books')),
      floatingActionButton: role == 'admin'
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CrudLendingPage(),
                    ));
              },
              child: const Icon(Icons.add),
            )
          : null,
      body: FutureBuilder<List<LendingEntity>>(
        future: userLendings,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No books available"));
          } else {
            final lendData = snapshot.data!;
            return ListView.separated(
              itemCount: lendData.length,
              padding: const EdgeInsets.all(10),
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) => LendingListTile(
                lendData: lendData[index],
                onDelete: () {
                  if (lendData[index].id != null) onDelete(lendData[index].id!);
                },
              ),
            );
          }
        },
      ),
    );
  }
}
