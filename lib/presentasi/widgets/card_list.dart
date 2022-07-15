import 'package:cinta_film/presentasi/halaman/halaman_detail_tv.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinta_film/presentasi/halaman/template_tema.dart';
import 'package:cinta_film/presentasi/halaman/halaman_detail_film.dart';
import 'package:cinta_film/data/sumber_apis_data.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardList extends StatelessWidget{
  var  typeWidget;
  var  film;
  var  tv;

  CardList.film(this.film, this.typeWidget);
  CardList.tv(this.tv, this.typeWidget);

  Widget build(BuildContext context) {
    
    switch(typeWidget){

      case 'widgetFilm' :
        return Container(
           margin: const EdgeInsets.symmetric(vertical: 4),
           child: InkWell(
           onTap: () {
              Navigator.pushNamed(
              context,
              MovieDetailPage.ROUTE_NAME,
              arguments: film.id,
            );
          },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16 + 80 + 16,
                  bottom: 8,
                  right: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      film.title ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    SizedBox(height: 16),
                    Text(
                      film.overview ?? '-',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              child: ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${film.posterPath}',
                  width: 80,
                  placeholder: (context, url) =>
                   Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );

      case 'widgetTv' :
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            TvlsDetailPage.ROUTE_NAME,
            arguments: tv.id,
          );
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 120,
                  bottom: 8,
                  right: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tv.name ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    SizedBox(height: 16),
                    Text(
                      tv.overview ?? '-',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              child: ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  width: 80,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );

      default:
        return Container();
    }
  
  }

}