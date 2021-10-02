//
//  TVShow.swift
//  TVShows
//
//  Created by Jorge Flores Carlos on 30/09/21.
//

import Foundation

    // MARK: - TvShow
struct TVShow: Codable {
    let id: Int
    var isFavorite: Bool?
    let name: String

    let externals: Externals
    let image: Image
    let summary: String

    mutating func updateFavoriteStatus(_ status: Bool) {
        self.isFavorite = status
    }
}
    // MARK: - Externals
struct Externals: Codable {
    let tvrage: Int
    let thetvdb: Int?
    let imdb: String?
}

    // MARK: - Image
struct Image: Codable {
    let medium, original: String
}

enum Language: String, Codable {
    case english = "English"
    case japanese = "Japanese"
}

    // MARK: - Links
struct Links: Codable {
    let linksSelf: Nextepisode
    let previousepisode, nextepisode: Nextepisode?
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case previousepisode, nextepisode
    }
}

    // MARK: - Nextepisode
struct Nextepisode: Codable {
    let href: String
}

    // MARK: - Network
struct Network: Codable {
    let id: Int
    let name: String
    let country: Country?
}

    // MARK: - Country
struct Country: Codable {
    let name: Name
    let code: Code
    let timezone: Timezone
}

enum Code: String, Codable {
    case ca = "CA"
    case fr = "FR"
    case gb = "GB"
    case jp = "JP"
    case us = "US"
}

enum Name: String, Codable {
    case canada = "Canada"
    case france = "France"
    case japan = "Japan"
    case unitedKingdom = "United Kingdom"
    case unitedStates = "United States"
}

enum Timezone: String, Codable {
    case americaHalifax = "America/Halifax"
    case americaNewYork = "America/New_York"
    case asiaTokyo = "Asia/Tokyo"
    case europeLondon = "Europe/London"
    case europeParis = "Europe/Paris"
}

    // MARK: - Rating
struct Rating: Codable {
    let average: Double?
}

    // MARK: - Schedule
struct Schedule: Codable {
    let time: String
    let days: [Day]
}

enum Day: String, Codable {
    case friday = "Friday"
    case monday = "Monday"
    case saturday = "Saturday"
    case sunday = "Sunday"
    case thursday = "Thursday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
}

enum Status: String, Codable {
    case ended = "Ended"
    case running = "Running"
    case toBeDetermined = "To Be Determined"
}

enum TypeEnum: String, Codable {
    case animation = "Animation"
    case documentary = "Documentary"
    case news = "News"
    case panelShow = "Panel Show"
    case reality = "Reality"
    case scripted = "Scripted"
    case sports = "Sports"
    case talkShow = "Talk Show"
    case variety = "Variety"
}

