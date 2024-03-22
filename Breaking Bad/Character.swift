//
//  Character.swift
//  Breaking Bad
//
//  Created by Anthony Lartey on 22/03/2024.
//

import Foundation

struct Character: Decodable {
    let name: String
    let birthday: String
    let occupations: [String]
    let images: [URL]
    let aliases: [String]
    let portrayedBy: String
    let status: String
}
