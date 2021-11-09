import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'components/card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Future fetch() async {
      try {
        var dio = Dio();
        final response = await dio.get(
            'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json');
        var json = jsonDecode(response.data);
        return json['pokemon'];
      } catch (error) {
        return "Erro!";
      }
    }

    _colorForType(String type) {
      if (type == 'Grass') {
        return Colors.greenAccent;
      } else if (type == 'Fire') {
        return Colors.orangeAccent;
      } else if (type == 'Water') {
        return Colors.blueAccent;
      } else if (type == 'Bug') {
        return Colors.lightGreen;
      } else if (type == 'Normal') {
        return Colors.blueGrey;
      } else if (type == 'Poison') {
        return Colors.purpleAccent;
      } else if (type == 'Electric') {
        return Colors.yellowAccent;
      } else if (type == 'Ground') {
        return Colors.brown;
      } else if (type == 'Fighting') {
        return Colors.grey;
      } else if (type == 'Psychic') {
        return Colors.indigo;
      } else if (type == 'Rock') {
        return Colors.teal;
      } else if (type == 'Ghost') {
        return Colors.purple;
      } else if (type == 'Ice') {
        return Colors.lightBlueAccent;
      } else if (type == 'Dragon') {
        return Colors.pinkAccent;
      } else {
        return Colors.white;
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Pokedex"),
        actions: const [
          Icon(Icons.menu),
        ],
        actionsIconTheme: const IconThemeData(color: Colors.white, size: 35),
      ),
      body: FutureBuilder<dynamic>(
        future: fetch(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return PokeCard(
                    color: _colorForType(
                        snapshot.data[index]['type'][0].toString()),
                    index: snapshot.data[index]['id'],
                    name: snapshot.data[index]['name'],
                    num: snapshot.data[index]['num'],
                    types: [snapshot.data[index]['type'][0].toString()],
                  );
                });
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
