# I18n Compare

Compare translations from Google, Bing and Yandex.

* Ruby version: > 2

## Endpoints

There is currently just one endpoint that accepts either GET or POST.

For example translate `Hello everyone` from English to Spanish.

```
GET /translate?text=Hello%20everyone&from=en&to=es`
```

__Example response__

```json
{
  "google": {
    "text": "Hola a todos",
    "confidence": 1.0,
    "tokens": [
      "Hola a todos"
    ]
  },
  "bing": {
    "text": "Hola a todos",
    "confidence": 1.0,
    "tokens": [
      "Hola a todos"
    ]
  },
  "yandex": {
    "text": "Hola a todos",
    "confidence": 0.5,
    "tokens": [
      "Hola",
      "todo el mundo"
    ]
  }
}
```
