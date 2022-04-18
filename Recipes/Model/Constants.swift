//
//  Constants.swift
//  SlowmoGraham
//
//  Created by Noah Bissell (student LM) on 2/2/22.
//

import SwiftUI

extension Color {
    static let background = Color("backgroundColor")
    static let buttonBackground = Color("buttonBackground")
    static let buttonText = Color("buttonText")
}

extension Encodable {
    var toDictionary: [String : Any]? {
        guard let data =  try? JSONEncoder().encode(self) else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
}
