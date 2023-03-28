import { APP_INITIALIZER, NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule } from '@angular/common/http';
import { AppComponent } from './app.component';
import { EnvService } from './env.service';


export const configFactory = (envService: EnvService) => {
  return () => envService.loadConfig();
};

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    HttpClientModule
  ],
  providers: [
    {
      provide: APP_INITIALIZER,
      useFactory: configFactory,
      deps: [EnvService],
      multi: true
    }
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
