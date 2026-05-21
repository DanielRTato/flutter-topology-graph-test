enum NodeKind { lighthouse, roaming, gateway, device }

class MockNode {
  final String id;
  final String label;
  final NodeKind kind;
  final bool connected;
  final String? parentId;
  final String edgeLabel;

  const MockNode({
    required this.id,
    required this.label,
    required this.kind,
    required this.connected,
    this.parentId,
    this.edgeLabel = '',
  });
}
