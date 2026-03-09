import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/inventory/widgets/inventory_page_filter_bottom_sheet.dart';

class InventoryToolBar extends StatefulWidget {
  const InventoryToolBar({super.key});

  @override
  State<InventoryToolBar> createState() => _InventoryToolBarState();
}

class _InventoryToolBarState extends State<InventoryToolBar> {
  bool _searchBarVisible = false;
  final _focusNode = FocusNode();
  final _controller = TextEditingController();

  @override
  void initState() {
    _focusNode.addListener(() {
      setState(() {
        if (_controller.text.isEmpty && !_focusNode.hasFocus) {
          _searchBarVisible = false;
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<InventoryBloc>();
    final containerColor = context.colors.secondaryContainer;
    final onContainerColor = context.colors.onSecondaryContainer;
    return BlocBuilder<InventoryBloc, InventoryState>(
      builder: (context, state) {
        final activeFilters = state.filter.totalActiveFilters;
        final searchQuery = state.filter.searchQuery;
        return Align(
          alignment: .bottomCenter,
          child: Padding(
            padding: .only(
              bottom: _focusNode.hasFocus && _searchBarVisible ? 8 : 26,
            ),
            child: Card(
              elevation: 1,
              color: context.colors.secondaryContainer,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: _searchBarVisible
                    ? FractionallySizedBox(
                        widthFactor: _widthFactor(),
                        child: SearchBar(
                          backgroundColor: WidgetStatePropertyAll(
                            containerColor,
                          ),
                          focusNode: _focusNode,
                          onChanged: (value) => bloc.add(
                            SearchQueryUpdated(searchString: value),
                          ),
                          controller: _controller,
                          leading: Icon(Icons.search, color: onContainerColor),
                          trailing: [
                            if (searchQuery.isEmpty || !_focusNode.hasFocus)
                              IconButton(
                                onPressed: () {
                                  _controller.clear();
                                  bloc.add(
                                    const SearchQueryUpdated(
                                      searchString: '',
                                    ),
                                  );
                                  setState(_focusNode.unfocus);
                                  _searchBarVisible = false;
                                },
                                icon: Icon(
                                  Icons.cancel,
                                  color: onContainerColor,
                                ),
                              )
                            else
                              IconButton(
                                onPressed: () {
                                  _controller.clear();
                                  bloc.add(
                                    const SearchQueryUpdated(searchString: ''),
                                  );
                                },
                                icon: Icon(
                                  Icons.backspace,
                                  color: onContainerColor,
                                ),
                              ),
                          ],
                        ),
                      )
                    : Row(
                        mainAxisSize: .min,
                        children: [
                          IconButton(
                            onPressed: () async {
                              setState(() => _searchBarVisible = true);
                              await Future.microtask(
                                _focusNode.requestFocus,
                              );
                            },
                            icon: Icon(Icons.search, color: onContainerColor),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_downward,
                              color: onContainerColor,
                            ),
                          ),
                          Badge.count(
                            isLabelVisible: activeFilters > 0,
                            count: activeFilters,
                            child: IconButton(
                              onPressed: () => showModalBottomSheet<void>(
                                showDragHandle: true,
                                isScrollControlled: true,
                                context: context,
                                builder: (_) => BlocProvider.value(
                                  value: context.read<InventoryBloc>(),
                                  child: const InventoryPageFilterBottomSheet(),
                                ),
                              ),
                              icon: Icon(
                                Icons.filter_list,
                                color: onContainerColor,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  double? _widthFactor() {
    if (!_searchBarVisible) return null;
    if (_searchBarVisible && !_focusNode.hasFocus) return 0.6;
    return 0.9;
  }
}
