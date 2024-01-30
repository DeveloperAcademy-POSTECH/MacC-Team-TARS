//
//  BodiesPositionsResponse.swift
//  Tars
//
//  Created by 이윤영 on 2022/10/24.
//

import Foundation

// Mark: - Astronomy API
struct BodiesPositionsResponse: Decodable {
    var bodiesData: [Body]
    
    enum CodingKeys: String, CodingKey {
        case data, table, rows
    }
}

extension BodiesPositionsResponse {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        let table = try data.nestedContainer(keyedBy: CodingKeys.self, forKey: .table)
        bodiesData = try table.decode([Body].self, forKey: .rows)
    }
}

// Mark: - Horizons API
struct HorizonResponse: Decodable {
    var signature: Signature
    var result: String
}

struct Signature: Decodable {
    var source: String
    var version: String
}
