### App Current Weather flow.

<div hidden>

@startuml
title 'High Level Design'
skin rose
start

: App Launched;
: Get Current Weather Button Tap;
: Get Current Location;
switch (check Location Permission)
case (denied)
 : Show user prompt and goto settings;
 : Fetch Current Weather from Repo;
 : onResponse Update ViewModel and View;
case (unknown)
 : Ask first time location permission;
 : Fetch Current Weather from Repo;
 : onResponse Update ViewModel and View;
case (authorised)
 : Fetch Current Weather from Repo;
 : onResponse Update ViewModel and View;
endswitch
stop
@enduml

</div>


