import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';

class MovieSlider extends StatefulWidget {
  
  final List<Movie> movies ;
  final String? title ;
  final Function onNextPage;

  const MovieSlider({ 
    Key? key, 
    required this.movies, 
    this.title, 
    required this.onNextPage, 
  }) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {

      if ( scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500 ) {
        widget.onNextPage();
      }
   

    });
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if ( widget.title != null )
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),
              child: Text( 
                widget.title!, 
                style: TextStyle( 
                  fontSize: 20, 
                  color: Colors.indigoAccent[200],
                  fontWeight: FontWeight.bold 
                ),
              ),
            ),

          const SizedBox( height: 5, ),
          
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (_, int index) => _MoviePoster( widget.movies[index], '${ widget.title }-$index-${ widget.movies[index].id }' )
            ),
          ),
        ],
      ),
    );
  }
}
class _MoviePoster extends StatelessWidget {

  final Movie movie;
  final String heroId;

  const _MoviePoster( this.movie, this.heroId );

  @override
  Widget build(BuildContext context) {


    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric( horizontal: 10 ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage( movie.fullPosterImg ),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox( height: 5 ),

          Text(
            movie.title,
            style: TextStyle(
              color: Colors.indigoAccent[100]
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,

          ),
        ],
      ),

    );
  }
}