//
//  Model.swift
//  Skillbox-M19
//
//  Created by Максим Морозов on 23.12.2023.
//

import Foundation

struct Films: Codable {
    let filmId: Int
    let nameRu: String
    let posterUrl: String
}

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
