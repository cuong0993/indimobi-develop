import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:indimobi/packages/reorder_able_grid_view/reorder_able_grid_view.dart';

export 'src/reorder_able_item.dart' show ReorderAbleItemView;
export 'src/reorder_able_widget.dart' show ReorderAbleWidget;

typedef DragWidgetBuilder = Widget Function(int index, Widget child);

typedef ScrollSpeedController = double Function(
    int timeInMilliSecond, double overSize, double itemSize);

typedef PlaceholderBuilder = Widget Function(
    int dropIndex, int dropInddex, Widget dragWidget);

typedef OnDragStart = void Function(int dragIndex);

typedef OnDragChange = void Function(double dx, double dy);

class ReorderAbleGridView extends StatelessWidget {
  final ReorderCallback onReorder;
  final DragWidgetBuilder? dragWidgetBuilder;
  final ScrollSpeedController? scrollSpeedController;
  final PlaceholderBuilder? placeholderBuilder;
  final OnDragStart? onDragStart;

  final bool? primary;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool reverse;
  final double? cacheExtent;
  final int? semanticChildCount;
  final List<int>? unableDrag;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final Clip clipBehavior;
  final String? restorationId;
  final SliverChildDelegate childrenDelegate;
  final SliverGridDelegate gridDelegate;
  final ScrollController? controller;
  final DragStartBehavior dragStartBehavior;
  final Duration? dragStartDelay;
  final bool? dragEnabled;

  ReorderAbleGridView.builder({
    Key? key,
    required ReorderCallback onReorder,
    ScrollSpeedController? scrollSpeedController,
    DragWidgetBuilder? dragWidgetBuilder,
    List<int>? unableDrag,
    PlaceholderBuilder? placeholderBuilder,
    OnDragStart? onDragStart,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    required SliverGridDelegate gridDelegate,
    required IndexedWidgetBuilder itemBuilder,
    int? itemCount,
    bool addAutomaticKeepAlive = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    Duration? dragStartDelay,
    bool? dragEnabled,
  }) : this(
          key: key,
          onReorder: onReorder,
          dragWidgetBuilder: dragWidgetBuilder,
          scrollSpeedController: scrollSpeedController,
          placeholderBuilder: placeholderBuilder,
          onDragStart: onDragStart,
          unableDrag: unableDrag,
          childrenDelegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              Widget child = itemBuilder(context, index);
              if (unableDrag != null && unableDrag.contains(index)) {
                return child;
              } else {
                return ReorderAbleItemView(
                  child: child,
                  key: child.key!,
                  index: index,
                );
              }
            },
            childCount: itemCount,
            addAutomaticKeepAlives: addAutomaticKeepAlive,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
          ),
          gridDelegate: gridDelegate,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          padding: padding,
          cacheExtent: cacheExtent,
          semanticChildCount: semanticChildCount ?? itemCount,
          dragStartBehavior: dragStartBehavior,
          keyboardDismissBehavior: keyboardDismissBehavior,
          restorationId: restorationId,
          clipBehavior: clipBehavior,
          dragStartDelay: dragStartDelay,
          dragEnabled: dragEnabled,
        );

  ReorderAbleGridView.count({
    Key? key,
    required ReorderCallback onReorder,
    DragWidgetBuilder? dragWidgetBuilder,
    ScrollSpeedController? scrollSpeedController,
    PlaceholderBuilder? placeholderBuilder,
    OnDragStart? onDragStart,
    List<Widget>? footer,
    List<Widget>? header,
    double mainAxisSpacing = 0.0,
    double crossAxisSpacing = 0.0,
    double childAspectRatio = 1.0,
    double? mainAxisExtent,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    required int crossAxisCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    List<Widget> children = const <Widget>[],
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    Duration? dragStartDelay,
    bool? dragEnabled,
  }) : this(
          key: key,
          onReorder: onReorder,
          dragWidgetBuilder: dragWidgetBuilder,
          scrollSpeedController: scrollSpeedController,
          placeholderBuilder: placeholderBuilder,
          onDragStart: onDragStart,
          childrenDelegate: SliverChildListDelegate(
            ReorderAbleItemView.wrapMeList(header, children, footer),
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing,
            childAspectRatio: childAspectRatio,
          ),
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          padding: padding,
          cacheExtent: cacheExtent,
          semanticChildCount: semanticChildCount ?? children.length,
          dragStartBehavior: dragStartBehavior,
          keyboardDismissBehavior: keyboardDismissBehavior,
          restorationId: restorationId,
          clipBehavior: clipBehavior,
          dragEnabled: dragEnabled,
          dragStartDelay: dragStartDelay,
        );

  ReorderAbleGridView({
    Key? key,
    required this.onReorder,
    this.dragWidgetBuilder,
    this.scrollSpeedController,
    this.placeholderBuilder,
    this.onDragStart,
    required this.gridDelegate,
    required this.childrenDelegate,
    this.reverse = false,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.cacheExtent,
    this.semanticChildCount,
    this.unableDrag,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.controller,
    this.dragStartBehavior = DragStartBehavior.start,
    this.dragStartDelay,
    this.dragEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReorderAbleWidget(
      child: GridView.custom(
        key: key,
        gridDelegate: gridDelegate,
        childrenDelegate: childrenDelegate,
        controller: controller,
        reverse: reverse,
        primary: primary,
        physics: physics,
        shrinkWrap: shrinkWrap,
        padding: padding,
        cacheExtent: cacheExtent,
        semanticChildCount: semanticChildCount,
        keyboardDismissBehavior: keyboardDismissBehavior,
        restorationId: restorationId,
        clipBehavior: clipBehavior,
        dragStartBehavior: dragStartBehavior,
      ),
      onReorder: onReorder,
      dragWidgetBuilder: dragWidgetBuilder,
      scrollSpeedController: scrollSpeedController,
      placeholderBuilder: placeholderBuilder,
      onDragStart: onDragStart,
      dragEnabled: dragEnabled,
      dragStartDelay: dragStartDelay,
    );
  }
}
