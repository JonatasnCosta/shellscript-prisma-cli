#!/bin/bash
#prisma install

echo "Prisma install"

npm install prisma  --save-dev

echo "Creating Prisma CLI initial configuration"

npx prisma init

projectPath=$(pwd) 

cd $projectPath

echo "Configuring the .env file"

rm .env

echo "What is the project's SGDB ?"
read sgdbName

echo "What's the username ?"
read userName

echo "What is the bank password ?"
read passwordName

echo "What is the bank door?"
read bankDoorName

echo "What is the name of the bank?"
read bankName

touch .env

envCleaning="DATABASE_URL=\"$sgdbName://$userName:$passwordName@localhost:$bankDoorName/$bankName\""


echo "$envCleaning" > .env

projectPath=$(pwd)

cd $projectPath/prisma

rm schema.prisma

schemaPrismaCleaning="generator client {
  provider = "\"prisma-client-js"\"
}

datasource db {
  provider = "\"$sgdbName\""
  url      = env("\"DATABASE_URL"\")
}"

echo "$schemaPrismaCleaning" > schema.prisma

npx prisma db pull

npx prisma generate

cd $projectPath/src

mkdir prisma 

cd $projectPath/src/prisma

touch prisma.module.ts

prismaModuleCleaning="
import { PrismaService } from './prisma.service';
import { Module } from '@nestjs/common';

@Module({
    providers: [PrismaService],
    exports:[PrismaService]
})
export class PrismaModule { }
"
echo "$prismaModuleCleaning" > prisma.module.ts


touch prisma.service.ts

connect="connect"
on="on"  

prismaServiceCleaning="import { INestApplication, Injectable, OnModuleInit } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class PrismaService extends PrismaClient implements OnModuleInit {
  async onModuleInit() {
    await this.\$connect();
  }

  async enableShutdownHooks(app: INestApplication) {
    process.on('beforeExit', async () => {
      await app.close();
    });
  }
}"


echo "$prismaServiceCleaning" > prisma.service.ts



