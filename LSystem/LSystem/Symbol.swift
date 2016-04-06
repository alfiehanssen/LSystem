//
//  Symbol.swift
//  LSystem
//
//  Created by Hanssen, Alfie on 4/6/16.
//  Copyright © 2016 Alfie Hanssen. All rights reserved.
//

import Foundation

public class Symbol: CustomStringConvertible
{
    public init()
    {
        
    }
    
    public var description: String
    {
        return String(self.dynamicType)
    }
}

