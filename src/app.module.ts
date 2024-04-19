import { Module } from "@nestjs/common";
import { AppController } from "./app.controller";
import { AppService } from "./app.service";
import { TypeOrmModule } from "@nestjs/typeorm";
import { ConfigModule } from "@nestjs/config";

@Module({
  imports: [
    ConfigModule.forRoot(),
    TypeOrmModule.forRoot({
      type: "postgres",
      host: process.env.PG_HOST,
      port: 5432,
      username: "bsiuser",
      password: "passpass",
      database: "bsi",
      entities: [],
      synchronize: true
    })
  ],

  controllers: [AppController],
  providers: [AppService]
})
export class AppModule {
}
