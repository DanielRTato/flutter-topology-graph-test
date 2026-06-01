import '../models/topology_node.dart';

const List<MockNode> mockNodes = [
  // Raíz
  MockNode(id: 'r1', label: 'R-Principal', kind: NodeKind.roaming, connected: true),

  // ── LH-Madrid-01 ──────────────────────────────────────────────────────────
  MockNode(id: 'lh1', label: 'LH-Madrid-01', kind: NodeKind.lighthouse, connected: true, parentId: 'r1', edgeLabel: '5ms'),
  MockNode(id: 'gw1', label: 'GW-Sucursal-MAD', kind: NodeKind.gateway, connected: true, parentId: 'lh1', edgeLabel: '12ms'),
  MockNode(id: 'gw2', label: 'GW-Almacen-MAD', kind: NodeKind.gateway, connected: false, parentId: 'lh1', edgeLabel: 'offline'),
  MockNode(id: 'gw3', label: 'GW-Oficinas-MAD', kind: NodeKind.gateway, connected: true, parentId: 'lh1', edgeLabel: '8ms'),
  MockNode(id: 'd1', label: 'Servidor-01', kind: NodeKind.device, connected: true, parentId: 'gw1', edgeLabel: 'LAN'),
  MockNode(id: 'd2', label: 'NAS-Storage', kind: NodeKind.device, connected: true, parentId: 'gw1', edgeLabel: 'LAN'),
  MockNode(id: 'd3', label: 'WorkStation-A', kind: NodeKind.device, connected: true, parentId: 'gw1', edgeLabel: 'WiFi'),
  MockNode(id: 'd4', label: 'Impresora-01', kind: NodeKind.device, connected: false, parentId: 'gw2', edgeLabel: 'WiFi'),
  MockNode(id: 'd5', label: 'Camara-IP-01', kind: NodeKind.device, connected: false, parentId: 'gw2', edgeLabel: 'WiFi'),
  MockNode(id: 'd6', label: 'Camara-IP-02', kind: NodeKind.device, connected: false, parentId: 'gw2', edgeLabel: 'WiFi'),
  MockNode(id: 'd7', label: 'PC-Recepcion', kind: NodeKind.device, connected: true, parentId: 'gw3', edgeLabel: 'LAN'),
  MockNode(id: 'd8', label: 'PC-Contabilidad', kind: NodeKind.device, connected: true, parentId: 'gw3', edgeLabel: 'LAN'),
  MockNode(id: 'd9', label: 'Telefono-IP-01', kind: NodeKind.device, connected: true, parentId: 'gw3', edgeLabel: 'LAN'),

  // ── LH-Barcelona-01 ───────────────────────────────────────────────────────
  MockNode(id: 'lh2', label: 'LH-Barcelona-01', kind: NodeKind.lighthouse, connected: true, parentId: 'r1', edgeLabel: '8ms'),
  MockNode(id: 'gw4', label: 'GW-Fabrica-BCN', kind: NodeKind.gateway, connected: true, parentId: 'lh2', edgeLabel: '30ms'),
  MockNode(id: 'gw5', label: 'GW-Lab-BCN', kind: NodeKind.gateway, connected: true, parentId: 'lh2', edgeLabel: '15ms'),
  MockNode(id: 'd10', label: 'PLC-Linea-01', kind: NodeKind.device, connected: true, parentId: 'gw4', edgeLabel: 'LAN'),
  MockNode(id: 'd11', label: 'Robot-CNC-01', kind: NodeKind.device, connected: true, parentId: 'gw4', edgeLabel: 'LAN'),
  MockNode(id: 'd12', label: 'HMI-Panel-01', kind: NodeKind.device, connected: true, parentId: 'gw4', edgeLabel: 'LAN'),
  MockNode(id: 'd13', label: 'Robot-Soldadura', kind: NodeKind.device, connected: false, parentId: 'gw4', edgeLabel: 'offline'),
  MockNode(id: 'd14', label: 'PC-Lab-01', kind: NodeKind.device, connected: true, parentId: 'gw5', edgeLabel: 'LAN'),
  MockNode(id: 'd15', label: 'Osciloscop-01', kind: NodeKind.device, connected: true, parentId: 'gw5', edgeLabel: 'USB-ETH'),

  // ── LH-Valencia-01 ────────────────────────────────────────────────────────
  MockNode(id: 'lh3', label: 'LH-Valencia-01', kind: NodeKind.lighthouse, connected: true, parentId: 'r1', edgeLabel: '11ms'),
  MockNode(id: 'gw6', label: 'GW-Puerto-VLC', kind: NodeKind.gateway, connected: true, parentId: 'lh3', edgeLabel: '20ms'),
  MockNode(id: 'gw7', label: 'GW-Logistica-VLC', kind: NodeKind.gateway, connected: false, parentId: 'lh3', edgeLabel: 'offline'),
  MockNode(id: 'd16', label: 'Terminal-Grua-01', kind: NodeKind.device, connected: true, parentId: 'gw6', edgeLabel: 'LAN'),
  MockNode(id: 'd17', label: 'Terminal-Grua-02', kind: NodeKind.device, connected: true, parentId: 'gw6', edgeLabel: 'LAN'),
  MockNode(id: 'd18', label: 'SCADA-Puerto', kind: NodeKind.device, connected: true, parentId: 'gw6', edgeLabel: 'LAN'),
  MockNode(id: 'd19', label: 'Scanner-Barras', kind: NodeKind.device, connected: false, parentId: 'gw7', edgeLabel: 'WiFi'),
  MockNode(id: 'd20', label: 'Tablet-Almacen', kind: NodeKind.device, connected: false, parentId: 'gw7', edgeLabel: 'WiFi'),

  // ── LH-Sevilla-01 ─────────────────────────────────────────────────────────
  MockNode(id: 'lh4', label: 'LH-Sevilla-01', kind: NodeKind.lighthouse, connected: true, parentId: 'r1', edgeLabel: '18ms'),
  MockNode(id: 'gw8', label: 'GW-Planta-SEV', kind: NodeKind.gateway, connected: true, parentId: 'lh4', edgeLabel: '25ms'),
  MockNode(id: 'gw9', label: 'GW-Admin-SEV', kind: NodeKind.gateway, connected: true, parentId: 'lh4', edgeLabel: '10ms'),
  MockNode(id: 'd21', label: 'Fresadora-CNC', kind: NodeKind.device, connected: true, parentId: 'gw8', edgeLabel: 'LAN'),
  MockNode(id: 'd22', label: 'Torno-Auto-01', kind: NodeKind.device, connected: true, parentId: 'gw8', edgeLabel: 'LAN'),
  MockNode(id: 'd23', label: 'Sensor-Temp-01', kind: NodeKind.device, connected: true, parentId: 'gw8', edgeLabel: 'LAN'),
  MockNode(id: 'd24', label: 'Sensor-Temp-02', kind: NodeKind.device, connected: false, parentId: 'gw8', edgeLabel: 'offline'),
  MockNode(id: 'd25', label: 'PC-RRHH', kind: NodeKind.device, connected: true, parentId: 'gw9', edgeLabel: 'LAN'),
  MockNode(id: 'd26', label: 'Servidor-ERP', kind: NodeKind.device, connected: true, parentId: 'gw9', edgeLabel: 'LAN'),

  // ── LH-Bilbao-01 ──────────────────────────────────────────────────────────
  MockNode(id: 'lh5', label: 'LH-Bilbao-01', kind: NodeKind.lighthouse, connected: false, parentId: 'r1', edgeLabel: 'offline'),
  MockNode(id: 'gw10', label: 'GW-Astillero-BIO', kind: NodeKind.gateway, connected: false, parentId: 'lh5', edgeLabel: 'offline'),
  MockNode(id: 'd27', label: 'Camara-Soldar-01', kind: NodeKind.device, connected: false, parentId: 'gw10', edgeLabel: 'offline'),
  MockNode(id: 'd28', label: 'Sensor-Presion', kind: NodeKind.device, connected: false, parentId: 'gw10', edgeLabel: 'offline'),
  MockNode(id: 'd29', label: 'Controlador-CNC', kind: NodeKind.device, connected: false, parentId: 'gw10', edgeLabel: 'offline'),
];
