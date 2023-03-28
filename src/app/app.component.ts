import { EnvService } from './env.service';
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  constructor(private srvConfig: EnvService) {
    srvConfig.loadConfig().subscribe(res => {
      console.log(res);
    })
    console.log(srvConfig.config);

  }
  title = 'projectTest';
}
