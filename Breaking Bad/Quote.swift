//
//  Quote.swift
//  Breaking Bad
//
//  Created by Anthony Lartey on 22/03/2024.
//

import Foundation

struct Quote: Decodable {
    let quote: String
    let character: String
    let production: String
}
