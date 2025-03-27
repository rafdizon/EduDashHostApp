import 'package:edudash_admin/pages/game_view_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GameDetailesPage extends StatefulWidget {
  final Map<String,dynamic> data;
  const GameDetailesPage({
    super.key,
    required this.data
  });

  @override
  State<GameDetailesPage> createState() => _GameDetailesPageState();
}

class _GameDetailesPageState extends State<GameDetailesPage> {
  late String title;
  late String keyCode;
  late String subject;
  late String dateModified;
  late List<Map<dynamic, dynamic>> players;

  late List<DataRow> rows;
  bool sort = false;
  int sortIndex = 0;

  @override
  void initState() {
    super.initState();
    title = widget.data["title"].toString();
    keyCode = widget.data["id"].toString();
    subject = widget.data["subject"].toString();
    dateModified = DateFormat('yyyy-MM-dd HH:mm').format(widget.data["date_modified"].toDate());
    players = widget.data["players"] as List<Map<dynamic, dynamic>>;

    rows = [];
    for (int i = 0; i < players.length; i++){
      rows.add(
        DataRow(
          cells: [
            DataCell(Text(players[i]["username"].toString())),
            DataCell(Text(players[i]["score"].toString()))
          ]
        )
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(), 
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          )
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Game Code: $keyCode',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10,),
            Text(
              'Subject: $subject',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 10,),
            Text(
              'Last Modified: $dateModified',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 10,),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return GameViewPage(data: widget.data);
                      }
                    )
                  );
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  minimumSize: const Size(double.infinity, 20)
                ),
                child: Text(
                  'View Game',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              '${players.length} players',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    headingRowColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
                    headingTextStyle: TextStyle(color: Colors.white),
                    sortAscending: sort,
                    sortColumnIndex: sortIndex,
                    columns: [
                      DataColumn(
                        label: const Text('Username'),
                        onSort: (index, ascending) {
                          setState(() {
                            sort = !sort;
                            sortIndex = index;

                            players.sort((a,b) => sort ? a['player'].compareTo(b['player']) : b['player'].compareTo(a['player']));
                          });
                        }
                      ),
                      DataColumn(
                        label: const Text('Score'),
                        onSort: (index, ascending) {
                          setState(() {
                            sort = !sort;
                            sortIndex = index;

                            players.sort((a,b) => sort ? a['score'].compareTo(b['score']) : b['score'].compareTo(a['score']));
                          });
                        }
                      )
                    ], 
                    rows: rows,
                    dataTextStyle: Theme.of(context).textTheme.bodySmall
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}