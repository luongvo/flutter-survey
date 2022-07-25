import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_survey/extensions/build_context_ext.dart';

/// A widget to receive rating input from users.
///
/// [RatingBar] can also be used to display rating
///
/// Prefer using [RatingBarIndicator] instead, if read only version is required.
/// As RatingBarIndicator supports any fractional rating value.
class NumberRating extends StatefulWidget {
  /// Creates [RatingBar] using the [ratingWidget].
  const NumberRating({
    required this.onRatingUpdate,
    this.glowColor,
    this.maxRating,
    this.textDirection,
    this.unratedColor,
    this.glow = true,
    this.glowRadius = 2,
    this.ignoreGestures = false,
    this.initialRating = 0.0,
    this.itemCount = 10,
    this.itemPadding = EdgeInsets.zero,
    this.itemSize = 40.0,
    this.minRating = 0,
    this.tapOnlyMode = false,
    this.updateOnDrag = false,
    this.wrapAlignment = WrapAlignment.start,
  });

  /// Return current rating whenever rating is updated.
  ///
  /// [updateOnDrag] can be used to change the behaviour how the callback reports the update.
  final ValueChanged<double> onRatingUpdate;

  /// Defines color for glow.
  ///
  /// Default is [ThemeData.colorScheme.secondary].
  final Color? glowColor;

  /// Sets maximum rating
  ///
  /// Default is [itemCount].
  final double? maxRating;

  /// {@template flutterRatingBar.textDirection}
  /// The text flows from right to left if [textDirection] = TextDirection.rtl
  /// {@endtemplate}
  final TextDirection? textDirection;

  /// {@template flutterRatingBar.unratedColor}
  /// Defines color for the unrated portion.
  ///
  /// Default is [ThemeData.disabledColor].
  /// {@endtemplate}
  final Color? unratedColor;

  /// if set to true, Rating Bar item will glow when being touched.
  ///
  /// Default is true.
  final bool glow;

  /// Defines the radius of glow.
  ///
  /// Default is 2.
  final double glowRadius;

  /// if set to true, will disable any gestures over the rating bar.
  ///
  /// Default is false.
  final bool ignoreGestures;

  /// Defines the initial rating to be set to the rating bar.
  final double initialRating;

  /// {@template flutterRatingBar.itemCount}
  /// Defines total number of rating bar items.
  ///
  /// Default is 5.
  /// {@endtemplate}
  final int itemCount;

  /// {@template flutterRatingBar.itemPadding}
  /// The amount of space by which to inset each rating item.
  /// {@endtemplate}
  final EdgeInsetsGeometry itemPadding;

  /// {@template flutterRatingBar.itemSize}
  /// Defines width and height of each rating item in the bar.
  ///
  /// Default is 40.0
  /// {@endtemplate}
  final double itemSize;

  /// Sets minimum rating
  ///
  /// Default is 0.
  final double minRating;

  /// if set to true will disable drag to rate feature. Note: Enabling this mode will disable half rating capability.
  ///
  /// Default is false.
  final bool tapOnlyMode;

  /// Defines whether or not the `onRatingUpdate` updates while dragging.
  ///
  /// Default is false.
  final bool updateOnDrag;

  /// How the item within the [RatingBar] should be placed in the main axis.
  ///
  /// For example, if [wrapAlignment] is [WrapAlignment.center], the item in
  /// the RatingBar are grouped together in the center of their run in the main axis.
  ///
  /// Defaults to [WrapAlignment.start].
  final WrapAlignment wrapAlignment;

  @override
  _NumberRatingState createState() => _NumberRatingState();
}

class _NumberRatingState extends State<NumberRating> {
  double _rating = 0.0;
  bool _isRTL = false;
  double iconRating = 0.0;

  late double _minRating, _maxRating;
  late final ValueNotifier<bool> _glow;

  @override
  void initState() {
    super.initState();
    _glow = ValueNotifier(false);
    _minRating = widget.minRating;
    _maxRating = widget.maxRating ?? widget.itemCount.toDouble();
    _rating = widget.initialRating;
  }

