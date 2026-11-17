# Disclaimer

The `Forecaster` has been build being inspired by Apple's `Weather` app.
On the main view (Search View) the current Search State is presented (no data, loading, failure, search results). By inputting the text in search bar on the view's bottom an API call is made. The results are presented as a scrollable list. If a location is selected form the list - the search bar is cleared, a tile for the selected city is presented on the screen and the selection is stored in Persistent Store so the lsit is presented every time the app is launched.
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
  Domain holds repositories abstractions/schemes (protocols) defining their responsibilities. Services instead define repositories implementation. There, they are responsible to request data from API (networking layer), persistent store (store and save data) and prepare data with additional processing if applicable.

- **Networking**  
  Define API client, endpoints, builds API requests and handle network errors.

- **Persistent Store**  
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
  - `initial` - show the loading view before the initial stored cities loading begins
  - `start` - show saved selected cities
  - `loadingStore` - show the loading view while reading stored cities, the search bar is disabled
  - `loadingSearch` - show the loading view while searching, the search bar remains enabled
  - `loadingCancelled` - show a button to retry reading stored cities
  - `empty` - show an empty state view with a message
  - `failure` - show a failure message, or a retry button for `persistentStoreLoad`
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

### Store selected cities

Selecting a city requests a save through `PersistentStoreRepository`. After a successful save, the ViewModel updates `storedCities` and invokes the success callback that clears the search.

The ViewModel begins in `initial state`. The view's `.task` calls `loadCities()`, which changes the state to `loadingStore`. Both states disable the search bar and prevent query updates or manual submission. The separate search task does not overwrite the initial load or retry screens.

A successful read updates `storedCities` and changes the state to `start`. This completes the initial read for that ViewModel instance, including when the result is an empty array. Later calls to `loadCities()` in normal search states results in not treating an empty array as a trigger that loading is still required.

Cancellation is checked before the read and before publishing its result. A cancelled read changes the state to `loadingCancelled` without updating the list. Other read errors produce `failure(.persistentStoreLoad)`, unless the task has also been cancelled.

Both cancellation and read failure show a retry button. Reading is allowed only from `initial`, `loadingCancelled`, or `failure(.persistentStoreLoad)` . An in-progress read cannot start another one. The view's task can also retry when it runs again while one of these retry states is active.

The search bar is enabled after cancellation or failure. Starting a search replaces the retry state with the search state. Because the same enum represents both flows, the retry button is no longer available after that transition. The initial read is not automatically retried from search states.
