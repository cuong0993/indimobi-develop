import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indimobi/packages/reorder_able_grid_view/src/reorder_able_grid_mixin.dart';
import 'package:indimobi/screens/detail_project_page/detail_project_vm.dart';

class ReorderAbleItemView extends StatefulWidget {
  final Widget child;
  final Key key;
  final int index;

  const ReorderAbleItemView({
    required this.child,
    required this.key,
    required this.index,
  }) : super(key: key);

  static List<Widget> wrapMeList(
    List<Widget>? header,
    List<Widget> children,
    List<Widget>? footer,
  ) {
    var rst = <Widget>[];
    rst.addAll(header ?? []);
    for (var i = 0; i < children.length; i++) {
      var child = children[i];
      rst.add(ReorderAbleItemView(
        child: child,
        key: child.key ?? ValueKey(i),
        index: i,
      ));
    }

    rst.addAll(footer ?? []);
    return rst;
  }

  @override
  ReorderAbleItemViewState createState() => ReorderAbleItemViewState();
}

class ReorderAbleItemViewState extends State<ReorderAbleItemView>
    with TickerProviderStateMixin {
  late ReorderAbleGridStateMixin _listState;
  bool _dragging = false;

  Offset _startOffset = Offset.zero;
  Offset _targetOffset = Offset.zero;

  AnimationController? _offsetAnimation;
  Offset _placeholderOffset = Offset.zero;

  Key get key => widget.key;

  Widget get child => widget.child;

  int get index => widget.index;

  set dragging(bool dragging) {
    if (mounted) {
      this.setState(() {
        _dragging = dragging;
      });
    }
  }

  Offset getRelativePos(Offset dragPosition) {
    final parentRenderBox = _listState.context.findRenderObject() as RenderBox;
    final parentOffset = parentRenderBox.localToGlobal(dragPosition);

    final renderBox = context.findRenderObject() as RenderBox;
    return renderBox.localToGlobal(parentOffset);
  }

  RenderBox get parentRenderBox {
    return _listState.context.findRenderObject() as RenderBox;
  }

  void updateForGap(int dropIndex) {
    if (!mounted) return;
    _checkPlaceHolder();

    if (_dragging) {
      return;
    }

    Offset newOffset = _listState.getOffsetInDrag(this.index);
    if (newOffset != _targetOffset) {
      _targetOffset = newOffset;

      if (this._offsetAnimation == null) {
        this._offsetAnimation = AnimationController(vsync: _listState)
          ..duration = Duration(milliseconds: 250)
          ..addListener(rebuild)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _startOffset = _targetOffset;
              this._offsetAnimation?.dispose();
              this._offsetAnimation = null;
            }
          })
          ..forward(from: 0.0);
      } else {
        _startOffset = offset;
        this._offsetAnimation?.forward(from: 0.0);
      }
    }
  }

  void _checkPlaceHolder() {
    if (!_dragging) {
      return;
    }

    final _selfPos = index;
    final _targetPos = _listState.dropIndex;
    if (_targetPos < 0) {
      return;
    }

    if (_selfPos == _targetPos) {
      setState(() {
        _placeholderOffset = Offset.zero;
      });
    }

    if (_selfPos != _targetPos) {
      setState(() {
        _placeholderOffset = _listState.getPosByIndex(_targetPos) -
            _listState.getPosByIndex(_selfPos);
      });
    }
  }

  void resetGap() {
    setState(() {
      if (_offsetAnimation != null) {
        _offsetAnimation!.dispose();
        _offsetAnimation = null;
      }

      _startOffset = Offset.zero;
      _targetOffset = Offset.zero;
      _placeholderOffset = Offset.zero;
    });
  }

  MultiDragGestureRecognizer _createDragRecognizer() {
    final dragStartDelay = _listState.dragStartDelay;
    if (dragStartDelay.inMilliseconds == 0) {
      return ImmediateMultiDragGestureRecognizer(debugOwner: this);
    }
    return DelayedMultiDragGestureRecognizer(
      debugOwner: this,
      delay: dragStartDelay,
    );
  }

  @override
  void initState() {
    _listState = ReorderAbleGridStateMixin.of(context);
    _listState.registerItem(this);
    super.initState();
  }

  Offset get offset {
    if (_offsetAnimation != null) {
      return Offset.lerp(
        _startOffset,
        _targetOffset,
        Curves.easeInOut.transform(_offsetAnimation!.value),
      )!;
    }
    return _targetOffset;
  }

  @override
  void dispose() {
    _listState.unRegisterItem(this.index, this);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ReorderAbleItemView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      _listState.unRegisterItem(oldWidget.index, this);
      _listState.registerItem(this);
    }
  }

  Widget _buildPlaceHolder() {
    if (_listState.placeholderBuilder == null) {
      return SizedBox();
    }

    return Transform(
      transform: Matrix4.translationValues(
        _placeholderOffset.dx,
        _placeholderOffset.dy,
        0,
      ),
      child: _listState.placeholderBuilder!(
        index,
        _listState.dropIndex,
        child,
      ),
    );
  }

  bool isScroll = false;
  DetailProjectVm vm = Get.find();

  @override
  Widget build(BuildContext context) {
    if (!_listState.dragEnabled) {
      return widget.child;
    }

    if (_dragging) {
      return _buildPlaceHolder();
    }

    Widget _buildChild(Widget child) {
      return LayoutBuilder(
        builder: (context, constraints) {
          if (_dragging) {
            return _buildPlaceHolder();
          }

          final _offset = offset;
          return Transform(
            transform: Matrix4.translationValues(_offset.dx, _offset.dy, 0),
            child: child,
          );
        },
      );
    }

    return Listener(
      onPointerUp: (PointerUpEvent e) {},
      onPointerMove: (PointerMoveEvent e) {},
      onPointerDown: (PointerDownEvent e) {
        var listState = ReorderAbleGridStateMixin.of(context);
        listState.startDragRecognizer(index, e, _createDragRecognizer());
      },
      child: _buildChild(child),
    );
  }

  void rebuild() {
    if (mounted) {
      setState(() {});
    }
  }
}
