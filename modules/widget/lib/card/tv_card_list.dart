import 'package:core/styles/text_style.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:tv/tv.dart';
import 'package:widget/card/image_card.dart';

class TvCard extends StatelessWidget {
  final Tv tv;

  const TvCard({Key? key, required this.tv}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            tvDetailRoute,
            arguments: tv.id,
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
                      tv.title ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    const SizedBox(height: 5),
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
                left: 5,
                bottom: 10,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: ImageCard(
                  pathImage: tv.posterPath ?? "",
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
