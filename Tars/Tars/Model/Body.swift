//
//  Body.swift
//  Tars
//
//  Created by 이윤영 on 2022/10/24.
//

import Foundation

struct Body: Decodable {
    var id: String
    var name: String
    var distanceFromEarth: String
    var altitude: String
    var azimuth: String

    enum CodingKeys: String, CodingKey {
        case cells, id, name, distance, position
        case fromEarth, km
        case horizonal, altitude, azimuth, degrees
    }
}

extension Body {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var array = try container.nestedUnkeyedContainer(forKey: .cells)
        let cell =  try array.nestedContainer(keyedBy: CodingKeys.self)
        let distance = try  cell.nestedContainer(keyedBy: CodingKeys.self, forKey: .distance)
        let fromEarth = try distance.nestedContainer(keyedBy: CodingKeys.self, forKey: .fromEarth)
        let position = try cell.nestedContainer(keyedBy: CodingKeys.self, forKey: .position)
        let horizonal = try position.nestedContainer(keyedBy: CodingKeys.self, forKey: .horizonal)
        let altitude = try horizonal.nestedContainer(keyedBy: CodingKeys.self, forKey: .altitude)
        let azimuth = try horizonal.nestedContainer(keyedBy: CodingKeys.self, forKey: .azimuth)

        self.id = try cell.decode(String.self, forKey: .id)
        self.name = try cell.decode(String.self, forKey: .name)
        self.distanceFromEarth = try fromEarth.decode(String.self, forKey: .km)
        self.altitude = try altitude.decode(String.self, forKey: .degrees)
        self.azimuth = try azimuth.decode(String.self, forKey: .degrees)
    }
}
