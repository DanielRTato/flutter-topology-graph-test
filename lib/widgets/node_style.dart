import 'package:flutter/material.dart';
import '../models/topology_node.dart';

Color nodeColor(NodeKind kind) => switch (kind) {
      NodeKind.roaming => const Color(0xFF4DB6AC),
      NodeKind.lighthouse => const Color(0xFF29B6F6),
      NodeKind.gateway => const Color(0xFFFFB74D),
      NodeKind.device => const Color(0xFF90A4AE),
    };

IconData nodeIcon(NodeKind kind) => switch (kind) {
      NodeKind.roaming => Icons.hub,
      NodeKind.lighthouse => Icons.cell_tower,
      NodeKind.gateway => Icons.router,
      NodeKind.device => Icons.computer,
    };

double nodeIconSize(NodeKind kind) => switch (kind) {
      NodeKind.roaming => 32,
      NodeKind.lighthouse => 26,
      NodeKind.gateway => 22,
      NodeKind.device => 18,
    };

String kindLabel(NodeKind kind) => switch (kind) {
      NodeKind.roaming => 'Roaming',
      NodeKind.lighthouse => 'Lighthouse',
      NodeKind.gateway => 'Gateway',
      NodeKind.device => 'Dispositivo',
    };
