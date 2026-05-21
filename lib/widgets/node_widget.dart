import 'package:flutter/material.dart';
import '../models/topology_node.dart';
import 'node_style.dart';

class NodeWidget extends StatelessWidget {
  final MockNode mock;
  final bool isSelected;
  final bool isCollapsed;
  final bool hasChildren;
  final int hiddenCount;
  final VoidCallback onTap;
  final VoidCallback? onToggleCollapse;

  const NodeWidget({
    super.key,
    required this.mock,
    required this.isSelected,
    required this.isCollapsed,
    required this.hasChildren,
    required this.hiddenCount,
    required this.onTap,
    this.onToggleCollapse,
  });

  @override
  Widget build(BuildContext context) {
    final color = nodeColor(mock.kind);
    final isCircle = mock.kind == NodeKind.roaming;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(
              horizontal: isCircle ? 14 : 10,
              vertical: isCircle ? 14 : 8,
            ),
            decoration: BoxDecoration(
              color: color.withAlpha(35),
              border: Border.all(
                color: isSelected ? Colors.white : color,
                width: isSelected ? 2.5 : 1.8,
              ),
              borderRadius: BorderRadius.circular(isCircle ? 60 : 12),
              boxShadow: isSelected
                  ? [BoxShadow(color: color.withAlpha(100), blurRadius: 14, spreadRadius: 2)]
                  : [],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(nodeIcon(mock.kind), color: color, size: nodeIconSize(mock.kind)),
                const SizedBox(height: 4),
                Text(
                  mock.label,
                  style: TextStyle(
                    color: Colors.white.withAlpha(230),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (hasChildren)
          GestureDetector(
            onTap: onToggleCollapse,
            child: Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isCollapsed ? color.withAlpha(80) : Colors.white12,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: color.withAlpha(120), width: 0.8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isCollapsed ? Icons.add : Icons.remove,
                    color: Colors.white70,
                    size: 9,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    isCollapsed ? '$hiddenCount ocultos' : 'colapsar',
                    style: const TextStyle(color: Colors.white70, fontSize: 8),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