  @override
  void didUpdateWidget(NumberRating oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialRating != widget.initialRating) {
      _rating = widget.initialRating;
    }
    _minRating = widget.minRating;
    _maxRating = widget.maxRating ?? widget.itemCount.toDouble();
  }

  @override
  void dispose() {
    _glow.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textDirection = widget.textDirection ?? Directionality.of(context);
    _isRTL = textDirection == TextDirection.rtl;
    iconRating = 0.0;

    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Wrap(
              alignment: WrapAlignment.start,
              textDirection: textDirection,
              children: List.generate(
                widget.itemCount,
                (index) => _buildRating(context, index),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.localization.surveyAnswerNpsNotAtAllLikely,
                style: TextStyle(
                    color: (_rating <= (_maxRating / 2))
                        ? Colors.white
                        : Colors.white54),
              ),
              SizedBox(
                width: 60,
              ),
              Text(
                context.localization.surveyAnswerNpsExtremelyLikely,
                style: TextStyle(
                    color: (_rating > (_maxRating / 2))
                        ? Colors.white
                        : Colors.white54),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRating(BuildContext context, int index) {
    final ratingOffset = 1.0;

    Widget _ratingWidget;

    final text = "$index";
    if (index >= _rating) {
      _ratingWidget = Container(
        width: 30,
        height: 50,
        decoration: (index < widget.itemCount - 1)
            ? BoxDecoration(
                border: Border(
                    right: BorderSide(
                  color: Colors.white,
                  width: 1,
                )),
              )
            : null,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white54),
          ),
        ),
      );
    } else if (index >= _rating - ratingOffset) {
      _ratingWidget = Container(
        width: 30,
        height: 50,
        decoration: (index < widget.itemCount - 1)
            ? BoxDecoration(
                border: Border(
                    right: BorderSide(
                  color: Colors.white,
                  width: 1,
                )),
              )
            : null,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
      iconRating += 0.5;
    } else {
      _ratingWidget = Container(
        width: 30,
        height: 50,
        decoration: (index < widget.itemCount - 1)
            ? BoxDecoration(
                border: Border(
                    right: BorderSide(
                  color: Colors.white,
                  width: 1,
                )),
              )
            : null,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
      iconRating += 1.0;
    }

    return IgnorePointer(
      ignoring: widget.ignoreGestures,
      child: GestureDetector(
        onTapDown: (details) {
          double value;
          if (index == 0 && (_rating == 1 || _rating == 0.5)) {
            value = 0;
          } else {
            // final tappedPosition = details.localPosition.dx;
            // final tappedOnFirstHalf = tappedPosition <= widget.itemSize / 2;
            value = index + 1.0;
          }

          value = math.max(value, widget.minRating);
          widget.onRatingUpdate(value);
          _rating = value;
          setState(() {});
        },
        onHorizontalDragStart: _isHorizontal ? _onDragStart : null,
        onHorizontalDragEnd: _isHorizontal ? _onDragEnd : null,
        onHorizontalDragUpdate: _isHorizontal ? _onDragUpdate : null,
        onVerticalDragStart: _isHorizontal ? null : _onDragStart,
        onVerticalDragEnd: _isHorizontal ? null : _onDragEnd,
        onVerticalDragUpdate: _isHorizontal ? null : _onDragUpdate,
        child: Padding(
          padding: widget.itemPadding,
          child: ValueListenableBuilder<bool>(
            valueListenable: _glow,
            builder: (context, glow, child) {
              if (glow && widget.glow) {
                final glowColor =
                    widget.glowColor ?? Theme.of(context).colorScheme.secondary;
                return DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: glowColor.withAlpha(30),
                        blurRadius: 10,
                        spreadRadius: widget.glowRadius,
                      ),
                      BoxShadow(
                        color: glowColor.withAlpha(20),
                        blurRadius: 10,
                        spreadRadius: widget.glowRadius,
                      ),
                    ],
                  ),
                  child: child,
                );
              }
              return child!;
            },
            child: _ratingWidget,
          ),
        ),
      ),
    );
  }

  bool get _isHorizontal => true;

  void _onDragUpdate(DragUpdateDetails dragDetails) {
    if (!widget.tapOnlyMode) {
      final box = context.findRenderObject() as RenderBox?;
      if (box == null) return;

      final _pos = box.globalToLocal(dragDetails.globalPosition);
      double i;
      // if (widget.direction == Axis.horizontal) {
      i = _pos.dx / (widget.itemSize + widget.itemPadding.horizontal);
      // } else {
      //   i = _pos.dy / (widget.itemSize + widget.itemPadding.vertical);
      // }
      var currentRating = i.round().toDouble();
      if (currentRating > widget.itemCount) {
        currentRating = widget.itemCount.toDouble();
      }
      if (currentRating < 0) {
        currentRating = 0.0;
      }
      if (_isRTL) {
        currentRating = widget.itemCount - currentRating;
      }

      _rating = currentRating.clamp(_minRating, _maxRating);
      if (widget.updateOnDrag) widget.onRatingUpdate(iconRating);
      setState(() {});
    }
  }

  void _onDragStart(DragStartDetails details) {
    _glow.value = true;
  }

  void _onDragEnd(DragEndDetails details) {
    _glow.value = false;
    widget.onRatingUpdate(iconRating);
    iconRating = 0.0;
  }
}
