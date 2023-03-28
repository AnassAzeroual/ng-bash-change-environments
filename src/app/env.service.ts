import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { of } from 'rxjs';
import * as sampleData from '../assets/config.json';

type Config = typeof sampleData;
@Injectable({
  providedIn: 'root'
})
export class EnvService {
  config: Config = { ...sampleData };

  constructor(private http: HttpClient) { }

  loadConfig() {
    return of<Config>(this.config)
  }

}
