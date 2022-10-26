import { Module } from '@nestjs/common';
// import { Routes, RouterModule } from '@nestjs/core';
import { ConfigModule } from '@nestjs/config';

import AppController from './app.controller';
import AppService from './app.service';

// const routes: Routes = [
//   {
//     path: '/',
//     children: [{ path: '/children', module: ChildrenModule }],
//   },
// ];

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    //   ImagesModule,
    //   RouterModule.register(routes),
  ],
  controllers: [AppController],
  providers: [AppService],
  exports: [AppService],
})
export default class AppModule {}
