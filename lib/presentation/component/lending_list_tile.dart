import 'package:flutter/material.dart';
import 'package:myapp/entity/lending_entity.dart';
import 'package:myapp/presentation/page/crud_lending_page.dart';

class LendingListTile extends StatelessWidget {
  const LendingListTile({
    super.key,
    required this.lendData, required this.onDelete,
  });

  final LendingEntity lendData;
 final Function() onDelete; 
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: Container(
        color: lendData.status?.color??Colors.black,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lendData.book?.title??'no Title',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Text('Lended at: ${lendData.lentAt}'),
                    Text('Status: ${lendData.status?.name}'),
                    Text('Returned at: ${lendData.returnedAt}'),
                    Text('Notes: ${lendData.notes}'),
                    Row(
                      children: [
                        IconButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CrudLendingPage(option: 'update', initData: lendData,)));
                        }, icon: const Icon(Icons.edit)),
                        IconButton(onPressed: onDelete, icon: const Icon(Icons.delete)),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: Image.network(
                  lendData.book?.imageUrl??'',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
