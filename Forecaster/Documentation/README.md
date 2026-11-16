
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
