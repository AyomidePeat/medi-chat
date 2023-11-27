import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medi_query/constants/colors.dart';
import 'package:medi_query/constants/textstyle.dart';
import 'package:medi_query/model/blog_model.dart';
import 'package:medi_query/services/blog_service.dart';
import 'package:medi_query/widgets/blog_post_widget.dart';

import 'package:url_launcher/url_launcher.dart';

final blogPostProvider = FutureProvider<List<BlogPost>>((ref) async {
  final blogPosts = ref.watch(blogApiProvider);
  return blogPosts.getBlogPost();
});

class BlogPostScreen extends ConsumerStatefulWidget {
  const BlogPostScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BlogPostScreenState();
}

class _BlogPostScreenState extends ConsumerState<BlogPostScreen> {
  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final blogPostRef = ref.watch(blogPostProvider);
    return Scaffold(
        backgroundColor: black,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon:
                        const Icon(Icons.arrow_back_ios, color: Colors.white)),
                 Text(
                  'Health news for you',
                  style: bodyText(white, 15)
                ),
              ],
            )),
        body: RefreshIndicator(
          onRefresh: () => ref.refresh(blogPostProvider.future),
          child: blogPostRef.when(data: (data) {
            return ListView.builder(
                itemCount: data.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: BlogPostWidget(
                      title: data[index].title,
                      image: data[index].image,
                      description: data[index].description,
                      source: data[index].source,
                    ),
                    onTap: () {
                      String newsUrl = data[index].url;
                      _launchURL(newsUrl);
                    },
                  );
                });
          }, error: (error, _) {
            return Text(error.toString());
          }, loading: () {
            return  Center(child: CircularProgressIndicator(color:green));
          }),
        ));
  }
}
