import { environmentConfig, EnvService } from './env.service';
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  envConfig!: environmentConfig
  constructor(private srvConfig: EnvService) {
    this.envConfig = srvConfig.config
  }
  title = 'projectTest';
}
