import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListView Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListViews(),
    );
  }
}

class ListViews extends StatelessWidget {
  final List<Person> people = [
    Person(firstName: 'John', lastName: 'Doe', username: 'jdoe', email: 'jdoe@example.com'),
    Person(firstName: 'Jane', lastName: 'Smith', username: 'jsmith', email: 'jsmith@example.com'),
    Person(firstName: 'Robert', lastName: 'Johnson', username: 'rjohnson', email: 'rjohnson@example.com'),
    Person(firstName: 'Mary', lastName: 'Williams', username: 'mwilliams', email: 'mwilliams@example.com'),
    Person(firstName: 'Michael', lastName: 'Brown', username: 'mbrown', email: 'mbrown@example.com'),
    Person(firstName: 'Linda', lastName: 'Jones', username: 'ljones', email: 'ljones@example.com'),
    Person(firstName: 'William', lastName: 'Garcia', username: 'wgarcia', email: 'wgarcia@example.com'),
    Person(firstName: 'Elizabeth', lastName: 'Martinez', username: 'emartinez', email: 'emartinez@example.com'),
    Person(firstName: 'David', lastName: 'Rodriguez', username: 'drodriguez', email: 'drodriguez@example.com'),
    Person(firstName: 'Jennifer', lastName: 'Martinez', username: 'jmartinez', email: 'jmartinez@example.com'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Example'),
      ),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text('${person.firstName} ${person.lastName}'),
            subtitle: Text('Username: ${person.username}\nEmail: ${person.email}'),
          );
        },
      ),
    );
  }
}

class Person {
  final String firstName;
  final String lastName;
  final String username;
  final String email;

  Person({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
  });
}
