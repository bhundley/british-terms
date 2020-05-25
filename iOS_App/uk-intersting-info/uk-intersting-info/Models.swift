//
//  Models.swift
//  uk-intersting-info
//
//  Created by Tommy Hundley on 5/25/20.
//  Copyright © 2020 Tommy. All rights reserved.
//

import Foundation

struct FactsData: Codable {
    var slang: [SlangData]?
    var topArtists: [ArtistData]?
    var food: [FoodData]?
}

struct SlangData: Codable {
    var us: String?
    var uk: String?
}

struct FoodData: Codable {
    var name: String?
    var image: String?
    var desc: String?
}

struct ArtistData: Codable {
    var artist: String?
    var genre: String?
    var image: String?
}
