import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_bloc.dart';
import 'package:inventory_app/inventory/bloc/inventory_state.dart';
import 'package:inventory_app/inventory/widgets/inventory_filter_bottom_sheet.dart';
import 'package:inventory_app/inventory/widgets/inventory_sort_bottom_sheet.dart';
import 'package:inventory_app/part_editor/view/part_editor_page.dart';

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
        return Padding(
          padding: const .symmetric(horizontal: 16),
          child: AnimatedSwitcher(
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            duration: const Duration(milliseconds: 300),
            child: _searchBarVisible
                ? Card(
                    key: const ValueKey('searchbar'),
                    color: context.colors.secondaryContainer,
                    elevation: 2,
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
                : Card(
                    key: const ValueKey('toolbar'),
                    color: context.colors.secondaryContainer,
                    elevation: 2,
                    child: Row(
                      mainAxisSize: .min,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() => _searchBarVisible = true);
                            _focusNode.requestFocus();
                          },
                          icon: Icon(Icons.search, color: onContainerColor),
                        ),
                        IconButton(
                          onPressed: () => showModalBottomSheet<void>(
                            showDragHandle: true,
                            context: context,
                            builder: (_) => BlocProvider.value(
                              value: bloc,
                              child: const InventorySortBottomSheet(),
                            ),
                          ),
                          icon: const Icon(Icons.sort),
                        ),
                        FloatingActionButton.small(
                          elevation: 1,
                          onPressed: () =>
                              Navigator.push(context, PartEditorPage.route()),
                          child: const Icon(Icons.add),
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
                                value: bloc,
                                child: const InventoryFilterBottomSheet(),
                              ),
                            ),
                            icon: Icon(
                              Icons.filter_list,
                              color: onContainerColor,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () =>
                              bloc.add(const SortOrderButtonPressed()),
                          icon: Icon(
                            state.filter.isSortedAscending
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            color: onContainerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
