# Disclaimer

The `Forecaster` has been build being inspired by Apple's `Weather` app.
On the main view (Search View) the current Search State is presented (no data, loading, failure, search results). By inputting the text in search bar on the view's bottom an API call is made. The results are presented as a scrollable list. If a location is selected form the list - the search bar is cleared, a tile for the selected city is presented on the screen and the selection is stored in persistant store so the lsit is presented every time the app is launched.
By selecting the city tile - navigation moves to the forecast view. There are presented all the fetched weather forecast information about the seelcted location.
# Architecture

## Project Structure

Forecaster is organized into the following directories:

- **`Dependency Injection`**  
  Defines and manages dependencies that can be injected into and consumed by other components.

- **`Domain`**  
  Contains domain-specific components, including reusable UI components, data models (entities), repository contracts, and business logic.

- **`Modules`**  
  Contains individual application screens, along with their corresponding ViewModels responsible for presentation logic and state management.

- **`Services`**
  - **`Networking`**  
    Handles API communication, HTTP requests, responses, and network errors.

  - **`Open Meteo`**  
    Defines Open-Meteo-specific data transfer objects (DTOs) and response models.

  - **`Persistent Store`**  
    Manages persistent storage and retrieval of historical data.

  - **`Repositories`**  
    Provides abstractions over data sources, such as remote APIs and persistent storage.
## Layers

The project is build with multiple layers with individual role:

- **Repository**  
  Domain holds repositories abstractions/schemes (protocols) defining their responsibilities. Services instead define repositories implementation. There, they are responsible to request data from API (networking layer), persistant store (store and save data) and prepare data with additional processing if applicable.

- **Networking**  
  Define API client, endpoints, builds API requests and handle network errors.

- **Persistant Store**  
  Responsible for data storage and retrival operations. For the purpose of the task it is built with User Defaults being enough for search selections storage.

-   **Data models**  
  Domain holds Entities that specifies data models consumed by the Application directly.  Services instead, withn Open Meteo directory hold Data Transfer Objects (DTO) associated directly with the Open Meteo API. Each DTO could be mapped to domain entity using `toDomain()` method.

-   **Components**  
  Gather all reusable Views consumed across application.

- **`View`**  
  Responsible for presenting ready data and states.

- **`View Model`**
Holds logic, prepares data for presentation by the View. It request repositories for data operations.

- **Dependency injection**
// to fulfill

# Features

## City search

### Visual representation
The `SearchView` presents the Search module's View. It is built with a few components nested in `NavigationStack` - application navigation provider between views.
- `header`
Text being the View's title.

- `content`
Presents various views depending on the current `Search State` 
  - `start` - show saved selected cities
  - `loading` - show a loading view (progress bar with a message)
  - `empty` - show an empty state view with a message
  - `failure` - show search failure state view with a message
  - `results` - show `CitiesResultsStateView` presenting the search query results as a scrollable list of locations

- `search bar`
Built with `SearchBarView` component. It takes input parameters:
  - `state: SearchBarState` - holds all search bar possible states
    - `empty` - when search bar text field is empty (just activated or cleared with "x" button)
    - `valid(String)` - set when search text query passes validation
    - `invalid(String)` - set when the search text query does not pass the validation. In a result a simple error message is presented underneath the search bar view.
  - `onSearch` completion handler - called on manual query submission (manual "search" button action)
  - `onCancel` completion handler - called on `cancel` button action. This button is presented on the right side of the search bar. It results in quiting the text field focus state, clearing search field and setting empty state.
### Validation mechanism
The validation mechanism is built with a few components:
- `Validator` protocol - that predefines common `isValid` method that takes text input and returns boolean validation result
- `ValidatorType` enum - listing all exisitng validator types and a corresponding Validator implementation (e.g. `CityNameValidator()`)
- `string extension` - defining an `isValid` method that takes validators list (about to apply to the text) and returnin boolean validation result. This method iterates through all given validators and checks whether all are satisfied for the given text.

This mechanism is easily extendable by appying other validarors (type + implementation) and extension for other data types as needed.

#### Example
The `Search Bar View` calls the validation mechinsm each time the text field's input changes. It applies `.cityName` validator type that validates the input with `CityNameValidator`. In this very example the validation result allows to decide whether the `Search Bar State` should be set to `valid` or `invalid`.
