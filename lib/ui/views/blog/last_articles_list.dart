/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

import 'package:aewallet/application/blog.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
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

    const blogUrl = 'https://blog.archethic.net';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.blogHeader,
                style: ArchethicThemeStyles.textStyleSize14W600Primary,
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
        asyncArticlesList.map(
          data: (data) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: PageView.builder(
                padEnds: false,
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
                    child: SlidingCard(
                      index: index,
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
    @required this.index,
    @required this.name,
    @required this.date,
    @required this.assetName,
    @required this.offset,
    @required this.author,
  });
  final int? index;
  final String? name;
  final String? date;
  final String? assetName;
  final double? offset;
  final String? author;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Card(
          elevation: 0,
          margin: index == 0
              ? const EdgeInsets.only(right: 8, bottom: 8)
              : const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Colors.white10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: assetName == null
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                      )
                    : ImageNetwork(
                        url: '$assetName',
                        fit: BoxFit.fitHeight,
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
                              color: ArchethicTheme.text,
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
                  author: author,
                ),
              ),
            ],
          ),
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
    @required this.author,
  });
  final String? name;
  final String? date;
  final String? author;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name!.replaceAll(RegExp(r'\s+'), ' '),
            style: ArchethicThemeStyles.textStyleSize12W100Primary,
          ),
          const SizedBox(height: 5),
          Text(
            '${date!} by ${author!}',
            style: ArchethicThemeStyles.textStyleSize10W100Primary,
          ),
        ],
      ),
    );
  }
}
