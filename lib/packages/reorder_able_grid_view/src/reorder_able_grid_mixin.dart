import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:indimobi/packages/reorder_able_grid_view/src/reorder_able_item.dart';
import 'package:indimobi/screens/detail_project_page/detail_project_vm.dart';

import '../reorder_able_grid_view.dart';
import 'drag_info.dart';

abstract class ReorderAbleChildPosDelegate {
  const ReorderAbleChildPosDelegate();

  Offset getPos(int index, Map<int, ReorderAbleItemViewState> items,
      BuildContext context);
}

mixin ReorderAbleGridWidgetMixin on StatefulWidget {
  ReorderCallback get onReorder;

  DragWidgetBuilder? get dragWidgetBuilder;

  ScrollSpeedController? get scrollSpeedController;

  PlaceholderBuilder? get placeholderBuilder;

  OnDragStart? get onDragStart;

  Widget get child;

  Duration? get dragStartDelay;

  bool? get dragEnabled;
}

mixin ReorderAbleGridStateMixin<T extends ReorderAbleGridWidgetMixin>
    on State<T>, TickerProviderStateMixin<T> {
  MultiDragGestureRecognizer? _recognizer;

  Duration get dragStartDelay => widget.dragStartDelay ?? kLongPressTimeout;

  bool get dragEnabled => widget.dragEnabled ?? true;

  void startDragRecognizer(int index, PointerDownEvent event,
      MultiDragGestureRecognizer recognizer) {
    setState(() {
      if (_dragIndex != null) {
        dragReset();
      }

      _dragIndex = index;
      _recognizer = recognizer
        ..onStart = _onDragStart
        ..addPointer(event);
    });
  }

  int? _dragIndex;

  int? _dropIndex;

  int get dropIndex => _dropIndex ?? -1;

  PlaceholderBuilder? get placeholderBuilder => widget.placeholderBuilder;

  Offset getPosByOffset(int index, int dIndex) {
    var keys = this.items.keys.toList();
    var keyIndex = keys.indexOf(index);
    keyIndex = keyIndex + dIndex;
    if (keyIndex < 0) {
      keyIndex = 0;
    }
    if (keyIndex > keys.length - 1) {
      keyIndex = keys.length - 1;
    }

    return getPosByIndex(keys[keyIndex], safe: true);
  }

  Offset getPosByIndex(int index, {bool safe = true}) {
    if (safe) {
      if (index < 0) {
        index = 0;
      }
    }

    if (index < 0) {
      return Offset.zero;
    }

    var child = this.items[index];

    var thisRenderObject = this.context.findRenderObject();

    if (thisRenderObject is RenderSliverGrid) {
      var renderObject = thisRenderObject;

      final SliverConstraints constraints = renderObject.constraints;
      final SliverGridLayout layout =
          renderObject.gridDelegate.getLayout(constraints);

      final SliverGridGeometry gridGeometry =
          layout.getGeometryForChildIndex(index);
      final rst =
          Offset(gridGeometry.crossAxisOffset, gridGeometry.scrollOffset);
      return rst;
    }

    var renderObject = child?.context.findRenderObject();
    if (renderObject == null) {
      return Offset.zero;
    }
    RenderBox box = renderObject as RenderBox;

    var parentRenderObject = this.context.findRenderObject() as RenderBox;
    final pos =
        parentRenderObject.globalToLocal(box.localToGlobal(Offset.zero));
    return pos;
  }

  int _calcDropIndex(int defaultIndex) {
    if (_dragInfo == null) {
      return defaultIndex;
    }

    for (var item in items.values) {
      RenderBox box = item.context.findRenderObject() as RenderBox;
      Offset pos = box.globalToLocal(_dragInfo!.getCenterInGlobal());
      if (pos.dx > 0 &&
          pos.dy > 0 &&
          pos.dx < box.size.width &&
          pos.dy < box.size.height) {
        return item.index;
      }
    }
    return defaultIndex;
  }

  Offset getOffsetInDrag(int index) {
    if (_dragInfo == null || _dropIndex == null || _dragIndex == _dropIndex) {
      return Offset.zero;
    }

    bool inDragRange = false;
    bool isMoveLeft = _dropIndex! > _dragIndex!;

    int minPos = min(_dragIndex!, _dropIndex!);
    int maxPos = max(_dragIndex!, _dropIndex!);

    if (index >= minPos && index <= maxPos) {
      inDragRange = true;
    }

    if (!inDragRange) {
      return Offset.zero;
    } else {
      if (isMoveLeft) {
        return getPosByIndex(index - 1) - getPosByIndex(index);
      } else {
        return getPosByIndex(index + 1) - getPosByIndex(index);
      }
    }
  }

  Drag _onDragStart(Offset position) {
    assert(_dragInfo == null);
    widget.onDragStart?.call(_dragIndex!);

    final ReorderAbleItemViewState item = items[_dragIndex!]!;
    item.dragging = true;
    item.rebuild();

    _dropIndex = _dragIndex;

    _dragInfo = DragInfo(
      item: item,
      tickerProvider: this,
      context: context,
      dragWidgetBuilder: this.widget.dragWidgetBuilder,
      scrollSpeedController: this.widget.scrollSpeedController,
      onStart: _onDragStart,
      dragPosition: position,
      onUpdate: _onDragUpdate,
      onCancel: _onDragCancel,
      onEnd: _onDragEnd,
    );
    _dragInfo!.startDrag();
    updateDragTarget();

    return _dragInfo!;
  }

  DetailProjectVm vm = Get.find();

  bool startScroll = false;

  _onDragUpdate(DragInfo item, Offset position, Offset delta) {
    double dy = item.dragPosition.dy;
    updateDragTarget();
    if (dy < Get.height * 0.15 || dy > Get.height * 0.85) {
      startScroll = true;
      autoScroll(dy);
    } else {
      startScroll = false;
    }
  }

  void autoScroll(double dy) async {
    if (startScroll) {
      Future.delayed(Duration(milliseconds: 15), () {
        ScrollPosition position = vm.scrollController.position;
        if (dy < Get.height * 0.15 &&
            position.pixels > position.minScrollExtent + 10) {
          vm.scrollController.jumpTo(
            position.pixels - 0.5,
          );
        }
        if (dy > Get.height * 0.85 &&
            position.pixels < position.maxScrollExtent - 25) {
          vm.scrollController.jumpTo(
            position.pixels + 0.5,
          );
        }
        autoScroll(dy);
      });
    }
  }

  void _onDragCancel(DragInfo item) {
    dragReset();
    //  setState(() {});
  }

  _onDragEnd(DragInfo item) {
    widget.onReorder(_dragIndex!, _dropIndex!);
    dragReset();
    // setState(() {
    startScroll = false;
    //   });
  }

  dragReset() {
    if (_dragIndex != null) {
      if (items.containsKey(_dragIndex!)) {
        final ReorderAbleItemViewState item = items[_dragIndex!]!;
        item.dragging = false;
        item.rebuild();
      }
      _dragIndex = null;
      _dropIndex = null;
      for (var item in items.values) {
        item.resetGap();
      }
    }
    _recognizer?.dispose();
    _recognizer = null;
    _dragInfo?.dispose();
    _dragInfo = null;
  }

  static ReorderAbleGridStateMixin of(BuildContext context) {
    return context.findAncestorStateOfType<ReorderAbleGridStateMixin>()!;
  }

  void reorder(int startIndex, int endIndex) {
    setState(() {
      if (startIndex != endIndex) widget.onReorder(startIndex, endIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  final Map<int, ReorderAbleItemViewState> items =
      <int, ReorderAbleItemViewState>{};

  DragInfo? _dragInfo;

  void registerItem(ReorderAbleItemViewState item) {
    items[item.index] = item;
    if (item.index == _dragInfo?.index) {
      item.dragging = true;
      item.rebuild();
    }
  }

  void unRegisterItem(int index, ReorderAbleItemViewState item) {
    var current = items[index];
    if (current == item) {
      items.remove(index);
    }
  }

  Future<void> updateDragTarget() async {
    int newTargetIndex = _calcDropIndex(_dropIndex!);
    if (newTargetIndex != _dropIndex) {
      _dropIndex = newTargetIndex;
      for (var item in items.values) {
        item.updateForGap(_dropIndex!);
      }
    }
  }
}
