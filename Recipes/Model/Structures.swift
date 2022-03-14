//  Mode.swift
//  Created by Noah Bissell on 1/11/22.
// Deprecated as of 1/24/22

import Foundation

enum Diet : CaseIterable {
    case none
    case vegan
    case vegetarian
    case glutenFree
    case ketogenic
    case paleo
    case pescetarian
};

extension Diet : Identifiable {
    var id : Self{self}
}
