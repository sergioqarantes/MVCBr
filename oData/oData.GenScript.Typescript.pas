unit oData.GenScript.Typescript;

interface

uses System.Classes, System.SysUtils;

implementation

uses oData.GenScript, oData.ServiceModel,
  System.Json;

function GerarNg5Script: string;
var
  str: TStringList;
  serv: TJsonArray;
  it: TJsonValue;
  AResource: string;
  AMethod: string;
begin
  str := TStringList.create;
  with str do
    try
      add('/// <summary>                                 ');
      add('/// ODataBr - Generate NG5 Script                           ');
      add('/// Date: ' + DateTimeToStr(now) + '                          ');
      add('/// Auth:  amarildo lacerda - tireideletra.com.br           ');
      add('///        gerado pelo Servidor ODataBr: .../OData/hello/ng   ');
      add('/// </summary>                                 ');
      add('');
      add('import { Injectable, Inject } from ''@angular/core'';');
      add('import { HttpClient, HttpHeaders } from ''@angular/common/http'';');
      add('import { ODataProviderService,ODataFactory,ODataService } from ''./odata-provider.service'';');
      add('import { Observable } from ''rxjs/Rx'';');
      add('');
      add('export interface ODataBrQuery extends ODataService{} ');
      add('');
      add('@Injectable()');
      add('export class ODataBrProvider {');
      add('  token:string=""; ');
      add('  urlBase:string=""; ');
      add('  urlPort:number = 8080; ');
      add('  headers: HttpHeaders;');
      add('');
      add('  port(aPort:number):ODataBrProvider{');
      add('     this.urlPort = aPort;');
      add('     return this;');
      add('  } ');
      add('  url(aUrl:string):ODataBrProvider{');
      add('    this.urlBase = aUrl;');
      add('    return this;');
      add('  }');
      add('');

      add('  getJson(url:string):Observable<any>{');
      add('    this.configOptions();');
      add('    return this._odata.getJson(url);');
      add('  }');

      add('  getOData(query:ODataService):ODataProviderService{');
      add('    this.configOptions();');
      add('    return this._odata.getValue(query);');
      add('  }');

      add('  private configOptions(){ ');
      add('      if (this.token!="") { this._odata.token = this.token; }; ');
      add('      this._odata.createUrlBase(this.urlBase,this.urlPort); ');
      add('      if (this.headers.keys().length>0) {');
      add('        //this._odata.headers.clear;');
      add('        for(let item of this.headers.keys() ){ ');
      add('          this._odata.headers.set(item,this.headers.get(item));');
      add('         }');
      add('      }');

      add('  }');
      add('');
      add('constructor(private _odata:ODataProviderService ) {');
      add('       this.headers = new HttpHeaders(); ');
      add('}');

      add('getItem(query: ODataBrQuery): ODataProviderService {');
      add('  this.configOptions();');
      add('  return this._odata.getValue(query);');
      add('}');
      add('postItem(resource: string, item: any, erroProc: any = null): Observable<any> {');
      add('  this.configOptions();');
      add('  return this._odata.postItem(resource, item, erroProc);');
      add('}');
      add('');
      add('putItem(resource: string, item: any, erroProc: any = null): Observable<any> {');
      add('  this.configOptions();');
      add('  return this._odata.putItem(resource, item, erroProc);');
      add('}');
      add('');
      add('deleteItem(resource: string, item: any, erroProc: any = null): Observable<any> {');
      add('  this.configOptions();');
      add('  return this._odata.deleteItem(resource, item, erroProc);');
      add('}');
      add('');
      add('patchItem(resource: string, item: any, erroProc: any = null): Observable<any> {');
      add('  this.configOptions();');
      add('  return this._odata.patchItem(resource, item, erroProc);');
      add('}');

      if TODataServices.TryGetODataService(ODataServices.LockJson, serv) then
        try
          for it in serv do
            if it.TryGetValue<string>('resource', AResource) then
              if it.TryGetValue<string>('method', AMethod) then
              begin
                if AMethod.Contains('GET') then
                begin
                  add('   get_' + AResource +
                    '( query:ODataBrQuery ):ODataProviderService { ');
                  add('      this.configOptions(); ');
                  add('      query.resource = "' + AResource +
                    '"+(query.join?query.join:"");');
                  add('      return this._odata.getValue( query ); ');
                  add('   }');
                  add('');
                end;
                if AMethod.Contains('PUT') then
                begin
                  add('   put_' + AResource +
                    '( item: any, erroProc:any=null): Observable<any> { ');
                  add('      this.configOptions(); ');
                  add('      return this._odata.putItem("' + AResource +
                    '", item, erroProc ); ');
                  add('   }');
                  add('');
                end;
                if AMethod.Contains('POST') then
                begin
                  add('   post_' + AResource +
                    '( item: any, erroProc:any=null): Observable<any> { ');
                  add('      this.configOptions(); ');
                  add('      return this._odata.postItem("' + AResource +
                    '", item, erroProc ); ');
                  add('   }');
                  add('');
                end;
                if AMethod.Contains('PATCH') then
                begin
                  add('   patch_' + AResource +
                    '( item: any, erroProc:any=null): Observable<any> { ');
                  add('      this.configOptions(); ');
                  add('      return this._odata.patchItem("' + AResource +
                    '", item, erroProc ); ');
                  add('   }');
                  add('');
                end;
                if AMethod.Contains('DELETE') then
                begin
                  add('   delete_' + AResource +
                    '( item: any, erroProc:any=null): Observable<any> { ');
                  add('      this.configOptions(); ');
                  add('      return this._odata.deleteItem("' + AResource +
                    '", item, erroProc ); ');
                  add('   }');
                  add('');
                end;
              end;
        finally
          ODataServices.UnlockJson;
        end;

      add('}');
      result := str.text;
    finally
      str.free;
    end;
end;

initialization

TODataGenScript.register('ng', GerarNg5Script);

end.
