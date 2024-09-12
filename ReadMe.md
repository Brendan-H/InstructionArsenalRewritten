# InstructionArsenal

Welcome to InstructionArsenal, an app that has everything you need to do whatever you want. Choose to see either official instructions from a verified source on something like one of their products or community-made instructions (which can be rated by anyone in order to prevent abuse) on just about any topic.

Note: This repository is public because I like the app that I made. However, some of the choices I have made along the way have held InstructionArsenal back. In fact, the code you will see is actually the 3rd version of the app, after 2 complete rewrites. This original code had no real state management whatsoever and used Firebase's Firestore as a database. When I rewrote the code, I removed all Firebase dependencies and changed the authentication to be http basic auth. This, however is not very secure. With that in mind, I rewrote the app a second time, adding Firebase back (but only for authentication) and adding in Riverpod for state management. Still, this code is not perfect. I learned a lot from writing InstructionArsenal that I applied to MathMatchup, my newest app (and also the one with the nicest code). Since I no longer support InstructionArsenal, many things have been deprecated or changed drastically. For example, firebase_dynamic_links was sunset and Material 3 became the new standard for flutter. This means that any created dynamic links will not work and some UI features (most notably buttons) will look a little odd. If I have time, I will fix this, but for now, the app is provided as-is.

## App Features

- Secure authentication using Firebase
- Users can view, but not post, instructions until they verify their email
- Detailed view of instructions including creator information, description, difficulty, and time to complete
- Rating system protects users from bad instructions and allows them to warn others by rating instruction quality
- Efficient state management using Riverpod
- Error handling using Firebase Analytics
- Deep linking using firebase_deep_links (e.g instructionarsenal.brendanharan.com/instructions/1234 will bring you to those instructions)
- Quick sharing of instructions with auto-generated short links

## Backend Features

- Efficient CRUD operations on instructions
- Fast database search using a variety of different queries
- Request logging for analytics 
- JPA and Hibernate for ORM and database operations
- Easily extendable service, controller, and repository layers
- RESTful endpoints for instructions
- Endpoint authorization to protect users from accessing what they're not supposed to, while preventing spam
- Only users with verified emails are allowed to post instructions, but they can view ones others post

Technologies: Dart + Flutter, Java + Spring, PostgreSQL

## Screenshots

<img src="https://github.com/Brendan-H/InstructionArsenalRewritten/blob/master/instruction_arsenal/Screenshots/login_page.png" width="250"><img src="https://github.com/Brendan-H/InstructionArsenalRewritten/blob/master/instruction_arsenal/Screenshots/official_instructions_page.png" width="250"><img src="https://github.com/Brendan-H/InstructionArsenalRewritten/blob/master/instruction_arsenal/Screenshots/community_made_instructions_page.png" width="250"><img src="https://github.com/Brendan-H/InstructionArsenalRewritten/blob/master/instruction_arsenal/Screenshots/bookmarks_page.png" width="250"><img src="https://github.com/Brendan-H/InstructionArsenalRewritten/blob/master/instruction_arsenal/Screenshots/hamburger_menu.png" width="250">


## Running InstructionArsenal Spring backend
1. Install Java 17 and PostgreSQL 16.3
2. Create a Postgres database (```psql``` then ```CREATE database InstructionArsenal;```)
3. Modify application.properties (```MathMatchupBackend/src/main/resources/application.properties```) with database details
4. Run the Spring backend

## Running InstructionArsenal Flutter frontend

1. Install the [Flutter](https://flutter.dev) framework
2. Run ```flutter pub get```
3. and ```dart run build_runner watch -d```
4. then ```flutter run``` or ```flutter build app --release``` to compile an apk for installation on android or ```flutter build web``` to compile for deployment to the web