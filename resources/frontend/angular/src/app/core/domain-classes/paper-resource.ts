import { ResourceParameter } from './resource-parameter';

export class PaperResource extends ResourceParameter {
    id?: string = '';
    createdBy?: string = '';
    categoryId?: string = '';
    createDate?: string;
    clientId?: string = '';
    statusId?: string = '';
    paperId?: string = '';
    override metaTags: string = '';
}
