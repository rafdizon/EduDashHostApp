import 'package:edudash_admin/pages/dashboard_page.dart';
import 'package:edudash_admin/pages/edit_game_page.dart';
import 'package:edudash_admin/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GameViewPage extends StatefulWidget {
  final Map<String, dynamic> data;
  const GameViewPage({
    super.key,
    required this.data
  });

  @override
  State<GameViewPage> createState() => _GameViewPageState();
}

class _GameViewPageState extends State<GameViewPage> {
  late String title;
  late String quizId;
  late List<Map<String, dynamic>> quizList;
  
  @override
  void initState() {
    super.initState();
    title = widget.data["title"].toString();
    quizList = widget.data["quiz"] as List<Map<String, dynamic>>;
    quizId = widget.data["id"].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(), 
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          )
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
        ),
        actions: [
          PopupMenuButton(
            iconColor: Colors.white,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'Edit', 
                  child: Text('Edit Game'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditGamePage(data: widget.data,)
                      )
                    );
                  },
                ),
                PopupMenuItem(
                  value: 'Delete', 
                  child: Text('Delete Game'),
                  onTap: () async {
                    final error = await FireStoreService().deleteGame(docId: quizId);
                    if(error == null) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const DashboardPage()
                        )
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: error,
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.SNACKBAR,
                        backgroundColor: Colors.black87,
                        textColor: Colors.white,
                        fontSize: 12,
                      );
                    }
                  },
                ),
              ];
            }
          )
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: quizList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          quizList[index]["question"].toString()
                        ),
                        RadioListTile(
                          value: "a", 
                          groupValue: quizList[index]["correct_answer"].toString(), 
                          onChanged: null,
                          title: Text(
                            quizList[index]["choice_a"].toString(),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        RadioListTile(
                          value: "b", 
                          groupValue: quizList[index]["correct_answer"].toString(), 
                          onChanged: null,
                          title: Text(
                            quizList[index]["choice_b"].toString(),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        RadioListTile(
                          value: "c", 
                          groupValue: quizList[index]["correct_answer"].toString(), 
                          onChanged: null,
                          title: Text(
                            quizList[index]["choice_c"].toString(),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}