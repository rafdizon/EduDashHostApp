import 'package:edudash_admin/dummy_data.dart';
import 'package:edudash_admin/pages/dashboard_page.dart';
import 'package:edudash_admin/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class EditGamePage extends StatefulWidget {
  final Map<String, dynamic>? data;
  const EditGamePage({
    super.key,
    this.data
  });

  @override
  State<EditGamePage> createState() => _EditGamePageState();
}

class _EditGamePageState extends State<EditGamePage> {
  late List<Map<String, dynamic>> quizList = [];
  late List<Map<String, dynamic>> fillers = [];
  late Map<String, dynamic> quizObj;
  late TextEditingController title;
  late String subject;
  late String quizId;

  void addItem() {
    setState(() {
      fillers.add({
        'question' : TextEditingController(),
        'choice_a' : TextEditingController(),
        'choice_b' : TextEditingController(),
        'choice_c' : TextEditingController(),
        'correct_answer' : null
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quizList = (widget.data?["quiz"] as List<Map<String,dynamic>>?) ?? [];
    title = TextEditingController(text: (widget.data?["title"] as String?) ?? "");
    subject = (widget.data?["subject"] as String?) ?? "English";
    quizId = widget.data?["id"];
    
    fillers = quizList.map((item) => {
      'question' : TextEditingController(text: item['question']),
      'choice_a' : TextEditingController(text: item['choice_a']),
      'choice_b' : TextEditingController(text: item['choice_b']),
      'choice_c' : TextEditingController(text: item['choice_c']),
      'correct_answer' : item['correct_answer']
    }).toList();
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
          "Edit Game",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.normal
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              quizObj = {
                'title' : title.text,
                'subject' : subject,
                'is_active' : true,
                'players' : [],
                'quiz' : fillers.map((item) => {
                  'question' : item['question'].text,
                  'choice_a' : item['choice_a'].text,
                  'choice_b' : item['choice_b'].text,
                  'choice_c' : item['choice_c'].text,
                  'correct_answer' : item['correct_answer']
                }).toList()
              };

              final error = await FireStoreService().editCustomeGame(quizObj, docId: quizId);
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
            child: Text('Save', style: TextStyle(color: Colors.white),),
          )
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                
              ),
              controller: title,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: DropdownMenu(
              dropdownMenuEntries: const [
                DropdownMenuEntry(value: 'English', label: 'English'),
                DropdownMenuEntry(value: 'Filipino', label: 'Filipino'),
                DropdownMenuEntry(value: 'Math', label: 'Mathematics'),
                DropdownMenuEntry(value: 'Other', label: 'Other...'),
              ],
              initialSelection: subject,
              textStyle: Theme.of(context).textTheme.bodySmall,
              onSelected: (value) {
                setState(() {
                  subject = value!;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: fillers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                style: Theme.of(context).textTheme.bodyMedium,
                                controller: fillers[index]['question'],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  fillers.removeAt(index);
                                });
                              }, 
                              icon: const Icon(Icons.delete, color: Colors.red,)
                            )
                          ],
                        ),
                        RadioListTile(
                          value: "a",
                          groupValue: fillers[index]["correct_answer"],
                          onChanged: (value) {
                            setState(() {
                              fillers[index]["correct_answer"] = "a";
                            });
                          },
                          title: TextField(
                            style: Theme.of(context).textTheme.bodySmall,
                            controller: fillers[index]['choice_a'],
                          )
                        ),
                        RadioListTile(
                          value: "b", 
                          groupValue: fillers[index]["correct_answer"],
                          onChanged: (value) {
                            setState(() {
                              fillers[index]["correct_answer"] = "b";
                            });
                          },
                          title: TextField(
                            style: Theme.of(context).textTheme.bodySmall,
                            controller: fillers[index]['choice_b'],
                          )
                        ),
                        RadioListTile(
                          value: "c",
                          groupValue: fillers[index]["correct_answer"],
                          onChanged: (value) {
                            setState(() {
                              fillers[index]["correct_answer"] = "c";
                            });
                          },
                          title: TextField(
                            style: Theme.of(context).textTheme.bodySmall,
                            controller: fillers[index]['choice_c'],
                          )
                        ),
                      ],
                    ),
                  ),
                );
              }
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                addItem();
              });
            }, 
            style: TextButton.styleFrom(
              backgroundColor: Colors.black12,
              minimumSize: Size(double.infinity, 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add),
                Text(
                  'Add New Question',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}