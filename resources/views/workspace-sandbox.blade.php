<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="csrf-token" content="{{ csrf_token() }}" />
  <title>Workspace Sandbox</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 0; background: #f6f8fb; }
    .container { max-width: 1200px; margin: 20px auto; padding: 0 16px; }
    .bar, .panel, .content { background: #fff; border: 1px solid #dfe5ef; border-radius: 8px; padding: 12px; margin-bottom: 12px; }
    .bar { display: flex; gap: 8px; align-items: center; flex-wrap: wrap; }
    input, select, button { padding: 8px; }
    .tree ul { list-style: none; margin: 0; padding-left: 18px; }
    .tree li { margin: 6px 0; }
    .node { display: inline-flex; align-items: center; gap: 8px; }
    .muted { color: #666; font-size: 12px; }
    .row { display:flex; gap:8px; align-items:center; flex-wrap:wrap; margin-top:8px; }
    .danger { background:#c0392b; color:#fff; border:none; }
  </style>
</head>
<body>
<div class="container">
  <h2>Workspace Sandbox (No Build)</h2>
  <div class="muted">Direct database-backed mockup for backend validation before Angular build.</div>

  <div class="bar">
    <label>Workspace:</label>
    <select id="workspaceSelect"></select>
    <button onclick="loadTree()">Load</button>
    <input id="newWorkspaceName" placeholder="New workspace name" />
    <button onclick="createWorkspace()">Create Workspace</button>
  </div>

  <div class="panel">
    <strong>Structure actions</strong>
    <div class="row">
      <input id="parentId" placeholder="Parent Node ID" style="width:320px;" />
      <input id="nodeTitle" placeholder="Node title" />
      <select id="nodeType">
        <option value="folder">folder</option>
        <option value="document_link">document_link</option>
        <option value="paper_link">paper_link</option>
      </select>
      <input id="contentRef" placeholder="contentRef UUID (for links)" style="width:320px;" />
      <button onclick="addNode()">Add Node</button>
    </div>
    <div class="row">
      <input id="renameId" placeholder="Node ID to rename" style="width:320px;" />
      <input id="renameTitle" placeholder="New title" />
      <button onclick="renameNode()">Rename</button>
    </div>
    <div class="row">
      <input id="moveId" placeholder="Node ID to move" style="width:320px;" />
      <input id="moveParentId" placeholder="New parent ID" style="width:320px;" />
      <input id="moveSortIndex" placeholder="Sort index" type="number" value="0" />
      <button onclick="moveNode()">Move</button>
    </div>
    <div class="row">
      <input id="deleteId" placeholder="Node ID to delete" style="width:320px;" />
      <button class="danger" onclick="deleteNode()">Delete Node</button>
    </div>
  </div>

  <div class="panel tree">
    <strong>Workspace tree</strong>
    <div id="treeRoot" class="muted" style="margin-top:8px;">No tree loaded.</div>
  </div>

  <div class="content">
    <strong>Selected Node</strong>
    <pre id="selected" class="muted">(none)</pre>
  </div>
</div>

<script>
const csrf = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
const headers = {'Content-Type':'application/json','X-CSRF-TOKEN':csrf};
let currentTree = null;

async function request(url, options={}) {
  const res = await fetch(url, options);
  const text = await res.text();
  let data = null;
  try { data = text ? JSON.parse(text) : null; } catch { data = text; }
  if (!res.ok) throw new Error((data && data.message) ? data.message : `HTTP ${res.status}`);
  return data;
}

async function loadRoots() {
  const roots = await request('/workspace-sandbox/roots');
  const select = document.getElementById('workspaceSelect');
  select.innerHTML = '';
  for (const r of roots) {
    const opt = document.createElement('option');
    opt.value = r.id;
    opt.textContent = `${r.title} (${r.id})`;
    select.appendChild(opt);
  }
  if (roots.length) {
    document.getElementById('parentId').value = roots[0].id;
    await loadTree();
  }
}

async function loadTree() {
  const id = document.getElementById('workspaceSelect').value;
  if (!id) return;
  currentTree = await request(`/workspace-sandbox/tree/${id}`);
  renderTree();
}

function renderTree() {
  const rootEl = document.getElementById('treeRoot');
  rootEl.innerHTML = '';
  if (!currentTree) { rootEl.textContent = 'No tree loaded.'; return; }
  rootEl.appendChild(renderNode(currentTree));
}

function renderNode(node) {
  const li = document.createElement('li');
  const row = document.createElement('div');
  row.className = 'node';
  const btn = document.createElement('button');
  btn.textContent = node.title;
  btn.onclick = () => {
    document.getElementById('selected').textContent = JSON.stringify(node, null, 2);
    document.getElementById('parentId').value = node.id;
  };
  const meta = document.createElement('span');
  meta.className = 'muted';
  meta.textContent = `${node.nodeType} • ${node.id}`;
  row.appendChild(btn);
  row.appendChild(meta);
  li.appendChild(row);

  if (node.children && node.children.length) {
    const ul = document.createElement('ul');
    for (const child of node.children) ul.appendChild(renderNode(child));
    li.appendChild(ul);
  }
  return li;
}

async function createWorkspace() {
  try {
    const title = document.getElementById('newWorkspaceName').value.trim();
    if (!title) return alert('Workspace name required');
    await request('/workspace-sandbox/roots', {method:'POST', headers, body: JSON.stringify({title})});
    document.getElementById('newWorkspaceName').value = '';
    await loadRoots();
  } catch (e) { alert(e.message); }
}

async function addNode() {
  try {
    const rootId = document.getElementById('workspaceSelect').value;
    const parentId = document.getElementById('parentId').value.trim();
    const title = document.getElementById('nodeTitle').value.trim();
    const nodeType = document.getElementById('nodeType').value;
    const contentRef = document.getElementById('contentRef').value.trim();
    const payload = {workspaceRootId: rootId, parentId, nodeType, title};
    if (nodeType !== 'folder' && contentRef) {
      payload.contentRef = contentRef;
      payload.contentKind = nodeType === 'document_link' ? 'document' : 'paper';
    }
    await request('/workspace-sandbox/nodes', {method:'POST', headers, body: JSON.stringify(payload)});
    document.getElementById('nodeTitle').value = '';
    document.getElementById('contentRef').value = '';
    await loadTree();
  } catch (e) { alert(e.message); }
}

async function renameNode() {
  try {
    const id = document.getElementById('renameId').value.trim();
    const title = document.getElementById('renameTitle').value.trim();
    await request(`/workspace-sandbox/nodes/${id}/rename`, {method:'POST', headers, body: JSON.stringify({title})});
    await loadTree();
  } catch (e) { alert(e.message); }
}

async function moveNode() {
  try {
    const id = document.getElementById('moveId').value.trim();
    const parentId = document.getElementById('moveParentId').value.trim();
    const sortIndex = Number(document.getElementById('moveSortIndex').value || 0);
    await request(`/workspace-sandbox/nodes/${id}/move`, {method:'POST', headers, body: JSON.stringify({parentId, sortIndex})});
    await loadTree();
  } catch (e) { alert(e.message); }
}

async function deleteNode() {
  try {
    const id = document.getElementById('deleteId').value.trim();
    await request(`/workspace-sandbox/nodes/${id}/delete`, {method:'POST', headers});
    await loadTree();
  } catch (e) { alert(e.message); }
}

loadRoots().catch(err => {
  document.getElementById('treeRoot').textContent = `Error: ${err.message}`;
});
</script>
</body>
</html>
