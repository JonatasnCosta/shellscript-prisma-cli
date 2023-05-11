#!/bin/bash

#prisma install

echo "Prisma install"

npm install prisma --save-dev

echo "Creating Prisma CLI initial configuration"

npx prisma init