# Fly365-MS
Fly365 iOS Demo App

The app Works only with round-trip for the sake of time, but the controllers structure built to handle any type of search (one-way, multi-city)

### About the app

- Swift 4.2 has been used, it's better to use Xcode 10.1 or later to open it
- It build on the idea of the leg so it accesspts number of legs,  in round-trip I get the info as one trip and in background I add another trip with swapped Origin and Destination.
- I used MVVM arcticture with closures as callbacks and the network layer is seperated.
- Models were mirrored to the one from Api with some added fields
- the end result from response is a Flight which has Legs,  each leg has Segments, and each segment has Stopps if there any.
