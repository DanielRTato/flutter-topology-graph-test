import '../models/topology_node.dart';

const List<MockNode> mockNodes = [
  // Raíz: único nodo R
  MockNode(
    id: 'r1',
    label: 'R-Principal',
    kind: NodeKind.roaming,
    connected: true,
  ),
  // Lighthouses (hijos de R)
  MockNode(
    id: 'lh1',
    label: 'LH-Madrid-01',
    kind: NodeKind.lighthouse,
    connected: true,
    parentId: 'r1',
    edgeLabel: '5ms',
  ),
  MockNode(
    id: 'lh2',
    label: 'LH-Barcelona-01',
    kind: NodeKind.lighthouse,
    connected: true,
    parentId: 'r1',
    edgeLabel: '8ms',
  ),
  // Gateways de LH-Madrid
  MockNode(
    id: 'gw1',
    label: 'GW-Sucursal-MAD',
    kind: NodeKind.gateway,
    connected: true,
    parentId: 'lh1',
    edgeLabel: '45ms',
  ),
  MockNode(
    id: 'gw2',
    label: 'GW-Almacen-MAD',
    kind: NodeKind.gateway,
    connected: false,
    parentId: 'lh1',
    edgeLabel: 'offline',
  ),
  // Gateways de LH-Barcelona
  MockNode(
    id: 'gw3',
    label: 'GW-Fabrica-BCN',
    kind: NodeKind.gateway,
    connected: true,
    parentId: 'lh2',
    edgeLabel: '30ms',
  ),
  // Dispositivos bajo gw1
  MockNode(
    id: 'd1',
    label: 'Servidor-01',
    kind: NodeKind.device,
    connected: true,
    parentId: 'gw1',
    edgeLabel: 'LAN',
  ),
  MockNode(
    id: 'd2',
    label: 'NAS-Storage',
    kind: NodeKind.device,
    connected: true,
    parentId: 'gw1',
    edgeLabel: 'LAN',
  ),
  MockNode(
    id: 'd3',
    label: 'WorkStation-A',
    kind: NodeKind.device,
    connected: true,
    parentId: 'gw1',
    edgeLabel: 'WiFi',
  ),
  // Dispositivos bajo gw2
  MockNode(
    id: 'd4',
    label: 'Impresora-01',
    kind: NodeKind.device,
    connected: false,
    parentId: 'gw2',
    edgeLabel: 'WiFi',
  ),
  MockNode(
    id: 'd5',
    label: 'Camara-IP-01',
    kind: NodeKind.device,
    connected: false,
    parentId: 'gw2',
    edgeLabel: 'WiFi',
  ),
  // Dispositivos bajo gw3 (maquinaria industrial)
  MockNode(
    id: 'd6',
    label: 'PLC-Linea-01',
    kind: NodeKind.device,
    connected: true,
    parentId: 'gw3',
    edgeLabel: 'LAN',
  ),
  MockNode(
    id: 'd7',
    label: 'Robot-CNC-01',
    kind: NodeKind.device,
    connected: true,
    parentId: 'gw3',
    edgeLabel: 'LAN',
  ),
  MockNode(
    id: 'd8',
    label: 'HMI-Panel-01',
    kind: NodeKind.device,
    connected: true,
    parentId: 'gw3',
    edgeLabel: 'LAN',
  ),
];
