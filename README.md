# Step 4: Database Service

## Overview
In this step, we will implement a `DatabaseService` object for interacting with our Cloud Firestore database.

## Resources

This step is primarily based on the [Flutter & Firebase App playlist](https://youtube.com/playlist?list=PL4cUxeGkcC9j--TKIdkb3ISfRbJeJYQwC) from The Net Ninja on YouTube, primarily
- [#16 - Firestore Database Setup](https://youtu.be/mtNA1neFNVo)
- [#18 - Firestore Streams](https://youtu.be/10PcEkQsF9Y)

## Objectives
By the end of this step, make sure you have
- [ ] Created a `services` subfolder of `lib`
- [ ] Created a `database.dart` file with a `DatabaseService` class
- [ ] Declared a `CollectionReference` variable to the 'queues' collection in your database
- [ ] Written a `queueEntries` function returning a `Stream` of all the queue entries for the given `Queue`
- [ ] Written a `addQueueEntry` function for adding a new queue to the queue collection in your database for the given input data
