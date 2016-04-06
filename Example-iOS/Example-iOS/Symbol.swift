//
//  Symbol.swift
//  LSystem
//
//  Created by Hanssen, Alfie on 4/6/16.
//  Copyright © 2016 Alfie Hanssen. All rights reserved.
//

import Foundation

class Symbol: CustomStringConvertible
{
    var description: String
    {
        assertionFailure("Subclasses must implement description.")
        
        return ""
    }
}

