import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:marvel/model/persons.dart';
import 'package:marvel/consume_api.dart';

Future main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MARVEL',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const PersonListWidget(),
    );
  }
}

class PersonListWidget extends StatefulWidget {
  const PersonListWidget({Key? key}) : super(key: key);

  @override
  State<PersonListWidget> createState() => _PersonListWidgetState();
}

class _PersonListWidgetState extends State<PersonListWidget> {
  Persons persons = Persons([], 0);
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [],
        title: const Text("MARVEL"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: myController,
              decoration: const InputDecoration(labelText: "Person (ex: Hulk)"),
              onEditingComplete: () => _updateList(myController.text),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: persons.count,
                itemBuilder: ((context, index) => PersonTile(
                      person: persons.persons[index],
                    ))),
          ),
        ],
      ),
    );
  }

  void _updateList(text) {
    findPerson(text,
            publicKey: dotenv.get('public-key'),
            privateKey: dotenv.get('private-key'))
        .then((value) => setState(() => persons = value));
  }
}

class PersonTile extends StatelessWidget {
  const PersonTile({Key? key, required this.person}) : super(key: key);

  final Person person;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        showDialog(
            context: context,
            builder: (_) => Dialog(
                  child: Container(
                    width: 280,
                    height: 420,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage(
                          "${person.thumbnail.path}/portrait_uncanny.${person.thumbnail.extension}"),
                    )),
                  ),
                ));
      },
      title: Text(person.name),
      subtitle: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text("Comics: ${person.numberComics}"),
                Text("Events: ${person.numberEvents}")
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text("Stories: ${person.numberStories}"),
                Text("Series: ${person.numberSeries}")
              ],
            ),
          )
        ],
      ),
      // minVerticalPadding: 30.5,
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(
            "${person.thumbnail.path}/standard_medium.${person.thumbnail.extension}"),
      ),
    );
  }
}
