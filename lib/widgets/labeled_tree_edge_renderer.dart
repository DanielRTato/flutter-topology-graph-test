import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class LabeledTreeEdgeRenderer extends TreeEdgeRenderer {
  final Map<String, String> labels;

  LabeledTreeEdgeRenderer(super.config, {required this.labels});

  @override
  void renderEdge(Canvas canvas, Edge edge, Paint paint) {
    super.renderEdge(canvas, edge, paint);

    final srcId = (edge.source.key as ValueKey).value.toString();
    final dstId = (edge.destination.key as ValueKey).value.toString();
    final label = labels['$srcId->$dstId'];
    if (label == null || label.isEmpty) return;

    final srcPos = getNodePosition(edge.source);
    final dstPos = getNodePosition(edge.destination);

    final srcCenter = srcPos + Offset(edge.source.size.width / 2, edge.source.size.height / 2);
    final dstCenter = dstPos + Offset(edge.destination.size.width / 2, edge.destination.size.height / 2);
    final mid = (srcCenter + dstCenter) / 2;

    final tp = TextPainter(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: mid, width: tp.width + 10, height: tp.height + 6),
        const Radius.circular(4),
      ),
      Paint()..color = const Color(0xCC0D1117),
    );

    tp.paint(canvas, mid - Offset(tp.width / 2, tp.height / 2));
  }
}
