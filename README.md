# Foods API

HTTP Rest JSON API to manage foods. Build with Ruby + Ruby on Rails + Postgres + Redis + ElasticSearch + Docker

## Requirements

Docker Engine and Docker-Compose

## Installation

Deploy the application:

```bash
docker-compose build
docker-compose up -d
```
Stop all the service containers:

```bash
docker-compose stop
```

Remove all stopped service containers:


```bash
docker-compose rm
```

## Usage

Access the service in your localhost, port: 3000. You can use any HTTP client to make the following requests:

1. Fetch a single food from the system, given the food ID:

```python
GET http://localhost:3000/foods/ID
```

2. List all the foods in the system

```python
GET http://localhost:3000/foods
```

3. Search for foods in the system given a query string. This allows you to filter foods by name and category.

```python
GET http://localhost:3000/foods/search?name="some_name"&category=category_id
```

4. Create a food in the system. For a successful request, all the fields must match the following example:

```python
POST http://localhost:3000/foods

Example body (JSON):

{
    "name": "some_name",
    "edible_portion": 100,
    "code": "some_code",
    "energy_value": 390,
    "category_id": 1,
    "composition": [
        {
            "component_id": 1,
            "quantity": 4
        },
        ...
    ]
}
```

5. Update a food in the system given the food ID. Each field can be updated individually.

```python
PUT http://localhost:3000/foods/ID

Example body 1:

{
    "name": "some_name",

}

Example body 2:

{
    "name": "some_name",
    "edible_portion": 100,
    "code": "some_code",
    "energy_value": 390,
    "category_id": 1,
    "composition": [
        {
            "component_id": 1,
            "quantity": 4
        }
    ]
}

```

6. Delete a food from the system given the food ID

```python
DELETE http://localhost:3000/foods/ID
```
