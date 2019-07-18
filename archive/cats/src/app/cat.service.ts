import { Injectable } from '@angular/core';
import { Observable } from 'rxjs/Observable';
import { HttpClient } from '@angular/common/http';
import { map, tap } from 'rxjs/operators';

import { Cat } from './cat';

@Injectable({
  providedIn: 'root',
})
export class CatService {
  constructor(private http: HttpClient) {}

  private apiPath: string = "http://catsapi-env.nmm6usvepa.us-west-2.elasticbeanstalk.com/";

  getAllCats(): Observable<Cat[]> {
    return this.http.get<Cat[]>(this.apiPath)
      //.map((response:Response) => response.json())
      .pipe(
        tap(cats => console.log(cats))
      );
  }

  getCat(name: string): Observable<Cat> {
    return this.http.get<Cat>(this.apiPath + name);
  }

  insertCat(cat: Cat): Observable<Cat> {
    return this.http.post<Cat>(this.apiPath, cat);
  }

  updateCat(cat: Cat): Observable<void> {
    return this.http.put<void>(this.apiPath + cat.name, cat);
  }

  deleteCat(name: string) {
    return this.http.delete(this.apiPath + name);
  }
}