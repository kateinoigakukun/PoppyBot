# PoppyBot

<a href="https://developer.apple.com/swift/" target="_blank">
  <img src="https://img.shields.io/badge/Swift-4.0-orange.svg?style=flat" alt="Swift 4.0">
</a>
<a href="https://developer.apple.com/swift/" target="_blank">
  <img src="https://img.shields.io/badge/Platforms-OS%20X%20%7C%20Linux%20-lightgray.svg?style=flat" alt="Platforms OS X | Linux">
</a>

A chat bot for Slack

<img src=https://images-na.ssl-images-amazon.com/images/I/71TlWzu4UvL._SY679_.jpg width=200px>


## Getting Started

```
docker-compose build
docker-compose up
```

## Environment

|name|description|
|:--|:--|
|`POPPY_ENV`| `development` or `production`. default is `development`|
|`SLACK_TOKEN`| Slack token|


## Model Definition

This project uses `Codable` protocol to define a type safe model struct.

`Codable` make sure that all property keys are declared in `CodingKeys`

If `CodingKeys`'s elements are not enough, compile error occures.
(ex. `RSSItem does not conform to protocol 'Decodable'`)


```swift
struct RSSItem: Model {

    enum CodingKeys: CodingKey {
        case title
        case url
    }

    let title: String
    let url: URL
    
    ....
}

```
