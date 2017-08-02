//: Playground - noun: a place where people can play

import Cocoa
import URLQueryBuilder

let dictionary: [String: Any] = [
    "array1": [
        [
            "key": "value1",
            ],
        [
            "key": "value2",
            ],
        [
            "key": "value3",
            ],
        [
            "subdict": [
                "subkey": "subValue",
                "multibyte": "マルチバイト",
                "chars": "!@#$%^&*()_+"
            ]
        ]
    ],
    "array2": [
        "0",
        "1",
        "2",
    ],
    "dict": [
        "dictkey": "dictvalue"
    ],
    "string": "value",
    "number": 100.0,
    "integer": 1000
]

// array1[0][key]=value1&array1[1][key]=value2&array1[2][key]=value3&array1[3][subdict][chars]=%21%40%23%24%25%5E%26%2A%28%29_%2B&array1[3][subdict][multibyte]=%E3%83%9E%E3%83%AB%E3%83%81%E3%83%90%E3%82%A4%E3%83%88&array1[3][subdict][subkey]=subValue&array2[0]=0&array2[1]=1&array2[2]=2&dict[dictkey]=dictvalue&integer=1000&number=100.0&string=value
debugPrint(URLQueryBuilder(dictionary: dictionary).build(with: [.urlEncoding]))
