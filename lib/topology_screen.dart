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
  late BuchheimWalkerAlgorithm _algorithm;

  final Set<String> _collapsed = {};
  MockNode? _selectedNode;
  int _rebuildCount = 0;

  final Map<String, Node> _nodeMap = {};
  final Map<String, String> _edgeLabels = {};

  static const _bgColor = Color(0xFF0D1117);
  static const _surfaceColor = Color(0xFF161B22);

  @override
  void initState() {
    super.initState();
    _rebuildAll();

  }

  void _rebuildAll() {
    _rebuildCount++;
    _edgeLabels.clear();
    _config = BuchheimWalkerConfiguration()
      ..siblingSeparation = 80
      ..levelSeparation = 130
      ..subtreeSeparation = 100
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;
    _algorithm = BuchheimWalkerAlgorithm(
      _config,
      LabeledTreeEdgeRenderer(_config, labels: _edgeLabels),
    );
    _buildGraph();
  }

  void _buildGraph() {
    _graph = Graph()..isTree = true;
    _nodeMap.clear();

    for (final mock in mockNodes) {
      _nodeMap[mock.id] = Node.Id(mock.id);
    }

    final root = mockNodes.firstWhere((n) => n.parentId == null);
    _graph.addNode(_nodeMap[root.id]!);
    _addChildren(root.id);
  }

  void _addChildren(String parentId) {
    if (_collapsed.contains(parentId)) return;

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
    setState(() {
      if (_collapsed.contains(nodeId)) {
        _collapsed.remove(nodeId);
      } else {
        _collapsed.add(nodeId);
      }
      _rebuildAll();
      if (_selectedNode?.id == nodeId) _selectedNode = null;
    });
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: _surfaceColor,
        title: const Text('Topología de Red', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            tooltip: 'Expandir todo',
            icon: const Icon(Icons.account_tree_outlined, color: Colors.white70),
            onPressed: () => setState(() {
              _collapsed.clear();
              _selectedNode = null;
              _rebuildAll();
            }),
          ),
        ],
      ),
      body: Column(
        children: [
          const TopologyLegend(),
          Expanded(
            child: InteractiveViewer(
              constrained: false,
              boundaryMargin: const EdgeInsets.all(200),
              minScale: 0.25,
              maxScale: 4.0,
              child: GraphView(
                key: ValueKey(_rebuildCount),
                graph: _graph,
                algorithm: _algorithm,
                paint: Paint()
                  ..color = Colors.grey.shade700
                  ..strokeWidth = 1.5
                  ..style = PaintingStyle.stroke,
                builder: (Node node) {
                  final id = node.key!.value as String;
                  final mock = mockNodes.firstWhere((n) => n.id == id);
                  return NodeWidget(
                    mock: mock,
                    isSelected: _selectedNode?.id == id,
                    isCollapsed: _collapsed.contains(id),
                    hasChildren: _hasChildren(id),
                    hiddenCount: _collapsed.contains(id) ? _descendantCount(id) : 0,
                    onTap: () => _onNodeTap(mock),
                    onToggleCollapse: _hasChildren(id) ? () => _toggleCollapse(id) : null,
                  );
                },
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            child: _selectedNode != null
                ? TopologyInfoCard(
                    node: _selectedNode!,
                    isCollapsed: _collapsed.contains(_selectedNode!.id),
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
