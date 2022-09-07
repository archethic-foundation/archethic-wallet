/*// Dart imports:
import 'dart:math' as math;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:ghost/ghost.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/icon_widget.dart';

class NFTGlobalListWidget extends StatefulWidget {
  const NFTGlobalListWidget({Key? key}) : super(key: key);

  @override
  State<NFTGlobalListWidget> createState() => NFTGlobalListWidgetState();
}

class NFTGlobalListWidgetState extends State<NFTGlobalListWidget> {


  @override
  void initState() {
    super.initState();
   
  }


  @override
  Widget build(BuildContext context) {
    if (StateContainer.of(context).showBlog == true &&  != null) {
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
          children: const [
            SizedBox(
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
        elevation: 5,
        shadowColor: Colors.black,
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        color: StateContainer.of(context).curTheme.backgroundDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: const BorderSide(color: Colors.white10, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(25)),
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
}*/
