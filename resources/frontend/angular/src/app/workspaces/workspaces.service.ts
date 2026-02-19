import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({ providedIn: 'root' })
export class WorkspacesService {
  constructor(private http: HttpClient) {}

  roots() { return this.http.get<any[]>('workspaces'); }

  assignedDocuments() { return this.http.get<any[]>('document/assignedDocuments'); }
  assignedPapers() { return this.http.get<any[]>('papers/assigned'); }

  tree(id: string) { return this.http.get<any>(`workspaces/${id}/tree`); }
  createRoot(payload: any) { return this.http.post<any>('workspaces', payload); }
  addNode(payload: any) { return this.http.post<any>('workspaces/nodes', payload); }
  moveNode(id: string, payload: any) { return this.http.put(`workspaces/nodes/${id}/move`, payload); }
  deleteNode(id: string) { return this.http.delete<any>(`workspaces/nodes/${id}`); }
  favorites() { return this.http.get<any[]>('workspaces/favorites'); }
  recents() { return this.http.get<any[]>('workspaces/recents'); }
  toggleFavorite(id: string) { return this.http.post(`workspaces/nodes/${id}/favorite`, {}); }
  markRecent(id: string) { return this.http.post(`workspaces/nodes/${id}/recent`, {}); }
}
