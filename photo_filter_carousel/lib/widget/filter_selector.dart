import 'package:flutter/material.dart';
import 'package:photo_filter_carousel/widget/filter_item.dart';

@immutable
class FilterSelector extends StatefulWidget {
  const FilterSelector({
    super.key,
    required this.onFilterChanged,
    required this.filters,
  });

  final ValueChanged<Color> onFilterChanged;
  final List<Color> filters;

  @override
  State<FilterSelector> createState() => _FilterSelectorState();
}

class _FilterSelectorState extends State<FilterSelector> {
  static const double _itemSize = 80.0;
  static const double _padding = 8.0;
  static const double _itemSpacing = 20.0;

  ScrollController? _scrollController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Add listener to detect when scrolling stops
    _scrollController!.addListener(_onScroll);

    // Set initial position to center the first item after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController!.hasClients) {
        _scrollToIndex(0);
      }
    });
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController == null ||
        !_scrollController!.hasClients ||
        !mounted) {
      return;
    }

    final double itemWidth = _itemSize + _itemSpacing;
    final double centerOffset =
        _scrollController!.offset + (MediaQuery.of(context).size.width / 2);
    final int newIndex = (centerOffset / itemWidth).round();

    if (newIndex >= 0 &&
        newIndex < widget.filters.length &&
        newIndex != _selectedIndex) {
      setState(() {
        _selectedIndex = newIndex;
      });
      widget.onFilterChanged(widget.filters[newIndex]);
    }
  }

  void _scrollToIndex(int index) {
    if (_scrollController == null ||
        !_scrollController!.hasClients ||
        !mounted) {
      return;
    }

    final double itemWidth = _itemSize + _itemSpacing;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double targetOffset =
        (index * itemWidth) - (screenWidth / 2) + (_itemSize / 2);

    _scrollController!.animateTo(
      targetOffset.clamp(0.0, _scrollController!.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _onFilterTapped(int index) {
    _scrollToIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    // Return a placeholder if ScrollController is not initialized yet
    if (_scrollController == null) {
      return Container(
        height: _itemSize + (_padding * 2),
        color: Colors.black.withValues(alpha: 0.3),
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return Container(
      height: _itemSize + (_padding * 2),
      color: Colors.black.withValues(alpha: 0.3),
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: (MediaQuery.of(context).size.width - _itemSize) / 2,
        ),
        itemCount: widget.filters.length,
        itemBuilder: (context, index) {
          final isCenter = index == _selectedIndex;
          final size = isCenter ? _itemSize * 1.1 : _itemSize;

          return GestureDetector(
            onTap: () => _onFilterTapped(index),
            child: Container(
              width: size,
              height: size,
              margin: EdgeInsets.symmetric(horizontal: _itemSpacing / 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: isCenter ? 3 : 2,
                ),
                boxShadow: isCenter
                    ? [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.3),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: ClipOval(
                child: FilterItem(
                  color: widget.filters[index],
                  onFilterSelected: () => _onFilterTapped(index),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
