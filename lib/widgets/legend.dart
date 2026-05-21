import 'package:flutter/material.dart';
import '../models/topology_node.dart';
import 'node_style.dart';

class TopologyLegend extends StatelessWidget {
  const TopologyLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF161B22),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _NodeItem(kind: NodeKind.roaming, label: 'Roaming (R)'),
          const SizedBox(width: 14),
          _NodeItem(kind: NodeKind.lighthouse, label: 'Lighthouse'),
          const SizedBox(width: 14),
          _NodeItem(kind: NodeKind.gateway, label: 'Gateway'),
          const SizedBox(width: 14),
          _NodeItem(kind: NodeKind.device, label: 'Dispositivo'),
          const Spacer(),
          _EdgeItem(color: Color(0xFF4CAF50), label: 'Conectado'),
          const SizedBox(width: 12),
          _EdgeItem(color: Color(0xFFF44336), label: 'Desconectado'),
        ],
      ),
    );
  }
}

class _NodeItem extends StatelessWidget {
  final NodeKind kind;
  final String label;

  const _NodeItem({required this.kind, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(nodeIcon(kind), color: nodeColor(kind), size: 13),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 11)),
      ],
    );
  }
}

class _EdgeItem extends StatelessWidget {
  final Color color;
  final String label;

  const _EdgeItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 18, height: 2.5, color: color),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 11)),
      ],
    );
  }
}
