//
//  DictionaryEx.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 19/05/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
            }
            .joined(separator: "&")
    }
}
