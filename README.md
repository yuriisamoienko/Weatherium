# Weatherium

The goal of this project is to build a simple and lightweight weather mobile applications. The app contains 2 screens :
- Home Screen - A tableview with search bar containing the weather for a list of main cities.
- City weather - A tableview with the weather for the next 5 days for the selected city.

In the multi city screen each cell should contain the following: 
- Icon representing the weather
- Name of the city
- Description of the weather
- Max and min temperatures

The single city page :
- Icon representing the weather
- Day
- Description of the weather 
- Max and Min temperatures

Also implemented:
- Caching - cache locally (in memory) the responses from the api and use them when applicable instead of making a new call to the api
- Fahrenheit <-> Celsius - right navbar button to toggle between these termerature units
- icons caching with CachedAsyncImage

Remarks:
- Swift Concurrecny and Combine are used to have some Demo with the technologies
- 'country: Philippines' was added to 'Manila' city, because Geocoder couldn't resolve original value without specific country
- NavigationRouter curently is as abstract as possible
- Dark mode isn't supported yet

Thanks to:
- icon creators https://www.flaticon.com/free-icons/weather
- lorenzofiamingo https://github.com/lorenzofiamingo/swiftui-cached-async-image
