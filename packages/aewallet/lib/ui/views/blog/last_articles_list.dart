import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/util/ui_util.dart';
import 'package:aeuniverse/ui/widgets/components/icon_widget.dart';
import 'package:core/localization.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:ghost/ghost.dart';
import 'package:intl/intl.dart';

class LastArticlesWidget extends StatefulWidget {
  const LastArticlesWidget({Key? key}) : super(key: key);

  @override
  LastArticlesWidgetState createState() => LastArticlesWidgetState();
}

class LastArticlesWidgetState extends State<LastArticlesWidget> {
  PageController? pageController;
  double pageOffset = 0;
  List<GhostPost>? posts;
  String blogUrl = 'https://blog.archethic.net';

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController!.addListener(() {
      setState(() => pageOffset = pageController!.page!);
    });

    /// API KEY Hard coded
    /// From official doc: https://ghost.org/docs/content-api/
    /// "Content API keys are provided via a query parameter in the URL.
    /// These keys are safe for use in browsers and other insecure environments,
    /// as they only ever provide access to public data. Sites in private mode should consider
    /// where they share any keys they create."
    final GhostContentAPI api = GhostContentAPI(
      url: blogUrl,
      key: 'aeec92562cfcb3f27993205631',
      version: 'v3',
    );

    api.posts.browse(
      limit: 5,
      include: <String>['tags', 'authors'],
    ).then((value) => posts = value);
  }

  @override
  void dispose() {
    pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (StateContainer.of(context).showBlog == true && posts != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppLocalization.of(context)!.blogHeader,
                    style: AppStyles.textStyleSize14W600EquinoxPrimary(context),
                  ),
                  InkWell(
                    onTap: () {
                      UIUtil.showWebview(context, blogUrl, '');
                    },
                    child: buildIconDataWidget(
                        context, Icons.arrow_circle_right_outlined, 20, 20),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 250,
            child: PageView.builder(
              controller: pageController,
              itemCount: posts!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    UIUtil.showWebview(context, posts![index].url!, '');
                  },
                  child: Center(
                    child: SlidingCard(
                        name: posts![index].title!,
                        date: DateFormat.yMMMEd(
                                Localizations.localeOf(context).languageCode)
                            .format(posts![index].publishedAt!.toLocal())
                            .toString(),
                        author: posts![index].authors![0].name!,
                        assetName: posts![index].featureImage,
                        offset: pageOffset - index),
                  ),
                );
              },
            ),
          ),
        ],
      );
    } else {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 250,
            )
          ]);
    }
  }
}

class SlidingCard extends StatelessWidget {
  final String? name;
  final String? date;
  final String? assetName;
  final double? offset;
  final String? author;

  const SlidingCard({
    Key? key,
    @required this.name,
    @required this.date,
    @required this.assetName,
    @required this.offset,
    @required this.author,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset!.abs() - 0.5), 2) / 0.08));
    return Transform.translate(
      offset: Offset(-32 * gauss * offset!.sign, 0),
      child: Card(
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
          side: const BorderSide(color: Colors.white24, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(32)),
              child: assetName == null
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                    )
                  : Image.network(
                      '$assetName',
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      alignment: Alignment(-offset!.abs(), 0),
                      fit: BoxFit.fitWidth,
                    ),
            ),
            Expanded(
              child: CardContent(
                name: name,
                date: date,
                offset: gauss,
                author: author,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String? name;
  final String? date;
  final double? offset;
  final String? author;

  const CardContent({
    Key? key,
    @required this.name,
    @required this.date,
    @required this.offset,
    @required this.author,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Transform.translate(
            offset: Offset(8 * offset!, 0),
            child: Text(
              name!,
              style: AppStyles.textStyleSize14W600Primary(context),
            ),
          ),
          const SizedBox(height: 5),
          Transform.translate(
            offset: Offset(32 * offset!, 0),
            child: Text(
              '${date!} by ${author!}',
              style: AppStyles.textStyleSize12W400Primary(context),
            ),
          ),
        ],
      ),
    );
  }
}
