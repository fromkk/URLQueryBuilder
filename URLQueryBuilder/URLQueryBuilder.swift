//
//  URLQueryBuilder.swift
//  URLQueryBuilderSample
//
//  Created by Kazuya Ueoka on 2017/08/02.
//  Copyright © 2017 fromKK. All rights reserved.
//

import Foundation

private protocol URLQueryRespresentable {}

extension Int: URLQueryRespresentable {}

extension Float: URLQueryRespresentable {}

extension Double: URLQueryRespresentable {}

extension String: URLQueryRespresentable {}

public class URLQueryBuilder {
    
    public enum Options {
        case urlEncoding
    }
    
    private (set) public var dictionary: [String: Any]
    public init(dictionary: [String: Any]) {
        self.dictionary = dictionary
    }
    
    private var options: [Options] = []
    public func build(with options: [Options] = []) -> String {
        self.options = options
        return self.queryString(with: self.dictionary)
    }
    
    private func queryString(with dictionary: [String: Any], parentKey: String? = nil) -> String {
        return dictionary.flatMap({ (key: String, value: Any) -> String? in
            
            let currentKey: String
            if let parentKey: String = parentKey {
                currentKey = "\(parentKey)[\(key)]"
            } else {
                currentKey = key
            }
            
            if let queryRepresentable: URLQueryRespresentable = value as? URLQueryRespresentable {
                return "\(currentKey)=\(self.queryString(with: queryRepresentable))"
            } else if let array: [URLQueryRespresentable] = value as? [URLQueryRespresentable] {
                return self.queryString(with: array, key: currentKey)
            } else if let array: [[String: Any]] = value as? [[String: Any]] {
                return self.queryString(with: array, key: currentKey)
            } else if let dictionary: [String: Any] = value as? [String: Any] {
                return self.queryString(with: dictionary, parentKey: currentKey)
            } else {
                return nil
            }
        }).sorted().joined(separator: "&")
    }
    
    private func queryString(with value: URLQueryRespresentable) -> String {
        if let int: Int = value as? Int {
            return String(int)
        } else if let float: Float = value as? Float {
            return String(float)
        } else if let double: Double = value as? Double {
            return String(double)
        } else if let string: String = value as? String {
            if self.options.contains(.urlEncoding) {
                // for RFC3986
                var characterSet: CharacterSet = CharacterSet.alphanumerics
                characterSet.insert(charactersIn: "-._~")
                return string.addingPercentEncoding(withAllowedCharacters: characterSet) ?? ""
            } else {
                return string
            }
        } else {
            return ""
        }
    }
    
    private func queryString(with array: [URLQueryRespresentable], key: String) -> String {
        return array.enumerated().map( { (offset: Int, element: URLQueryRespresentable) -> String in
            return "\(key)[\(offset)]=\(self.queryString(with: element))"
        }).joined(separator: "&")
    }
    
    private func queryString(with array: [[String: Any]], key: String) -> String {
        return array.enumerated().flatMap({ (offset: Int, element: [String: Any]) -> String? in
            
            let parentKey: String = "\(key)[\(offset)]"
            return self.queryString(with: element, parentKey: parentKey)
            
        }).joined(separator: "&")
    }
}

