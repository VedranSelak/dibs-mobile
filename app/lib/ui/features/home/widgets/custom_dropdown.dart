import 'package:app/blocs/filters_bloc/filters_bloc.dart';
import 'package:app/blocs/listing_bloc/listing_bloc.dart';
import 'package:app/res/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustDropDown extends StatefulWidget {
  const CustDropDown(
      {required this.items,
      required this.onChanged,
      this.hintText = "",
      this.hintIcon = Icons.sort,
      this.borderRadius = 0,
      this.borderWidth = 1,
      this.maxListHeight = 300,
      this.defaultSelectedIndex = -1,
      this.isMultiSelect = false,
      Key? key,
      this.enabled = true})
      : super(key: key);

  final List<CustDropdownMenuItem<String>> items;
  final Function onChanged;
  final String hintText;
  final IconData hintIcon;
  final double borderRadius;
  final double maxListHeight;
  final double borderWidth;
  final int defaultSelectedIndex;
  final bool enabled;
  final bool isMultiSelect;

  @override
  _CustDropDownState createState() => _CustDropDownState();
}

class _CustDropDownState extends State<CustDropDown> with WidgetsBindingObserver {
  bool _isOpen = false, _isReverse = false;
  late OverlayEntry _overlayEntry;
  late RenderBox? _renderBox;
  late Offset dropDownOffset;
  List<String> _selectedFilters = [];
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    _selectedFilters = (context.read<FiltersBloc>().state as FiltersApplied).filters;
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

  void _removeOverlay({bool isClose = false}) {
    if (isClose && widget.isMultiSelect) {
      setState(() {
        _selectedFilters = (context.read<FiltersBloc>().state as FiltersApplied).filters;
      });
    }
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
    final state = context.read<FiltersBloc>().state as FiltersApplied;
    if (widget.isMultiSelect) {
      if (_selectedFilters.contains(item.value)) {
        return Icons.check_box_outlined;
      }
      return Icons.check_box_outline_blank;
    } else {
      if (state.sort == item.value) {
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
                              return TextButton(
                                  onPressed: () {
                                    final state = context.read<FiltersBloc>().state as FiltersApplied;
                                    context.read<FiltersBloc>().add(ChangeFilters(
                                          filters: _selectedFilters,
                                          sort: state.sort,
                                        ));
                                    context.read<ListingBloc>().add(FetchListings(
                                          filters: _selectedFilters,
                                          sort: state.sort,
                                        ));
                                    _removeOverlay();
                                  },
                                  child: Text('Apply', style: textStyles.accentText));
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
                                  final state = context.read<FiltersBloc>().state as FiltersApplied;
                                  if (!widget.isMultiSelect) {
                                    _removeOverlay();
                                    context.read<FiltersBloc>().add(ChangeFilters(
                                          filters: state.filters,
                                          sort: item.value,
                                        ));
                                    context.read<ListingBloc>().add(FetchListings(
                                          filters: state.filters,
                                          sort: item.value,
                                        ));
                                  } else {
                                    if (!_selectedFilters.any((filter) => filter == item.value)) {
                                      setState(() {
                                        _selectedFilters = [..._selectedFilters, item.value];
                                      });
                                    } else {
                                      setState(() {
                                        _selectedFilters =
                                            _selectedFilters.where((filter) => filter != item.value).toList();
                                      });
                                    }
                                    _removeOverlay();
                                    _addOverlay();
                                  }
                                  widget.onChanged(item.value);
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
                _isOpen ? _removeOverlay(isClose: true) : _addOverlay();
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
