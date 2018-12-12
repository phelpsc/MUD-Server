# MUD-Server

KitMud is a project to rebuild a MUD (Multi-User Dungeon) engine, specifically a Diku/Emlen hybrid, from scratch using pure Ruby.

## About

This engine is designed to use a websocket connection with the browser-based KitGameClient. When complete, it will come with a standard installation of world values and rooms. It is built with the intention to work for a small number of players only.


### Gem Dependencies

```
Rubame - Websocket server
Mysql2 - Database layer
Timers - For creating server tick timers
```

### DBConfig.rb

I did not include my DBConfig.rb file, but you can simply replace the Mysql2 instantiation with your own host, user, password, and database.

### TODO

* Include database schema and setup
