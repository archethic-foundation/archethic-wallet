/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:math' as math;

import 'package:aewallet/application/blog.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/icon_widget.dart';
import 'package:aewallet/ui/widgets/components/image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

class LastArticles extends ConsumerStatefulWidget {
  const LastArticles({super.key});

  @override
  ConsumerState<LastArticles> createState() => LastArticlesState();
}

class LastArticlesState extends ConsumerState<LastArticles> {
  PageController? pageController;
  double pageOffset = 0;

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
    final preferences = ref.watch(SettingsProviders.settings);
    if (preferences.showBlog == false) {
      return const _LastArticlesNotShowed();
    }
    final asyncArticlesList = ref.watch(BlogProviders.fetchArticles);
    final theme = ref.watch(ThemeProviders.selectedTheme);
    const blogUrl = 'https://blog.archethic.net';

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
                  AppLocalizations.of(context)!.blogHeader,
                  style: theme.textStyleSize14W600EquinoxPrimary,
                ),
                InkWell(
                  onTap: () {
                    UIUtil.showWebview(context, blogUrl, '');
                  },
                  child: const IconDataWidget(
                    icon: Symbols.open_in_new,
                    width: AppFontSizes.size20,
                    height: AppFontSizes.size20,
                  ),
                ),
              ],
            ),
          ),
        ),
        asyncArticlesList.map(
          data: (data) {
            return SizedBox(
              height: 280,
              child: PageView.builder(
                controller: pageController,
                itemCount: data.value.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      UIUtil.showWebview(
                        context,
                        data.value[index].url!,
                        '',
                      );
                    },
                    child: Center(
                      child: SlidingCard(
                        name: data.value[index].title,
                        date: DateFormat.yMMMEd(
                          Localizations.localeOf(context).languageCode,
                        ).format(
                          data.value[index].publishedAt!.toLocal(),
                        ),
                        author: data.value[index].authors![0].name,
                        assetName: data.value[index].featureImage,
                        offset: pageOffset - index,
                      ),
                    ),
                  );
                },
              ),
            );
          },
          error: (error) => const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 250,
              ),
            ],
          ),
          loading: (loading) => const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 250,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LastArticlesNotShowed extends StatelessWidget {
  const _LastArticlesNotShowed();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
        ),
        SizedBox(
          height: 250,
        ),
      ],
    );
  }
}

class SlidingCard extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final gauss = math.exp(-(math.pow(offset!.abs() - 0.5, 2) / 0.08));
    return Transform.translate(
      offset: Offset(-32 * gauss * offset!.sign, 0),
      child: Card(
        elevation: 5,
        shadowColor: Colors.black,
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        color: theme.backgroundDark,
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
                  : ImageNetwork(
                      url: '$assetName',
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      alignment: Alignment(-offset!.abs(), 0),
                      error: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                      ),
                      loading: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: theme.text,
                            strokeWidth: 1,
                          ),
                        ),
                      ),
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

class CardContent extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Transform.translate(
            offset: Offset(8 * offset!, 0),
            child: Text(
              name!,
              style: theme.textStyleSize14W600Primary,
            ),
          ),
          const SizedBox(height: 5),
          Transform.translate(
            offset: Offset(32 * offset!, 0),
            child: Text(
              '${date!} by ${author!}',
              style: theme.textStyleSize12W400Primary,
            ),
          ),
        ],
      ),
    );
  }
}
