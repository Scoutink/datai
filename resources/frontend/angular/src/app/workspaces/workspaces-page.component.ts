import { CdkDragDrop, moveItemInArray } from '@angular/cdk/drag-drop';
import { Component, OnInit } from '@angular/core';
import { WorkspacesService } from './workspaces.service';

type Node = any;

@Component({
  selector: 'app-workspaces-page',
  templateUrl: './workspaces-page.component.html',
  styleUrls: ['./workspaces-page.component.scss'],
})
export class WorkspacesPageComponent implements OnInit {
  roots: Node[] = [];
  rootId = '';
  root: Node | null = null;
  selectedNode: Node | null = null;
  selectedDocumentId = '';
  selectedPaperId = '';
  folderName = '';
  search = '';
  panelExpanded = true;
  assignedDocuments: any[] = [];
  myPapers: any[] = [];
  recents: any[] = [];
  favorites: any[] = [];

  constructor(
    private workspacesService: WorkspacesService,
  ) {}

  ngOnInit(): void {
    this.panelExpanded = sessionStorage.getItem('workspace.panel') !== 'collapsed';
    this.loadRoots();
    this.workspacesService.assignedDocuments().subscribe((x: any) => this.assignedDocuments = x || []);
    this.workspacesService.assignedPapers().subscribe((x: any) => this.myPapers = x || []);
    this.refreshShortcuts();
  }

  refreshShortcuts() {
    this.workspacesService.favorites().subscribe(x => this.favorites = x || []);
    this.workspacesService.recents().subscribe(x => this.recents = x || []);
  }

  loadRoots() {
    this.workspacesService.roots().subscribe((roots) => {
      this.roots = roots || [];
      if (!this.rootId && this.roots.length) {
        this.rootId = this.roots[0].id;
      }
      if (this.rootId) this.loadTree();
    });
  }

  loadTree() {
    if (!this.rootId) return;
    this.workspacesService.tree(this.rootId).subscribe((root) => this.root = root);
  }

  createWorkspace(name: string, description: string) {
    this.workspacesService.createRoot({ title: name, description }).subscribe((node) => {
      this.roots.push(node);
      this.rootId = node.id;
      this.loadTree();
    });
  }

  addFolder(target: Node) {
    if (!this.folderName.trim()) return;
    this.workspacesService.addNode({ workspaceRootId: this.rootId, parentId: target.id, nodeType: 'folder', title: this.folderName.trim() }).subscribe((node) => {
      target.children = target.children || [];
      target.children.push({ ...node, children: [] });
      target.expanded = true;
      this.selectedNode = node;
      this.folderName = '';
    });
  }

  addDocument(target: Node) {
    if (!this.selectedDocumentId) return;
    const doc = this.assignedDocuments.find((x: any) => x.id === this.selectedDocumentId);
    this.workspacesService.addNode({ workspaceRootId: this.rootId, parentId: target.id, nodeType: 'document_link', title: doc?.name || 'Document', contentKind: 'document', contentRef: this.selectedDocumentId }).subscribe((node) => {
      target.children = target.children || [];
      target.children.push({ ...node, children: [] });
      target.expanded = true;
    });
  }

  addPaper(target: Node) {
    if (!this.selectedPaperId) return;
    const p = this.myPapers.find((x: any) => x.id === this.selectedPaperId);
    this.workspacesService.addNode({ workspaceRootId: this.rootId, parentId: target.id, nodeType: 'paper_link', title: p?.name || 'Paper', contentKind: 'paper', contentRef: this.selectedPaperId }).subscribe((node) => {
      target.children = target.children || [];
      target.children.push({ ...node, children: [] });
      target.expanded = true;
    });
  }

  onSelect(node: Node) {
    this.selectedNode = node;
    if (node.nodeType === 'folder' || node.nodeType === 'workspace_root') node.expanded = !node.expanded;
    if (node.nodeType === 'document_link' || node.nodeType === 'paper_link') this.workspacesService.markRecent(node.id).subscribe(() => this.refreshShortcuts());
  }

  structuralDelete(node: Node) {
    this.workspacesService.deleteNode(node.id).subscribe(() => this.loadTree());
  }

  togglePanel() {
    this.panelExpanded = !this.panelExpanded;
    sessionStorage.setItem('workspace.panel', this.panelExpanded ? 'expanded' : 'collapsed');
  }

  dropSiblings(event: CdkDragDrop<Node[]>, parent: Node) {
    const items = parent.children || [];
    moveItemInArray(items, event.previousIndex, event.currentIndex);
    parent.children = [...items];
    parent.children.forEach((item: Node, idx: number) => {
      this.workspacesService.moveNode(item.id, { parentId: parent.id, sortIndex: idx }).subscribe();
    });
  }

  moveToSelectedFolder(node: Node) {
    if (!this.selectedNode || (this.selectedNode.nodeType !== 'folder' && this.selectedNode.nodeType !== 'workspace_root')) return;
    this.workspacesService.moveNode(node.id, { parentId: this.selectedNode.id, sortIndex: (this.selectedNode.children || []).length }).subscribe(() => this.loadTree());
  }

  toggleFavorite(node: Node) {
    this.workspacesService.toggleFavorite(node.id).subscribe(() => this.refreshShortcuts());
  }

  filteredChildren(parent: Node): Node[] {
    const children = parent?.children || [];
    if (!this.search) return children;
    const s = this.search.toLowerCase();
    return children.filter((x: Node) => (x.title || '').toLowerCase().includes(s));
  }
}
