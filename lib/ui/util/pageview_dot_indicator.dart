import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// PageViewDotIndicator is a widget that shows dots that are usually used
/// along with a [PageView] widget.
///
/// This widget automatically animates transitions by using [AnimatedContainer]
/// for each individual dot.
///
/// It also handles having more dots than it could fit into the viewport by
/// fading the edges and scrolling them as the currentItem is updated.
class PageViewDotIndicator extends StatefulWidget {
  /// Creates a PageViewDotIndicator widget.
  ///
  /// The [currentItem], [count], [unselectedColor] and [selectedColor]
  /// arguments must not be null.
  const PageViewDotIndicator({
    super.key,
    required this.currentItem,
    required this.count,
    required this.unselectedColor,
    required this.selectedColor,
    this.size = const Size(12, 12),
    this.unselectedSize = const Size(12, 12),
    this.duration = const Duration(milliseconds: 150),
    this.margin = const EdgeInsets.symmetric(horizontal: 4),
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.alignment = Alignment.center,
    this.fadeEdges = true,
    this.boxShape = BoxShape.circle,
  }) : assert(
          currentItem >= 0 && currentItem < count,
          'Current item must be within the range of items. Make sure you are using 0-based indexing',
        );

  /// The index of the currentItem. It is a 0-based index and cannot be
  /// neither greater or equal to count nor smaller than 0.
  final int currentItem;

  /// The total amount of dots. Usually it should be the same count of pages of
  /// the corresponding pageview).
  final int count;

  /// The color applied to the dot when the dots' indexes are different from
  /// [currentItem].
  final Color unselectedColor;

  /// The color applied to the dot when the dots' index is the same as
  /// [currentItem].
  final Color selectedColor;

  /// The size of the dot corresponding to the [currentItem] or the default
  /// size of the dots when [unselectedSize] is null.
  final Size size;

  /// The size of the dots when the [currentItem] is different from the dots'
  /// indexes.
  final Size unselectedSize;

  /// The duration of the animations used by the dots when the [currentItem] is
  /// changed
  final Duration duration;

  /// The margin between the dots.
  final EdgeInsets margin;

  /// The external padding.
  final EdgeInsets padding;

  /// The alignment of the dots regarding the whole container.
  final Alignment alignment;

  /// If the edges should be faded or not.
  final bool fadeEdges;

  /// The shape of the indicators.
  final BoxShape boxShape;

  @override
  PageViewDotIndicatorState createState() => PageViewDotIndicatorState();
}

class PageViewDotIndicatorState extends State<PageViewDotIndicator> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        scrollToCurrentPosition();
      }
    });
  }

  @override
  void didUpdateWidget(covariant PageViewDotIndicator oldWidget) {
    if (_scrollController.hasClients) {
      scrollToCurrentPosition();
    }
    super.didUpdateWidget(oldWidget);
  }

  void scrollToCurrentPosition() {
    final widgetOffset = _getOffsetForCurrentPosition();
    _scrollController.animateTo(
      widgetOffset,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: <Color>[
            if (widget.fadeEdges)
              const Color.fromARGB(0, 255, 255, 255)
            else
              Colors.white,
            Colors.white,
            Colors.white,
            if (widget.fadeEdges)
              const Color.fromARGB(0, 255, 255, 255)
            else
              Colors.white,
          ],
          tileMode: TileMode.mirror,
          stops: const [0, 0.05, 0.95, 1],
        ).createShader(bounds);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        alignment: widget.alignment,
        height: widget.size.height,
        child: ListView.builder(
          padding: widget.padding,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.count,
          controller: _scrollController,
          shrinkWrap: !_needsScrolling(),
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.antiAlias,
          itemBuilder: (context, index) {
            return AnimatedContainer(
              margin: widget.margin,
              duration: widget.duration,
              decoration: BoxDecoration(
                shape: widget.boxShape,
                color: index == widget.currentItem
                    ? widget.selectedColor
                    : widget.unselectedColor,
              ),
              width: index == widget.currentItem
                  ? widget.size.width
                  : widget.unselectedSize.width,
              height: index == widget.currentItem
                  ? widget.size.height
                  : widget.unselectedSize.height,
            );
          },
        ),
      ),
    );
  }

  double _getOffsetForCurrentPosition() {
    final offsetPerPosition =
        _scrollController.position.maxScrollExtent / widget.count;
    final widgetOffset = widget.currentItem * offsetPerPosition;
    return widgetOffset;
  }

  /// This is important to center the list items if they fit on screen by making
  /// the list shrinkWrap or to make the list more performatic and avoid
  /// rendering all dots at once, otherwise.
  bool _needsScrolling() {
    final viewportWidth = MediaQuery.of(context).size.width;
    final itemWidth =
        widget.unselectedSize.width + widget.margin.left + widget.margin.right;
    final selectedItemWidth =
        widget.size.width + widget.margin.left + widget.margin.right;
    const listViewPadding = 32;
    final shaderPadding = viewportWidth * 0.1;
    return viewportWidth <
        selectedItemWidth +
            (widget.count - 1) * itemWidth +
            listViewPadding +
            shaderPadding;
  }
}
