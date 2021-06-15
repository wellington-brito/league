# league
A Flutter basic aplication  to practice dart language.
This application will be connect to riot's API to get list of all champions of league of legends and show you details in the screen.


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


>### v0.0.1
>>Static List<br>ok
>this version is showing list from hardcode array;

>### v0.0.2
>>Connect to riot's API<br>
>this version will get a json list from riot's API

>### v0.0.3
>>Data and json objects
>this version will manipulate json list and convert to objects and start to do design layout of app.

>### v0.0.4
>>Automated testing
>for this version i'm going to do some tests to learn about automated testing in flutter aplication.
>removed champion's count from toolbar, causing 'late' error by call of _apiResponse...
>error late initialization _responseApi. Estudar mais sobre controle de estado e future...
>Navigation.push to second screen for search summoner. In future I want search my history matches and compare with another player too...

>

>### v0.0.5
>>StorageData and assets
>for this version i'm going to do implement local data storage for data of champions list 
>


>### Main Troubles
- [Insecure HTTP connections are disabled by default on iOS and Android](https://flutter.dev/docs/release/breaking-changes/network-policy-ios-android)