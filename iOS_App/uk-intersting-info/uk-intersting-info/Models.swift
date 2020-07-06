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

class Lodging: CityEvent {
    
}

class Food: CityEvent {
    
}

class Activity: CityEvent {
    
}

class Attraction: CityEvent {
    
}

class CityEvent: Codable {
    var name: String?
    var website: String?
    var address: String?
    var type: String?
    var image: String?
    var description: String?
    var price: String?
}

struct City: Codable {
    var name: String?
    var image: String?
    var lodging: [Lodging]?
    var food: [Food]?
    var activities: [Activity]?
    var attractions: [Attraction]?
}

struct CityData: Codable {
    var cities: [City]?
}
