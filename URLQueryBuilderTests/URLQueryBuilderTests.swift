//
//  URLQueryBuilderTests.swift
//  URLQueryBuilderTests
//
//  Created by Kazuya Ueoka on 2017/08/02.
//  Copyright © 2017 fromKK. All rights reserved.
//

import XCTest
@testable import URLQueryBuilder

class URLQueryBuilderTests: XCTestCase {
    
    func testBuild() {
        
        do {
            // simple dictionary 1
            let dictionary: [String: Any] = ["key": 999]
            XCTAssertEqual("key=999", URLQueryBuilder(dictionary: dictionary).build())
        }
        
        do {
            // simple dictionary 2
            let dictionary: [String: Any] = ["key": 999.99]
            XCTAssertEqual("key=999.99", URLQueryBuilder(dictionary: dictionary).build())
        }
        
        do {
            // simple dictionary 3
            let dictionary: [String: Any] = ["key": "value"]
            XCTAssertEqual("key=value", URLQueryBuilder(dictionary: dictionary).build())
        }
        
        do {
            // simple dictionary 4
            let dictionary: [String: Any] = ["key": "マルチバイト"]
            XCTAssertEqual("key=マルチバイト", URLQueryBuilder(dictionary: dictionary).build())
        }
        
        do {
            // simple dictionary 5
            let dictionary: [String: Any] = ["key": "マルチバイト"]
            XCTAssertEqual("key=%E3%83%9E%E3%83%AB%E3%83%81%E3%83%90%E3%82%A4%E3%83%88", URLQueryBuilder(dictionary: dictionary).build(with: [.urlEncoding]))
        }
        
        do {
            // simple dictionary 6
            let dictionary: [String: Any] = [
                "key1": 100,
                "key2": 999.99,
                "key3": "絵文字👨‍👩‍👧‍👦"
            ]
            XCTAssertEqual("key1=100&key2=999.99&key3=%E7%B5%B5%E6%96%87%E5%AD%97%F0%9F%91%A8%E2%80%8D%F0%9F%91%A9%E2%80%8D%F0%9F%91%A7%E2%80%8D%F0%9F%91%A6", URLQueryBuilder(dictionary: dictionary).build(with: [.urlEncoding]))
        }
        
        do {
            // array
            let dictionary: [String: Any] = [
                "key": [
                    "hello",
                    "world"
                ]
            ]
            XCTAssertEqual("key[0]=hello&key[1]=world", URLQueryBuilder(dictionary: dictionary).build())
        }
        
        do {
            // dictionary
            let dictionary: [String: Any] = [
                "key": [
                    "subkey1": "hello",
                    "subkey2": "world"
                ]
            ]
            XCTAssertEqual("key[subkey1]=hello&key[subkey2]=world", URLQueryBuilder(dictionary: dictionary).build())
        }
        
        do {
            // complex
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
            
            XCTAssertEqual("array1[0][key]=value1&array1[1][key]=value2&array1[2][key]=value3&array1[3][subdict][chars]=%21%40%23%24%25%5E%26%2A%28%29_%2B&array1[3][subdict][multibyte]=%E3%83%9E%E3%83%AB%E3%83%81%E3%83%90%E3%82%A4%E3%83%88&array1[3][subdict][subkey]=subValue&array2[0]=0&array2[1]=1&array2[2]=2&dict[dictkey]=dictvalue&integer=1000&number=100.0&string=value", URLQueryBuilder(dictionary: dictionary).build(with: [.urlEncoding]))
        }
    }
    
}
