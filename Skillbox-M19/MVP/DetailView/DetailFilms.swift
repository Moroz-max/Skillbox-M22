//
//  DetailFilms.swift
//  Skillbox-M19
//
//  Created by Максим Морозов on 06.01.2024.
//

import Foundation

struct DetailFilms: Codable {
    let nameRu: String
    let nameOriginal: String
    let posterUrl: String
    let ratingKinopoisk: Double
    let ratingImdb: Double
    let year: Int
    let filmLength: Int
    let description: String
}
