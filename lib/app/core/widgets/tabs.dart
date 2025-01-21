import 'package:easy_scanner/app/core/constants/app_text_styles.dart';
import 'package:easy_scanner/app/core/constants/gap_constants.dart';
import 'package:flutter/material.dart';

class Tabs extends StatelessWidget {
  final dynamic selectedTabIdentifier;
  final List<TabItem> tabs;
  final Function(dynamic) onTabChange;

  const Tabs({
    super.key,
    this.selectedTabIdentifier,
    required this.tabs,
    required this.onTabChange,
  }) : assert(tabs.length >= 2);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: size2,
        horizontal: size4,
      ),
      child: Container(
        padding: const EdgeInsets.all(size2),
        decoration: BoxDecoration(
          borderRadius: radius8,
          color: Colors.white,
        ),
        child: Row(
          children: List.generate(tabs.length, (index) {
            TabItem tab = tabs[index];
            var isSelected = selectedTabIdentifier == tab.identifier;
            return Expanded(
              child: GestureDetector(
                onTap: () => onTabChange(tab.identifier),
                child: Container(
                  alignment: Alignment.center,
                  height: 46,
                  decoration: BoxDecoration(
                    borderRadius: radius8,
                    color: isSelected ? Colors.blue : Colors.white,
                  ),
                  child: Text(
                    tab.label,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class TabItem {
  dynamic identifier;
  String label;

  TabItem({required this.label, required this.identifier});
}
