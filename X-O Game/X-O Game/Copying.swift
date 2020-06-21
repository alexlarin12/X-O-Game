//
//  Copying.swift
//  X-O Game
//
//  Created by Alex Larin on 21.06.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
protocol Copying {
    
    init(_ prototype: Self)

}

extension Copying {

    func copy() -> Self {
        return type(of: self).init(self)
    }
}
