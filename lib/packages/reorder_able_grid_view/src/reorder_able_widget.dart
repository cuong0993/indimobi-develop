import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:indimobi/packages/reorder_able_grid_view/reorder_able_grid_view.dart';
import 'package:indimobi/packages/reorder_able_grid_view/src/reorder_able_grid_mixin.dart';
import 'package:indimobi/packages/reorder_able_grid_view/src/reorder_able_item.dart';

// why you want the __items?
class GridChildPosDelegate extends ReorderAbleChildPosDelegate {
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double childAspectRatio;

  const GridChildPosDelegate({
    required this.crossAxisCount,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.childAspectRatio = 1.0,
  });

  @override
  Offset getPos(int index, Map<int, ReorderAbleItemViewState> items,
      BuildContext context) {
    double width;
    RenderObject? renderObject = context.findRenderObject();
    if (renderObject == null) {
      return Offset.zero;
    }

    if (renderObject is RenderSliver) {
      width = renderObject.constraints.crossAxisExtent;
    } else {
      width = (renderObject as RenderBox).size.width;
    }

    double itemWidth =
        (width - (crossAxisCount - 1) * crossAxisSpacing) / crossAxisCount;

    int row = index ~/ crossAxisCount;
    int col = index % crossAxisCount;

    double x = (col - 1) * (itemWidth + crossAxisSpacing);
    double y = (row - 1) * (itemWidth / (childAspectRatio) + mainAxisSpacing);
    return Offset(x, y);
  }
}

class ReorderAbleWidget extends StatefulWidget with ReorderAbleGridWidgetMixin {
  final ReorderCallback onReorder;
  final DragWidgetBuilder? dragWidgetBuilder;
  final ScrollSpeedController? scrollSpeedController;
  final PlaceholderBuilder? placeholderBuilder;
  final ReorderAbleChildPosDelegate? posDelegate;
  final OnDragStart? onDragStart;
  final Widget child;

  @override
  final bool? dragEnabled;

  @override
  final Duration? dragStartDelay;

  const ReorderAbleWidget({
    Key? key,
    required this.child,
    required this.onReorder,
    this.dragWidgetBuilder,
    this.scrollSpeedController,
    this.placeholderBuilder,
    this.posDelegate,
    this.onDragStart,
    this.dragEnabled,
    this.dragStartDelay,
  }) : super(key: key);

  @override
  ReorderAbleState createState() {
    return ReorderAbleState();
  }
}

class ReorderAbleState extends State<ReorderAbleWidget>
    with
        TickerProviderStateMixin<ReorderAbleWidget>,
        ReorderAbleGridStateMixin {
  ReorderAbleState();
}
