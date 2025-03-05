import 'package:edudash_admin/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class CreateGamePage extends StatefulWidget {
  const CreateGamePage({
    super.key,
  });

  @override
  State<CreateGamePage> createState() => _CreateGamePageState();
}

class _CreateGamePageState extends State<CreateGamePage> {
  late Map<String, dynamic> quizObj;
  late List<Map<String, dynamic>> fillers;

  final titleText = TextEditingController();
  var selectedSubj = "English";

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

    fillers = [];
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
          "Create Game",
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
                'title' : titleText.text,
                'subject' : selectedSubj,
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
              
              final error = await FireStoreService().addCustomGame(quizObj);
              
              if(error == null) {
                Navigator.of(context).pop();
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
              controller: titleText,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: "Quiz Title"
              ),
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
              initialSelection: 'English',
              textStyle: Theme.of(context).textTheme.bodySmall,
              onSelected: (value) {
                setState(() {
                  selectedSubj = value!;
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
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          style: Theme.of(context).textTheme.bodyMedium,
                          controller: fillers[index]['question']
                        ),
                        RadioListTile(
                          value: 'a',
                          groupValue: fillers[index]["correct_answer"],
                          onChanged: (value) {
                            setState(() {
                              fillers[index]["correct_answer"] = value;
                            });
                          },
                          title: TextField(
                            style: Theme.of(context).textTheme.bodySmall,
                            controller:  fillers[index]['choice_a']
                          )
                        ),
                        RadioListTile(
                          value: 'b',
                          groupValue: fillers[index]["correct_answer"],
                          onChanged: (value) {
                            setState(() {
                              fillers[index]["correct_answer"] = value;
                            });
                          },
                          title: TextField(
                            style: Theme.of(context).textTheme.bodySmall,
                            controller:  fillers[index]['choice_b']
                          )
                        ),
                        RadioListTile(
                          value: 'c',
                          groupValue: fillers[index]["correct_answer"],
                          onChanged: (value) {
                            setState(() {
                              fillers[index]["correct_answer"] = value;
                            });
                          },
                          title: TextField(
                            style: Theme.of(context).textTheme.bodySmall,
                            controller:  fillers[index]['choice_c']
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