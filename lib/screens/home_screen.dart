import 'package:flutter/material.dart';
import 'package:peliculas/widgets/widgets.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Películas en cines'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: const Icon( Icons.search ),
          ),
        ],

      ),
      body: Column (
        children: [

          const CardSwiper()


          //* Listado horizontal de peliculas

        ],
      )
    );
  }
}