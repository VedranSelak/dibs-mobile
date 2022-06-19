import 'package:app/res/text_styles.dart';
import 'package:flutter/material.dart';

class CustDropDown<T> extends StatefulWidget {
  const CustDropDown(
      {required this.items,
      required this.onChanged,
      this.hintText = "",
      this.hintIcon = Icons.sort,
      this.borderRadius = 0,
      this.borderWidth = 1,
      this.maxListHeight = 200,
      this.defaultSelectedIndex = -1,
      this.isMultiSelect = false,
      this.selectedItems = const [],
      Key? key,
      this.enabled = true})
      : super(key: key);

  final List<CustDropdownMenuItem> items;
  final Function onChanged;
  final String hintText;
  final IconData hintIcon;
  final double borderRadius;
  final double maxListHeight;
  final double borderWidth;
  final int defaultSelectedIndex;
  final bool enabled;
  final bool isMultiSelect;
  final List<int> selectedItems;

  @override
  _CustDropDownState createState() => _CustDropDownState();
}

class _CustDropDownState extends State<CustDropDown> with WidgetsBindingObserver {
  bool _isOpen = false, _isReverse = false;
  late OverlayEntry _overlayEntry;
  late RenderBox? _renderBox;
  int? _selectedItem;
  List<int> _selectedItems = [];
  late Offset dropDownOffset;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    _selectedItems = widget.selectedItems;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          dropDownOffset = getOffset();
        });
      }
    });
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  void _addOverlay() {
    if (mounted) {
      setState(() {
        _isOpen = true;
      });
    }

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context)!.insert(_overlayEntry);
  }

  void _removeOverlay() {
    if (mounted) {
      setState(() {
        _isOpen = false;
      });
      _overlayEntry.remove();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  IconData getIconData(CustDropdownMenuItem item) {
    if (widget.isMultiSelect) {
      if (_selectedItems.contains(item.value)) {
        return Icons.check_box_outlined;
      }
      return Icons.check_box_outline_blank;
    } else {
      if (_selectedItem == item.value) {
        return Icons.radio_button_checked;
      }
      return Icons.radio_button_unchecked;
    }
  }

  OverlayEntry _createOverlayEntry() {
    final textStyles = TextStyles.of(context);
    _renderBox = context.findRenderObject() as RenderBox?;

    final size = _renderBox!.size;

    dropDownOffset = getOffset();

    return OverlayEntry(
      maintainState: false,
      builder: (context) => Align(
        alignment: Alignment.center,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: dropDownOffset,
          child: SizedBox(
            height: widget.maxListHeight,
            width: size.width,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: _isReverse ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    constraints: BoxConstraints(maxHeight: widget.maxListHeight, maxWidth: size.width),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(widget.borderRadius),
                      ),
                      child: Material(
                        color: Colors.white,
                        elevation: 0,
                        shadowColor: Colors.grey,
                        child: ListView.builder(
                          itemCount: widget.items.length + (widget.isMultiSelect ? 1 : 0),
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (index == widget.items.length) {
                              return TextButton(onPressed: () {}, child: Text('Apply', style: textStyles.accentText));
                            }
                            final item = widget.items[index];
                            return InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      item.child,
                                      Icon(getIconData(item)),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                if (mounted) {
                                  setState(() {
                                    if (!widget.isMultiSelect) {
                                      _removeOverlay();
                                      _selectedItem = index;
                                    } else {
                                      if (!_selectedItems.any((i) => i == index)) {
                                        _selectedItems = [..._selectedItems, index];
                                      } else {
                                        _selectedItems = _selectedItems.where((i) => i != index).toList();
                                      }
                                      _removeOverlay();
                                      _addOverlay();
                                    }
                                    widget.onChanged(item.value);
                                  });
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Offset getOffset() {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    final double y = renderBox!.localToGlobal(Offset.zero).dy;
    final double spaceAvailable = _getAvailableSpace(y + renderBox.size.height);
    if (spaceAvailable > widget.maxListHeight) {
      _isReverse = false;
      return Offset(0, renderBox.size.height);
    } else {
      _isReverse = true;
      return Offset(0, renderBox.size.height - (widget.maxListHeight + renderBox.size.height));
    }
  }

  double _getAvailableSpace(double offsetY) {
    final double safePaddingTop = MediaQuery.of(context).padding.top;
    final double safePaddingBottom = MediaQuery.of(context).padding.bottom;

    final double screenHeight = MediaQuery.of(context).size.height - safePaddingBottom - safePaddingTop;

    return screenHeight - offsetY;
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles.of(context);
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: widget.enabled
            ? () {
                _isOpen ? _removeOverlay() : _addOverlay();
              }
            : null,
        child: Container(
          decoration: _getDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.hintIcon,
                color: Colors.blueAccent,
                size: 15.0,
              ),
              const SizedBox(width: 5.0),
              Text(
                widget.hintText,
                textAlign: TextAlign.center,
                style: textStyles.accentText,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Decoration? _getDecoration() {
    return BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)));
  }
}

class CustDropdownMenuItem<T> extends StatelessWidget {
  const CustDropdownMenuItem({required this.value, required this.child, Key? key}) : super(key: key);
  final T value;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
