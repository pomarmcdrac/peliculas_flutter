import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          _CustomAppBar( movie ),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle( movie ),
              _Overview( movie ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: CastingCards( movie.id ),
              )
            ]),
          ), 
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomAppBar( this.movie );

  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
      backgroundColor: Colors.indigoAccent[900],
      expandedHeight: 200,
      floating: false,
      pinned: true,
      leading: CircleAvatar(
        backgroundColor: Colors.black,
        radius: 7,
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context), 
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.indigo[100],)
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only( bottom: 10, left: 10, right: 10 ),
          color: Colors.black12,
          child: Text(
            movie.title,
            style: const TextStyle( fontSize:  16 ),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'), 
          image: NetworkImage(movie.fullBackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  final Movie movie;

  const _PosterAndTitle( this.movie );

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only( top: 20 ),
      padding: const EdgeInsets.symmetric( horizontal: 20 ),
      child: Row(
        children: [
          Hero(
            tag: movie.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage( movie.fullPosterImg ),
                height: 150,
          
          
              ),
            ),
          ),
          
          const SizedBox( width: 20 ),

          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Text( 
                  movie.title, 
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white
                  ), 
                  overflow: TextOverflow.ellipsis, 
                  maxLines: 2 
                ),
                
                Text( 
                  movie.originalTitle, 
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.indigoAccent[100]
                  ),
                  overflow: TextOverflow.ellipsis, 
                  maxLines: 2 
                ),
          
                Row(
                  children: [
                    const Icon( Icons.star, size: 15, color: Colors.yellow),
                    const SizedBox( width: 5 ),
                    Text(
                      '${movie.voteAverage}', 
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white
                      )
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {

  final Movie movie;

  const _Overview( this.movie );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 30, vertical: 20 ),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16
        ),
        ),
    );
  }
}

