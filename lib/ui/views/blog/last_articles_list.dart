// Dart imports:
import 'dart:math' as math;

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/icon_widget.dart';
// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:ghost/ghost.dart';
import 'package:intl/intl.dart';

class LastArticlesWidget extends StatefulWidget {
  const LastArticlesWidget({super.key});

  @override
  LastArticlesWidgetState createState() => LastArticlesWidgetState();
}

class LastArticlesWidgetState extends State<LastArticlesWidget> {
  PageController? pageController;
  double pageOffset = 0;

  String blogUrl = 'https://blog.archethic.net';

  /// API KEY Hard coded
  /// From official doc: https://ghost.org/docs/content-api/
  /// "Content API keys are provided via a query parameter in the URL.
  /// These keys are safe for use in browsers and other insecure environments,
  /// as they only ever provide access to public data.
  /// Sites in private mode should consider
  /// where they share any keys they create."
  final GhostContentAPI api = GhostContentAPI(
    url: 'https://blog.archethic.net',
    key: 'aeec92562cfcb3f27993205631',
    version: 'v3',
  );

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController!.addListener(() {
      setState(() => pageOffset = pageController!.page!);
    });
  }

  @override
  void dispose() {
    pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (StateContainer.of(context).showBlog == true) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalization.of(context)!.blogHeader,
                    style: AppStyles.textStyleSize14W600EquinoxPrimary(context),
                  ),
                  InkWell(
                    onTap: () {
                      UIUtil.showWebview(context, blogUrl, '');
                    },
                    child: IconWidget.buildIconDataWidget(
                      context,
                      Icons.arrow_circle_right_outlined,
                      20,
                      20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          FutureBuilder<List<GhostPost>>(
            future: api.posts.browse(
              limit: 5,
              include: <String>['tags', 'authors'],
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  height: 280,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          UIUtil.showWebview(
                            context,
                            snapshot.data![index].url!,
                            '',
                          );
                        },
                        child: Center(
                          child: SlidingCard(
                            name: snapshot.data![index].title,
                            date: DateFormat.yMMMEd(
                              Localizations.localeOf(context).languageCode,
                            ).format(
                              snapshot.data![index].publishedAt!.toLocal(),
                            ),
                            author: snapshot.data![index].authors![0].name,
                            assetName: snapshot.data![index].featureImage,
                            offset: pageOffset - index,
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: 250,
                    )
                  ],
                );
              }
            },
          )
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 250,
          )
        ],
      );
    }
  }
}

class SlidingCard extends StatelessWidget {
  const SlidingCard({
    super.key,
    @required this.name,
    @required this.date,
    @required this.assetName,
    @required this.offset,
    @required this.author,
  });
  final String? name;
  final String? date;
  final String? assetName;
  final double? offset;
  final String? author;

  @override
  Widget build(BuildContext context) {
    final gauss = math.exp(-(math.pow(offset!.abs() - 0.5, 2) / 0.08));
    return Transform.translate(
      offset: Offset(-32 * gauss * offset!.sign, 0),
      child: Card(
        elevation: 5,
        shadowColor: Colors.black,
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        color: StateContainer.of(context).curTheme.backgroundDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: Colors.white10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
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
  const CardContent({
    super.key,
    @required this.name,
    @required this.date,
    @required this.offset,
    @required this.author,
  });
  final String? name;
  final String? date;
  final double? offset;
  final String? author;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
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
