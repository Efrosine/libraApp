import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/entity/book_entity.dart';
import 'package:myapp/entity/lending_entity.dart';
import 'package:myapp/service/api_service.dart';

class CrudLendingPage extends StatefulWidget {
  const CrudLendingPage(
      {super.key,
      this.option = 'create',
      this.initData = const LendingEntity.empty()});

  final String option;
  final LendingEntity initData;

  @override
  State<CrudLendingPage> createState() => _CrudLendingPageState();
}

class _CrudLendingPageState extends State<CrudLendingPage> {
  final apiService = ApiService();
  LendingEntity initData = LendingEntity.empty();
  late TextEditingController lentAtController;
  late TextEditingController returnedAtController;
  late TextEditingController notesController;
  int? userId;
  int? bookId;
  late LendStatus status;
  List<int> booksId = [], usersId = [];

  Future<void> executable(LendingEntity data) async {
    String msg = '';
    try {
      if (widget.option == 'create') {
        msg = await apiService.createLending(data);
      } else {
        msg = await apiService.updateLending(data);
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> getIds() async {
    try {
      var data = await apiService.getIdBookUser();
      setState(() {
        usersId = (data['users'] as List)
            .map(
              (e) => e as int,
            )
            .toList();
        booksId = (data['books'] as List)
            .map(
              (e) => e as int,
            )
            .toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  void initState() {
    super.initState();
    print('initsatte');
    getIds();
    initData = widget.initData;
    lentAtController = TextEditingController(text: initData.lentAt);
    returnedAtController = TextEditingController(text: initData.returnedAt);
    notesController = TextEditingController(text: initData.notes);
    userId = initData.userId;
    bookId = initData.book?.id;
    status = initData.status ?? LendStatus.pending;
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    final double widthScreen = MediaQuery.of(context).size.width;
    if (usersId.isEmpty || booksId.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('CRUD Lending')),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('CRUD Lending')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {
                0: FixedColumnWidth(widthScreen / 4),
              },
              children: [
                TableRow(
                  children: [
                    const Text('User ID'),
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: EdgeInsets.only(right: widthScreen / 3),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        child: DropdownButton<int>(
                          value: userId ?? usersId.first,
                          items: usersId
                              .map(
                                (e) => DropdownMenuItem<int>(
                                  value: e as int,
                                  child: Text(e.toString()),
                                ),
                              )
                              .toList(),
                          onChanged: widget.option != 'create'
                              ? null
                              : (value) => setState(() {
                                    userId = value!;
                                  }),
                          underline: Container(),
                          isExpanded: true,
                        ),
                      ),
                    )
                  ],
                ),
                TableRow(
                  children: [
                    const Text('Book ID'),
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: EdgeInsets.only(right: widthScreen / 3),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        child: DropdownButton<int>(
                          value: bookId ?? booksId.first,
                          items: booksId
                              .map(
                                (e) => DropdownMenuItem<int>(
                                  value: e,
                                  child: Text(e.toString()),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              bookId = value!;
                            });
                          },
                          underline: Container(),
                          isExpanded: true,
                        ),
                      ),
                    )
                  ],
                ),
                TableRow(
                  children: [
                    const Text('Lend At'),
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: TextField(
                        controller: lentAtController,
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        onTap: () {
                          showBoardDateTimePicker(
                            context: context,
                            pickerType: DateTimePickerType.datetime,
                          ).then(
                            (value) {
                              String temp =
                                  DateFormat('yyyy-MM-dd HH:mm:ss').format(
                                value ?? DateTime.now(),
                              );
                              lentAtController.text = temp;
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Text('Status'),
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: EdgeInsets.only(right: widthScreen / 3),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        child: DropdownButton<LendStatus>(
                          value: status,
                          items: LendStatus.values
                              .map(
                                (e) => DropdownMenuItem<LendStatus>(
                                  value: e,
                                  child: Text(e.name),
                                ),
                              )
                              .toList(),
                          onChanged: (value) => setState(() {
                            status = value!;
                          }),
                          underline: Container(),
                          isExpanded: true,
                        ),
                      ),
                    )
                  ],
                ),
                TableRow(
                  children: [
                    const Text('Returned At'),
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: TextField(
                        controller: returnedAtController,
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        onTap: () {
                          showBoardDateTimePicker(
                            context: context,
                            pickerType: DateTimePickerType.datetime,
                          ).then(
                            (value) => returnedAtController.text =
                                DateFormat('yyyy-MM-dd HH:mm:ss').format(
                              value ?? DateTime.now(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Text('Notes'),
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: TextField(
                        controller: notesController,
                        maxLines: 5,
                        maxLength: 255,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                  onPressed: () {
                    var result = LendingEntity(
                      id: initData.id,
                      userId: userId ?? usersId.first,
                      book: BookEntity(id: bookId ?? booksId.first),
                      lentAt: lentAtController.text,
                      status: status,
                      returnedAt: returnedAtController.text,
                      notes: notesController.text.isEmpty == false
                          ? notesController.text
                          : '',
                    );
                    print(
                        'result : ${result.toString()},${result.notes.runtimeType}');
                    executable(result);
                  },
                  child: Text('Save')),
            ),
          ],
        ),
      ),
    );
  }
}
