import { Component, OnInit } from '@angular/core';

import {Cat} from '../cat';
import {CatService} from '../cat.service';

@Component({
  selector: 'app-cats',
  templateUrl: './cats.component.html',
  styleUrls: ['./cats.component.css']
})
export class CatsComponent implements OnInit {

  cats: Cat[];
  rawData: string;

  constructor(private catService: CatService) { }

  ngOnInit() {
    this.getCats();
  }

  getCats(): void {
    this.catService.getAllCats()
      .subscribe(cats => {
        this.cats = cats;
        //this.rawData = cats.toString();
      });
  }


}
