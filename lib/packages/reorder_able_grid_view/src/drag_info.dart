import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:indimobi/packages/reorder_able_grid_view/reorder_able_grid_view.dart';
import 'package:indimobi/packages/reorder_able_grid_view/src/reorder_able_item.dart';

typedef _DragItemUpdate = void Function(DragInfo item, Offset position, Offset delta);
typedef _DragItemCallback = void Function(DragInfo item);

class DragInfo extends Drag {
  late int index;
  final _DragItemUpdate? onUpdate;
  final _DragItemCallback? onCancel;
  final _DragItemCallback? onEnd;
  final ScrollSpeedController? scrollSpeedController;

  final TickerProvider tickerProvider;
  final GestureMultiDragStartCallback onStart;

  final DragWidgetBuilder? dragWidgetBuilder;
  late Size itemSize;
  late Widget child;
  late ScrollableState scrollable;

  Offset dragPosition;

  late Offset dragOffset;

  late double dragExtent;
  late Size dragSize;

  AnimationController? _proxyAnimationController;

  OverlayEntry? _overlayEntry;
  BuildContext context;
  var hasEnd = false;

  DragInfo({
    required ReorderAbleItemViewState item,
    required this.tickerProvider,
    required this.onStart,
    required this.dragPosition,
    required this.context,
    this.scrollSpeedController,
    this.dragWidgetBuilder,
    this.onUpdate,
    this.onCancel,
    this.onEnd,
  }) {
    index = item.index;
    child = item.widget.child;
    itemSize = item.context.size!;

    final RenderBox renderBox = item.context.findRenderObject()! as RenderBox;
    dragOffset = renderBox.globalToLocal(dragPosition);
    dragExtent = renderBox.size.height;
    dragSize = renderBox.size;

    scrollable = Scrollable.of(item.context)!;
  }

  Offset getCenterInGlobal() {
    return getPosInGlobal() + dragSize.center(Offset.zero);
  }

  Offset getPosInGlobal() {
    return this.dragPosition - this.dragOffset;
  }

  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _proxyAnimationController?.dispose();
    _proxyAnimationController = null;
  }

  Widget createProxy(BuildContext context) {
    var position = this.dragPosition - this.dragOffset;
    return Positioned(
      top: position.dy - 5,
      left: position.dx - 5,
      child: Container(
        width: itemSize.width + 10,
        height: itemSize.height + 10,
        child: dragWidgetBuilder != null ? dragWidgetBuilder!(index, child) : child,
      ),
    );
  }

  void startDrag() {
    _overlayEntry = OverlayEntry(builder: createProxy);
    final OverlayState? overlay = Overlay.of(context);
    overlay?.insert(_overlayEntry!);
  }

  @override
  void update(DragUpdateDetails details) {
    dragPosition += details.delta;
    onUpdate?.call(this, dragPosition, details.delta);
    _overlayEntry?.markNeedsBuild();
  }

  double globalDy = 0;

  @override
  void end(DragEndDetails details) {
    onEnd?.call(this);
    this._endOrCancel();
  }

  @override
  void cancel() {
    onCancel?.call(this);
    this._endOrCancel();
  }

  void _endOrCancel() {
    hasEnd = true;
  }
}
