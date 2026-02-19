<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="csrf-token" content="{{ csrf_token() }}" />
  <title>Workspace Sandbox</title>
  <style>
    body { font-family: Arial, sans-serif; margin:0; background:#eef2f7; }
    .wrap { max-width: 1280px; margin: 14px auto; padding: 0 12px; }
    .card { background:#fff; border:1px solid #d9e1ee; border-radius:10px; padding:12px; margin-bottom:12px; }
    .toolbar { display:flex; gap:8px; align-items:center; flex-wrap:wrap; }
    .tree ul { list-style:none; margin:0; padding-left:18px; }
    .node-row { display:flex; align-items:center; gap:6px; margin:4px 0; }
    .node-title { border:1px solid #cad5e7; background:#fff; border-radius:6px; padding:4px 8px; cursor:pointer; }
    .node-title.selected { background:#e8f0ff; border-color:#5d8cff; }
    .mini { font-size:12px; color:#6b7280; }
    .icon-btn { border:1px solid #c3d0e8; background:#fff; border-radius:6px; width:28px; height:28px; cursor:pointer; }
    .ok { background:#1f8b55; color:#fff; border:none; padding:8px 14px; border-radius:8px; cursor:pointer; }
    .danger { background:#e11d48; color:#fff; border:none; padding:8px 14px; border-radius:8px; cursor:pointer; }
    input, select, button, textarea { font: inherit; }
    input, select, textarea { border:1px solid #c3d0e8; border-radius:8px; padding:8px; }
    .content-view { min-height:560px; border:1px dashed #c9d5ea; border-radius:8px; padding:10px; background:#fafcff; }
    .modal-bg { position:fixed; inset:0; background:rgba(9,30,66,.45); display:none; align-items:center; justify-content:center; z-index:9999; }
    .modal { width: 520px; max-width: calc(100vw - 20px); background:#fff; border-radius:12px; padding:14px; }
    .row { display:flex; gap:8px; align-items:center; margin:8px 0; }
    .row > * { flex:1; }
    .actions { display:flex; gap:8px; justify-content:flex-end; margin-top:10px; }
    pre { white-space:pre-wrap; }
    #treeCard.collapsed #treeRoot { display:none; }
    #treeCard.collapsed { padding-bottom:6px; }
    .header-line { display:flex; justify-content:space-between; align-items:center; margin-bottom:8px; }
    iframe.viewer { width:100%; min-height:520px; border:1px solid #d0dbef; border-radius:8px; background:#fff; }
  </style>
</head>
<body>
<div class="wrap">
  <div class="card">
    <div class="header-line">
      <div>
        <h2 style="margin:0 0 8px 0;">Workspace Sandbox (No Build)</h2>
        <div class="mini">Isolated sandbox only. No Angular build and no main menu changes.</div>
      </div>
      <button class="icon-btn" title="Developer panel" onclick="openDevModal()">🛠</button>
    </div>
    <div class="toolbar" style="margin-top:8px;">
      <label>Workspace:</label>
      <select id="workspaceSelect" style="min-width:340px"></select>
      <button onclick="loadTree()">Load</button>
      <input id="newWorkspaceName" placeholder="New workspace name" style="max-width:260px" />
      <button class="ok" onclick="createWorkspace()">Create Workspace</button>
    </div>
  </div>

  <div class="card tree" id="treeCard">
    <div class="header-line" style="margin-bottom:0;">
      <h3 style="margin:0">Workspace tree</h3>
      <button onclick="toggleTree()" id="treeToggleBtn">Collapse</button>
    </div>
    <div id="treeRoot" class="mini" style="margin-top:8px;">No tree loaded.</div>
  </div>

  <div class="card">
    <h3 style="margin-top:0">Content View (Read-only)</h3>
    <div id="contentView" class="content-view mini">Click a document/paper node to preview content here.</div>
  </div>
</div>

<div class="modal-bg" id="nodeModalBg">
  <div class="modal">
    <h3 id="modalTitle" style="margin:0 0 10px 0;">Node Actions</h3>

    <div class="row">
      <select id="docSelect"><option value="">Document</option></select>
      <button class="ok" id="addDocBtn">➕</button>
    </div>
    <div class="row">
      <select id="paperSelect"><option value="">Paper</option></select>
      <button class="ok" id="addPaperBtn">➕</button>
    </div>
    <div class="row">
      <input id="folderInput" placeholder="Folder" />
      <button class="ok" id="addFolderBtn">➕</button>
    </div>
    <div class="row">
      <input id="renameInput" placeholder="Rename selected node" />
      <button id="renameBtn">Rename</button>
    </div>
    <div class="row">
      <select id="moveParentSelect"></select>
      <button id="moveBtn">Move</button>
    </div>
    <div class="actions">
      <button id="saveBtn" class="ok">Save</button>
      <button id="deleteBtn" class="danger">Delete</button>
      <button onclick="closeModal()">Close</button>
    </div>
  </div>
</div>

<div class="modal-bg" id="devModalBg">
  <div class="modal" style="width:860px;">
    <h3 style="margin:0 0 10px 0;">Developer Panel</h3>
    <div class="card" style="margin:0 0 8px 0;">
      <h4 style="margin:0 0 8px 0;">Selected Node</h4>
      <pre id="selected">(none)</pre>
    </div>
    <div class="card" style="margin:0;">
      <h4 style="margin:0 0 8px 0;">Operation Log</h4>
      <pre id="ops" class="mini">No operations yet.</pre>
    </div>
    <div class="actions">
      <button onclick="closeDevModal()">Close</button>
    </div>
  </div>
</div>

<script>
const csrf = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
const headers = {'Content-Type':'application/json','X-CSRF-TOKEN':csrf};
let tree = null, selectedNode = null, openState = {}, docs = [], papers = [], opLog = [];

function log(msg, payload=null){
  const line = `[${new Date().toLocaleTimeString()}] ${msg}` + (payload ? `\n${JSON.stringify(payload,null,2)}`:'');
  opLog.unshift(line);
  document.getElementById('ops').textContent = opLog.slice(0,18).join('\n\n');
}

async function req(url, options={}){
  const r = await fetch(url, options);
  const t = await r.text();
  let d = null; try { d = t ? JSON.parse(t) : null; } catch { d = t; }
  if(!r.ok) throw new Error((d && d.message) ? d.message : `HTTP ${r.status}`);
  return d;
}

async function init(){ await Promise.all([loadRoots(), loadLookups()]); }
async function loadLookups(){ docs = await req('/workspace-sandbox/documents'); papers = await req('/workspace-sandbox/papers'); fillSelect('docSelect', docs, 'Document'); fillSelect('paperSelect', papers, 'Paper'); }
function fillSelect(id, items, placeholder){ const el = document.getElementById(id); el.innerHTML = `<option value="">${placeholder}</option>`; items.forEach(i=>{const o=document.createElement('option');o.value=i.id;o.textContent=i.name||`${placeholder} ${i.id}`;el.appendChild(o);}); }

async function loadRoots(){
  const roots = await req('/workspace-sandbox/roots');
  const s = document.getElementById('workspaceSelect'); s.innerHTML='';
  roots.forEach(r=>{ const o=document.createElement('option'); o.value=r.id; o.textContent=`${r.title} (${r.id})`; s.appendChild(o); });
  if(roots.length){ await loadTree(); }
}

async function loadTree(){
  const rootId = document.getElementById('workspaceSelect').value;
  if(!rootId) return;
  tree = await req(`/workspace-sandbox/tree/${rootId}`);
  selectedNode = tree;
  renderTree(); renderSelected(); renderMoveTargets();
}

function renderTree(){
  const host = document.getElementById('treeRoot'); host.innerHTML = '';
  if(!tree){ host.textContent='No tree loaded'; return; }
  const ul = document.createElement('ul'); ul.appendChild(renderNode(tree)); host.appendChild(ul);
}

function renderNode(node){
  const li = document.createElement('li');
  const row = document.createElement('div'); row.className='node-row';
  const hasChildren = node.children && node.children.length;
  const exp = document.createElement('button'); exp.className='icon-btn'; exp.textContent = hasChildren ? (openState[node.id]===false ? '▸':'▾') : '•'; exp.disabled=!hasChildren;
  exp.onclick=()=>{ openState[node.id] = !(openState[node.id]!==false); renderTree(); };
  const title = document.createElement('button'); title.className='node-title'+(selectedNode&&selectedNode.id===node.id?' selected':''); title.textContent=node.title;
  title.onclick=()=>selectNode(node);
  const meta = document.createElement('span'); meta.className='mini'; meta.textContent=node.nodeType;
  const act = document.createElement('button'); act.className='icon-btn'; act.textContent='⚙'; act.onclick=()=>{selectNode(node);openModal();};
  row.append(exp,title,meta,act); li.appendChild(row);
  if(hasChildren && openState[node.id]!==false){ const ul=document.createElement('ul'); node.children.forEach(c=>ul.appendChild(renderNode(c))); li.appendChild(ul); }
  return li;
}

function selectNode(node){ selectedNode=node; renderTree(); renderSelected(); renderMoveTargets(); if(node.nodeType==='document_link'||node.nodeType==='paper_link') loadContent(node.id); }
function renderSelected(){ document.getElementById('selected').textContent = selectedNode ? JSON.stringify(selectedNode,null,2) : '(none)'; }

async function loadContent(nodeId){
  const view = document.getElementById('contentView');
  view.textContent = 'Loading content...';
  try {
    const data = await req(`/workspace-sandbox/content/node/${nodeId}`);
    if (data.missing) { view.innerHTML = `<b>Linked content missing or no permission.</b>`; return; }
    if (data.type === 'document') {
      const src = data.officeViewerUrl || data.downloadUrl || data.directUrl || null;
      view.innerHTML = `<h4>${escapeHtml(data.title || 'Document')}</h4>
      <div class="mini">Created: ${escapeHtml(String(data.createdDate || ''))}</div>
      ${data.url ? `<div class="mini">Path: ${escapeHtml(data.url)}</div>` : ''}
      ${src ? `<iframe class="viewer" src="${src}"></iframe>` : '<div class="mini">No viewer source available.</div>'}
      <div class="mini" style="margin-top:8px;">If iframe is blocked by auth/CSP, use links: ${data.officeViewerUrl ? `<a href="${data.officeViewerUrl}" target="_blank">office viewer</a>`:''} ${data.downloadUrl ? ` | <a href="${data.downloadUrl}" target="_blank">download</a>`:''}</div>`;
      return;
    }
    if (data.type === 'paper') {
      view.innerHTML = `<h4>${escapeHtml(data.title || 'Paper')}</h4>
      <div class="mini">Type: ${escapeHtml(data.contentType || '')}</div>
      <div class="mini">Created: ${escapeHtml(String(data.createdDate || ''))}</div>
      <pre>${escapeHtml(data.text || '(no text)')}</pre>`;
      return;
    }
    view.innerHTML = `<div class="mini">${escapeHtml(data.title || 'Node selected')}</div>`;
  } catch (e) {
    view.textContent = `Error loading content: ${e.message}`;
  }
}

function flatten(node, acc=[]){ acc.push(node); (node.children||[]).forEach(c=>flatten(c,acc)); return acc; }
function renderMoveTargets(){ const s=document.getElementById('moveParentSelect'); s.innerHTML=''; if(!tree||!selectedNode)return; flatten(tree,[]).filter(n=>['workspace_root','folder'].includes(n.nodeType)&&n.id!==selectedNode.id).forEach(n=>{ const o=document.createElement('option'); o.value=n.id; o.textContent=`${n.title} (${n.nodeType})`; s.appendChild(o); }); }
function openModal(){ if(!selectedNode) return alert('Select a node first'); document.getElementById('modalTitle').textContent=`Node actions: ${selectedNode.title}`; document.getElementById('renameInput').value=selectedNode.title||''; const disableAdd=!['workspace_root','folder'].includes(selectedNode.nodeType); ['addDocBtn','addPaperBtn','addFolderBtn'].forEach(id=>document.getElementById(id).disabled=disableAdd); document.getElementById('deleteBtn').disabled=selectedNode.nodeType==='workspace_root'; document.getElementById('nodeModalBg').style.display='flex'; }
function closeModal(){ document.getElementById('nodeModalBg').style.display='none'; }
function openDevModal(){ document.getElementById('devModalBg').style.display='flex'; }
function closeDevModal(){ document.getElementById('devModalBg').style.display='none'; }
function toggleTree(){ const c=document.getElementById('treeCard'); c.classList.toggle('collapsed'); document.getElementById('treeToggleBtn').textContent = c.classList.contains('collapsed') ? 'Expand' : 'Collapse'; }

async function createWorkspace(){ try{ const title=document.getElementById('newWorkspaceName').value.trim(); if(!title)return alert('Workspace name required'); await req('/workspace-sandbox/roots',{method:'POST',headers,body:JSON.stringify({title})}); document.getElementById('newWorkspaceName').value=''; log('Created workspace',{title}); await loadRoots(); }catch(e){alert(e.message);} }

document.getElementById('addDocBtn').onclick = async()=>{ try{ const docId=document.getElementById('docSelect').value; if(!docId)return alert('Select document'); const d=docs.find(x=>x.id===docId); await req('/workspace-sandbox/nodes',{method:'POST',headers,body:JSON.stringify({workspaceRootId:tree.workspaceRootId||tree.id,parentId:selectedNode.id,nodeType:'document_link',title:d?.name||'Document',contentKind:'document',contentRef:docId})}); log('Added document link',{docId,parent:selectedNode.id}); await loadTree(); }catch(e){alert(e.message);} };
document.getElementById('addPaperBtn').onclick = async()=>{ try{ const paperId=document.getElementById('paperSelect').value; if(!paperId)return alert('Select paper'); const p=papers.find(x=>x.id===paperId); await req('/workspace-sandbox/nodes',{method:'POST',headers,body:JSON.stringify({workspaceRootId:tree.workspaceRootId||tree.id,parentId:selectedNode.id,nodeType:'paper_link',title:p?.name||'Paper',contentKind:'paper',contentRef:paperId})}); log('Added paper link',{paperId,parent:selectedNode.id}); await loadTree(); }catch(e){alert(e.message);} };
document.getElementById('addFolderBtn').onclick = async()=>{ try{ const folder=document.getElementById('folderInput').value.trim(); if(!folder)return alert('Folder required'); await req('/workspace-sandbox/nodes',{method:'POST',headers,body:JSON.stringify({workspaceRootId:tree.workspaceRootId||tree.id,parentId:selectedNode.id,nodeType:'folder',title:folder})}); document.getElementById('folderInput').value=''; log('Added folder',{folder,parent:selectedNode.id}); await loadTree(); }catch(e){alert(e.message);} };
document.getElementById('renameBtn').onclick = async()=>{ try{ const title=document.getElementById('renameInput').value.trim(); if(!title)return alert('Title required'); await req(`/workspace-sandbox/nodes/${selectedNode.id}/rename`,{method:'POST',headers,body:JSON.stringify({title})}); log('Renamed node',{id:selectedNode.id,title}); await loadTree(); }catch(e){alert(e.message);} };
document.getElementById('moveBtn').onclick = async()=>{ try{ const parentId=document.getElementById('moveParentSelect').value; if(!parentId)return alert('Choose destination'); await req(`/workspace-sandbox/nodes/${selectedNode.id}/move`,{method:'POST',headers,body:JSON.stringify({parentId,sortIndex:9999})}); log('Moved node',{id:selectedNode.id,parentId}); await loadTree(); }catch(e){alert(e.message);} };
document.getElementById('deleteBtn').onclick = async()=>{ try{ if(!confirm('Delete selected node structurally?'))return; await req(`/workspace-sandbox/nodes/${selectedNode.id}/delete`,{method:'POST',headers}); log('Deleted node',{id:selectedNode.id}); await loadTree(); closeModal(); }catch(e){alert(e.message);} };
document.getElementById('saveBtn').onclick = ()=>{ log('Save clicked (autosave mode)',{selected:selectedNode?.id}); closeModal(); };

function escapeHtml(v){ return String(v).replaceAll('&','&amp;').replaceAll('<','&lt;').replaceAll('>','&gt;').replaceAll('"','&quot;').replaceAll("'",'&#39;'); }

init().catch(e=>{ document.getElementById('treeRoot').textContent=`Init error: ${e.message}`; });
</script>
</body>
</html>
