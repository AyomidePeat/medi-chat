import 'package:flutter/material.dart';
import 'package:medi_query/constants/colors.dart';

class BlogPostWidget extends StatelessWidget {
  final String title;
  final String image;
  final String description;
  final String source;
  const BlogPostWidget(
      {super.key,
      required this.title,
      required this.image,
      required this.description,
      required this.source});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        width: double.infinity,
        height: 90,
        decoration: BoxDecoration(
          color: black,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            CircleAvatar(radius: 30, backgroundImage: NetworkImage(image)),
            const SizedBox(width: 10),
            SizedBox(
              width: size.width > 500 ? size.width * 0.8 : size.width * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 3),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 11,
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Source: $source',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
