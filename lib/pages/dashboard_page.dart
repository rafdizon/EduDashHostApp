import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edudash_admin/services/auth.dart';
import 'package:edudash_admin/dummy_data.dart';
import 'package:edudash_admin/pages/create_game_page.dart';
import 'package:edudash_admin/pages/game_details_page.dart';
import 'package:edudash_admin/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(), 
              icon: const Icon(Icons.menu, color: Colors.white,)
            );
          }
        ),
        title: const Text(
          'EduDash Host App',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.normal
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: GestureDetector(
          onTap: () async {
            await Auth().signOut();
          },
          child: Row(
            children: [
              Icon((Icons.logout)),
              Text(
                'Logout'
              )
            ],
          ),
        )
      ),
      body: FutureBuilder(
        future: Auth().getCurrentUserID(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final userId = snapshot.data;

          return StreamBuilder<QuerySnapshot>(
            stream: FireStoreService().getCustomQuizzes(userId!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final streamData = snapshot.data!.docs.map((docs) {
                return {
                  'id' : docs.id,
                  'host_id' : docs['host_id'],
                  'title' : docs['title'],
                  'date_modified' : docs['date_modified'],
                  'is_active' : docs['is_active'],
                  'players' : (docs['players'] as List<dynamic>).map((p) => p as Map<String, dynamic>).toList(),
                  'quiz' : (docs['quiz'] as List<dynamic>).map((q) => q as Map<String, dynamic>).toList(),
                  'subject' : docs['subject'],
                };
              }).toList();
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CreateGamePage()
                          )
                        );
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
                            'Create New Game',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: streamData.length,
                      itemBuilder: (context, index){
                        final data = streamData[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return GameDetailesPage(data: data,);
                                }
                              )
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16, 
                                vertical: 20
                              ),
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data["title"].toString(),
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                    data['id'].toString(),
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    data["subject"].toString(),
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                  Text(
                                    (data["players"] as List).length.toString(),
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                  Text(
                                    DateFormat('yyyy-MM-dd HH:mm').format(data["date_modified"].toDate()),
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    
                    ),
                  )
                ],
              );
            }
          );
        },
        
      ),
    );
  }
}