#!/bin/bash -xe
git clone https://github.com/ethereum/sourcify.git
cd sourcify
git checkout 195f6874a42e3022ca65dbff38ddadbbae191897
cd services/database
sed -i "s/localhost/$POSTGRES_HOST/g" database.json
npm install
npm install async

while ! </dev/tcp/$POSTGRES_HOST/$POSTGRES_PORT; do
  echo "$POSTGRES_HOST:$POSTGRES_PORT isn't up. waiting ..."
  sleep 5;
done;

npm run migrate:up
