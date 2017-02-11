//
//  Dictionary.extension.swift
//  monokit
//
//  Created by mono on 2017/02/11.
//  Copyright © 2017 mono. All rights reserved.
//

import Foundation

extension Dictionary {

    public mutating func merge(_ dictionary: Dictionary) {
        dictionary.forEach { updateValue($1, forKey: $0) }
    }

    public func merged(_ dictionary: Dictionary) -> Dictionary {
        var dict = self
        dict.merge(dictionary)
        return dict
    }
}
