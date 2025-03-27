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
  bool _isLoading = false;

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
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          )
        ),
        title: Text(
          "Create Game",
          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              setState(() {
                if(!_isLoading) {
                  _isLoading = true;
                } 
              });
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
              
              setState(() {
                if(_isLoading) {
                  _isLoading = false;
                } 
              });

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
            child: _isLoading ? const CircularProgressIndicator(color: Colors.white,) : const Text('Save', style: TextStyle(color: Colors.white),),
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
                DropdownMenuEntry(value: 'Science', label: 'Science'),
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
                          controller: fillers[index]['question'],
                          decoration: const InputDecoration(
                            hintText: "Question",
                            hintStyle: TextStyle(color: Colors.black38)
                          ),
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
                            controller:  fillers[index]['choice_a'],
                            decoration: const InputDecoration(
                              hintText: "Choice A",
                              hintStyle: TextStyle(color: Colors.black38)
                            ),
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
                            controller:  fillers[index]['choice_b'],
                            decoration: const InputDecoration(
                              hintText: "Choice B",
                              hintStyle: TextStyle(color: Colors.black38)
                            ),
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
                            controller:  fillers[index]['choice_c'],
                            decoration: const InputDecoration(
                              hintText: "Choice C",
                              hintStyle: TextStyle(color: Colors.black38)
                            ),
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