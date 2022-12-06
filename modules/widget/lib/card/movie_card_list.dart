import 'package:core/core.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:widget/card/image_card.dart'; 

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            movieDetailRoute,
            arguments: movie.id,
          );
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16 + 25 + 16,
                  bottom: 5,
                  right: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      movie.overview ?? '-',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 5,
                bottom: 10,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: ImageCard(
                  pathImage: movie.posterPath ?? "", 
                  width: 48, 
                  height: 60,
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
