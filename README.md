# Online strore (Ruby on Rails + React)

This project is an online store that utilizes Ruby on Rails to create an API and React for the frontend. 

It allows users to register, login, and logout, edit their own information, search for products, view, add to cart, 
create and review their orders.

Additionally, it features an administrator role, granting privileges to add, edit, and delete products, 
view all users, edit their information, and delete them as well.

Front-end repository: https://github.com/Kozatskiy-Artem/rails-react-store-front

## Available Routes

- GET    /api/v1/users/me             - Retrieve the details of the currently logged-in user. 
- POST   /api/v1/users/tokens/revoke  - Revoke the token of the logged-in user (log-out). 
- POST   /api/v1/users/tokens/refresh - Refresh the token of the logged-in user. 
- POST   /api/v1/users/tokens/sign_up - Sign up a new user with authentication token. 
- POST   /api/v1/users/tokens/sign_in - Sign in an existing user with authentication token. 
- GET    /api/v1/users/tokens/info    - Retrieve information about the authentication token. 
- GET    /api/v1/items                - Retrieve all items. 
- POST   /api/v1/items                - Create a new item. 
- GET    /api/v1/items/:id            - Retrieve a specific item by ID. 
- PATCH  /api/v1/items/:id            - Partially update a specific item by ID. 
- PUT    /api/v1/items/:id            - Update a specific item by ID. 
- DELETE /api/v1/items/:id            - Delete a specific item by ID. 
- GET    /api/v1/users                - Retrieve all users. 
- POST   /api/v1/users                - Create a new user. 
- GET    /api/v1/users/:id            - Retrieve a specific user by ID. 
- PATCH  /api/v1/users/:id            - Partially update a specific user by ID. 
- PUT    /api/v1/users/:id            - Update a specific user by ID. 
- DELETE /api/v1/users/:id            - Delete a specific user by ID. 
- GET    /api/v1/orders               - Retrieve all orders. 
- POST   /api/v1/orders               - Create a new order. 
- GET    /api/v1/orders/:id           - Retrieve a specific order by ID.

## Installation and Setup

### Clone the repository:
```
git clone https://github.com/Kozatskiy-Artem/rails-react-store-api.git
```
OR
```
git clone git@github.com:Kozatskiy-Artem/rails-react-store-api.git
```

### Install dependencies:
Ensure you have Ruby installed. Then run:
```
cd store_api
bundle
```

### Configure the database:
Specify the database connection parameters in the `config/database.yml` file.

### Database migrations:
Run migrations to create the necessary tables in the database:
```
rails db:migrate
```

### Running the Server
To start the Ruby on Rails server use the following command:
```
rails server OR rails s
```

Open your web browser and navigate to http://localhost:3000/

### Creating an Administrator

Open Rails console:
```
rails console OR rails c
```
Create an administrator record:
```
User.create!(email: "admin@example.com", password: "password", role: "admin")

exit
```

## Start with Docker

### Run
Make sure you have Docker and Docker Compose installed on your system.

Build and run the Docker containers:
```
docker-compose up -d --build
```

Open your web browser and navigate to http://localhost:3000/.

### Shutdown
```
docker-compose down
```
or
```
docker-compose down -v
```
if you want delete containers with docker volume

### © Project Author: Artem Kozatskyi
