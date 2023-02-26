// ignore_for_file: prefer_const_constructors, unused_import, unused_local_variable, must_be_immutable, use_key_in_widget_constructors
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:practice_api_koko_ratkum/model/team.dart';


// ссылка на АПИ https://app.balldontlie.io/
class HomePage extends StatelessWidget {
  List teams = [];
  

  //get teams
  Future getTeams() async {
    var response = await http.get(Uri.https('balldontlie.io', '/api/v1/teams'));
    var jsonData = jsonDecode(response.body);

    for (var eachTeam in jsonData['data']) {
      final team = Team(
        id: eachTeam['id'],
        full_name: eachTeam['full_name'],
        city: eachTeam['city'],
        
      );
      teams.add(team);
    }
    print(teams.length);
  }

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.purple[700],
        title: Text(' N B A   T E A M S'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getTeams(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: teams.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          leading: Text(
                            teams[index].id.toString(),
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          title: Text(teams[index].full_name),
                          subtitle: Text('CITY: ' + teams[index].city),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
