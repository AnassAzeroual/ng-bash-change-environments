import { Component } from '@angular/core';
import { config } from "../assets/config";
@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  envConfig!: typeof config
  constructor() {
    this.envConfig = config
  }
  title = 'projectTest';
}
