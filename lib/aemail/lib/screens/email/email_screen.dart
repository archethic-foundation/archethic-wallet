// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:aemail/models/email.dart';
import 'package:core/appstate_container.dart';
import 'package:core/ui/util/lorem_ipsum/lorem_ipsum.dart';
import 'package:core/ui/util/styles.dart';
import 'package:core/ui/widgets/components/icon_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:websafe_svg/websafe_svg.dart';

// Project imports:
import '../../constants.dart';
import 'components/header.dart';

class EmailScreen extends StatelessWidget {
  const EmailScreen({
    Key? key,
    this.email,
  }) : super(key: key);

  final Email? email;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: StateContainer.of(context).curTheme.background,
      child: SafeArea(
        child: Column(
          children: [
            const Header(),
            const Divider(thickness: 1),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      maxRadius: 24,
                      backgroundImage: AssetImage(emails[1].image!),
                    ),
                    const SizedBox(width: kDefaultPadding),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        text: emails[1].name,
                                        style: AppStyles
                                            .textStyleSize14W100Primary(
                                                context),
                                        children: [
                                          TextSpan(
                                            text: "  <xxx@gmail.com> to Prince",
                                            style: AppStyles
                                                .textStyleSize10W100Primary(
                                                    context),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      loremIpsum(words: 6),
                                      style:
                                          AppStyles.textStyleSize14W100Primary(
                                              context),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(width: kDefaultPadding / 2),
                              Text(
                                "Today at 15:32",
                                style: AppStyles.textStyleSize10W100Primary(
                                    context),
                              ),
                            ],
                          ),
                          const SizedBox(height: kDefaultPadding),
                          LayoutBuilder(
                            builder: (context, constraints) => SizedBox(
                              width: constraints.maxWidth > 850
                                  ? 800
                                  : constraints.maxWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    loremIpsum(words: 400, paragraphs: 3),
                                    style: AppStyles.textStyleSize14W100Primary(
                                        context),
                                  ),
                                  const SizedBox(height: kDefaultPadding),
                                  Row(
                                    children: [
                                      Text(
                                        "6 attachments",
                                        style: AppStyles
                                            .textStyleSize12W100Primary(
                                                context),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "Download All",
                                        style: AppStyles
                                            .textStyleSize12W100Primary(
                                                context),
                                      ),
                                      const SizedBox(
                                          width: kDefaultPadding / 4),
                                      buildIconWidgetWidget(
                                          context,
                                          WebsafeSvg.asset(
                                            "packages/aemail/assets/Icons/Download.svg",
                                            height: 16,
                                            color: kGrayColor,
                                          ),
                                          30,
                                          30),
                                    ],
                                  ),
                                  const Divider(thickness: 1),
                                  const SizedBox(height: kDefaultPadding / 2),
                                  SizedBox(
                                    height: 200,
                                    child: StaggeredGrid.count(
                                      crossAxisCount: 4,
                                      children: const [
                                        StaggeredGridTile.count(
                                          crossAxisCellCount: 2,
                                          mainAxisCellCount: 2,
                                          child: Text(''),
                                        ),
                                      ],
                                      mainAxisSpacing: kDefaultPadding,
                                      crossAxisSpacing: kDefaultPadding,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
