# city-coordinates-api

## Endpoints

### Search by City Name

- **Endpoint:** `/search`
- **Method:** `GET`
- **Query Parameters:** `name` (required)
- **Example:**

    ```sh
    curl "http://localhost:8000/search?name=nashville"
    ```

### Search by Coordinates

- **Endpoint:** `/coordinates`
- **Method:** `GET`
- **Query Parameters:** `latitude` (required), `longitude` (required)
- **Example:**

    ```sh
    curl "http://localhost:8000/coordinates?latitude=35.5175&longitude=-86.6904"
    ```
