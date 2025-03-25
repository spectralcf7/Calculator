//
//  Digit.swift
//  Calculator-iOS
//
//  Created by Mihnea Amihailesei on 02.04.2024.
//

import Foundation

enum Digit: Int, CaseIterable, CustomStringConvertible {
    case zero, one, two, three, four, five, six, seven, eight, nine
    
    var description: String {
        "\(rawValue)"
    }
}
