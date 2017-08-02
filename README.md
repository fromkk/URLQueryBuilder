# URLQueryBuilder with Swift

`URLQueryBuilder` is able to build query string for URL from Dictionary type.

---

## Requirements

- Swift 3.0 or later

---

## Installation

### Carthage

- Insert `github "fromkk/URLQueryBuilder"` to your `Cartfile` .
- Run `carthage update`
- Link your app with `URLQueryBuilder.framework` in `Carthage/Build`

---

## Usage

Query string from simple dictionary.

```swift
import URLQueryBuilder

let someDictionary: [String: Any] = ["key1": "hello", "key2": "world"]
let queryBuilder: URLQueryBuilder = URLQueryBuilder(dictionary: someDictionary)
let queryString: String = queryBuilder.build() //key1=hello&key2=world
```

Query string from multibyte characters.

```swift

let someDictionary: [String: Any] = ["key": "マルチバイト👨‍👩‍👧‍👦"]
let queryString: String = URLQueryBuilder(dictionary: someDictionary).build(with: [.urlEncoding]) //key=%E3%83%9E%E3%83%AB%E3%83%81%E3%83%90%E3%82%A4%E3%83%88%F0%9F%91%A8%E2%80%8D%F0%9F%91%A9%E2%80%8D%F0%9F%91%A7%E2%80%8D%F0%9F%91%A6
```

Query string from deep hierarchy dictionary.

```swift
let deepDictionary: [String: Any] = ["key": ["subkey": "subvalue"]]
let queryString: String = URLQueryBuilder(dictionary: deepDictionary).build() //key[subkey]=subvalue

```

Query string from array.

```swift

let arrayDictionary: [String: Any] = ["array": ["hello", "world"]]
let queryString: String = URLQueryBuilder(dictionary: arrayDictionary).build() //array[0]=hello&array[1]=world
```
