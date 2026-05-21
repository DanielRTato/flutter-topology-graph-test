import 'package:flutter/material.dart';
import '../models/topology_node.dart';
import 'node_style.dart';

class TopologyInfoCard extends StatelessWidget {
  final MockNode node;
  final bool isCollapsed;
  final bool hasChildren;
  final VoidCallback onToggleCollapse;
  final VoidCallback onClose;

  const TopologyInfoCard({
    super.key,
    required this.node,
    required this.isCollapsed,
    required this.hasChildren,
    required this.onToggleCollapse,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final color = nodeColor(node.kind);
    return Container(
      color: const Color(0xFF161B22),
      padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withAlpha(40),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: color.withAlpha(100)),
            ),
            child: Icon(nodeIcon(node.kind), color: color, size: 26),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  node.label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      kindLabel(node.kind),
                      style: const TextStyle(color: Colors.white54, fontSize: 11),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: node.connected
                            ? const Color(0xFF4CAF50)
                            : const Color(0xFFF44336),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      node.connected ? 'Conectado' : 'Desconectado',
                      style: TextStyle(
                        color: node.connected
                            ? const Color(0xFF4CAF50)
                            : const Color(0xFFF44336),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (hasChildren)
            TextButton.icon(
              onPressed: onToggleCollapse,
              icon: Icon(
                isCollapsed ? Icons.expand_more : Icons.expand_less,
                size: 16,
              ),
              label: Text(isCollapsed ? 'Expandir' : 'Colapsar'),
              style: TextButton.styleFrom(foregroundColor: Colors.white70),
            ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white38, size: 18),
            onPressed: onClose,
          ),
        ],
      ),
    );
  }
}
