# ``WeatherApp``

Weather app is a design showcase skill app. As an developer i want to showcase my design principles, SOLID, app architecture skills. 

## Overview
- App is designed using MVVM pattern.
- Structures concurrency is used to publish values from viewModel to view.

## Topics

* High Level Design : As mentioned in UML Diagram 
* Low Level Design : As mentioned in UML Diagram 

## Architecture
- App is designed under SOLID and MVVM principles using modern structured concurrency frameworks.
- Classes/Modules are bounded by interfaces to provide scalability.
- Factory pattern is used to get Helper, Repos, Coordinater classes.
- Repo pattern is used to get Data.

## Unit Tests:
- ViewModels, Repos and Business use-case classes tested.

## Bench Testing / Fault forceble analysis
- Test with positive flow : App should show data
- Test with invalid API : App should show error.
- Test with no INtertnet : App should show error
- Test with wrong url.

## What's Next ?
- Encryption for API-Keys
- Local cache for frequent api hits.
- Test coverage could be increased.
- Jenkins, CI/CD support.
- Increase test coverage by testing simple helper.
- Integrate SonarQube
- Improoved UI/UX
- Sending API-KEY in GET url is risky, need to think of sending API-Key securely.
