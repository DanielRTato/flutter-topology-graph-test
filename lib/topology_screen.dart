import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'models/topology_node.dart';
import 'data/mock_data.dart';
import 'widgets/node_widget.dart';
import 'widgets/info_card.dart';
import 'widgets/legend.dart';
import 'widgets/labeled_tree_edge_renderer.dart';


class TopologyScreen extends StatefulWidget {
  const TopologyScreen({super.key});

  @override
  State<TopologyScreen> createState() => _TopologyScreenState();
}

class _TopologyScreenState extends State<TopologyScreen> {
  late Graph _graph;
  late BuchheimWalkerConfiguration _config;
  late Algorithm _algorithm;
  late GraphViewController _controller;
  late TransformationController _transformationController;

  bool _useRadial = false;
  bool _showDebugAxes = false;
  MockNode? _selectedNode;

  final Map<String, Node> _nodeMap = {};
  final Map<String, String> _edgeLabels = {};

  static const _bgColor = Color(0xFF0D1117);
  static const _surfaceColor = Color(0xFF161B22);

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _controller = GraphViewController(transformationController: _transformationController);
    _config = BuchheimWalkerConfiguration()
      ..siblingSeparation = 80
      ..levelSeparation = 130
      ..subtreeSeparation = 100
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;
    _buildAlgorithm();
    _buildGraph();
  }

  void _buildAlgorithm() {
    final renderer = LabeledTreeEdgeRenderer(_config, labels: _edgeLabels);
    _algorithm = _useRadial
        ? RadialTreeLayoutAlgorithm(_config, renderer)
        : BuchheimWalkerAlgorithm(_config, renderer);
  }

  void _toggleLayout() {
    setState(() {
      _useRadial = !_useRadial;
      _buildAlgorithm();
    });
  }

  void _buildGraph() {
    _graph = Graph()..isTree = true;
    _nodeMap.clear();
    _edgeLabels.clear();

    for (final mock in mockNodes) {
      _nodeMap[mock.id] = Node.Id(mock.id);
    }

    final root = mockNodes.firstWhere((n) => n.parentId == null);
    _graph.addNode(_nodeMap[root.id]!);
    _addChildren(root.id);
  }

  void _addChildren(String parentId) {
    for (final child in mockNodes.where((n) => n.parentId == parentId)) {
      final edgePaint = Paint()
        ..color = child.connected ? const Color(0xFF4CAF50) : const Color(0xFFF44336)
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke;

      _graph.addEdge(_nodeMap[parentId]!, _nodeMap[child.id]!, paint: edgePaint);

      if (child.edgeLabel.isNotEmpty) {
        _edgeLabels['$parentId->${child.id}'] = child.edgeLabel;
      }

      _addChildren(child.id);
    }
  }

  void _onNodeTap(MockNode mock) {
    setState(() {
      _selectedNode = _selectedNode?.id == mock.id ? null : mock;
    });
  }

  void _toggleCollapse(String nodeId) {
    _controller.toggleNodeExpanded(_graph, _nodeMap[nodeId]!, animate: true);
    setState(() {
      if (_selectedNode?.id == nodeId) _selectedNode = null;
    });
  }

  void _expandAll() {
    for (final node in _controller.collapsedNodes.keys.toList()) {
      _controller.expandNode(_graph, node);
    }
    setState(() => _selectedNode = null);
  }

  int _descendantCount(String id) {
    int count = 0;
    for (final n in mockNodes.where((n) => n.parentId == id)) {
      count++;
      count += _descendantCount(n.id);
    }
    return count;
  }

  bool _hasChildren(String id) => mockNodes.any((n) => n.parentId == id);

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: _surfaceColor,
        title: const Text('Topología de Red', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            tooltip: _useRadial ? 'Vista árbol' : 'Vista radial',
            icon: Icon(
              _useRadial ? Icons.account_tree_outlined : Icons.radar,
              color: Colors.white70,
            ),
            onPressed: _toggleLayout,
          ),
          IconButton(
            tooltip: _showDebugAxes ? 'Ocultar ejes (0,0)' : 'Mostrar ejes (0,0)',
            icon: Icon(
              Icons.grid_on,
              color: _showDebugAxes ? Colors.yellowAccent : Colors.white70,
            ),
            onPressed: () => setState(() => _showDebugAxes = !_showDebugAxes),
          ),
          IconButton(
            tooltip: 'Expandir todo',
            icon: const Icon(Icons.unfold_more, color: Colors.white70),
            onPressed: _expandAll,
          ),
        ],
      ),
      body: Column(
        children: [
          const TopologyLegend(),
          Expanded(
            child: Stack(
              children: [
                GraphView.builder(
                  graph: _graph,
                  algorithm: _algorithm,
                  controller: _controller,
                  animated: true,
                  paint: Paint()
                    ..color = Colors.grey.shade700
                    ..strokeWidth = 1.5
                    ..style = PaintingStyle.stroke,
                  builder: (Node node) {
                    final id = node.key!.value as String;
                    final mock = mockNodes.firstWhere((n) => n.id == id);
                    final isCollapsed = _controller.isNodeCollapsed(node);
                    return NodeWidget(
                      mock: mock,
                      isSelected: _selectedNode?.id == id,
                      isCollapsed: isCollapsed,
                      hasChildren: _hasChildren(id),
                      hiddenCount: isCollapsed ? _descendantCount(id) : 0,
                      onTap: () => _onNodeTap(mock),
                      onToggleCollapse: _hasChildren(id) ? () => _toggleCollapse(id) : null,
                    );
                  },
                ),
                if (_showDebugAxes)
                  IgnorePointer(
                    child: AnimatedBuilder(
                      animation: _transformationController,
                      builder: (context, _) => CustomPaint(
                        painter: _DebugAxesPainter(_transformationController.value),
                        child: const SizedBox.expand(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            child: _selectedNode != null
                ? TopologyInfoCard(
                    node: _selectedNode!,
                    isCollapsed: _controller.isNodeCollapsed(_nodeMap[_selectedNode!.id]!),
                    hasChildren: _hasChildren(_selectedNode!.id),
                    onToggleCollapse: () => _toggleCollapse(_selectedNode!.id),
                    onClose: () => setState(() => _selectedNode = null),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _DebugAxesPainter extends CustomPainter {
  final Matrix4 transform;

  _DebugAxesPainter(this.transform);

  @override
  void paint(Canvas canvas, Size size) {
    // El origen (0,0) del grafo transformado a coordenadas de pantalla
    final origin = MatrixUtils.transformPoint(transform, Offset.zero);

    final linePaint = Paint()
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    // Línea vertical en x=0 (amarillo)
    linePaint.color = const Color(0xCCFFEB3B);
    canvas.drawLine(Offset(origin.dx, 0), Offset(origin.dx, size.height), linePaint);

    // Línea horizontal en y=0 (cian)
    linePaint.color = const Color(0xCC00BCD4);
    canvas.drawLine(Offset(0, origin.dy), Offset(size.width, origin.dy), linePaint);

    // Etiquetas
    final textStyle = const TextStyle(fontSize: 11, fontWeight: FontWeight.bold);
    _drawLabel(canvas, 'x=0 (neg ←  · → pos)', Offset(origin.dx + 6, 6),
        const Color(0xCCFFEB3B), textStyle);
    _drawLabel(canvas, 'y=0 (neg ↑  · ↓ pos)', Offset(6, origin.dy + 4),
        const Color(0xCC00BCD4), textStyle);
  }

  void _drawLabel(Canvas canvas, String text, Offset pos, Color color, TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style.copyWith(color: color)),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(canvas, pos);
  }

  @override
  bool shouldRepaint(_DebugAxesPainter old) => transform != old.transform;
}