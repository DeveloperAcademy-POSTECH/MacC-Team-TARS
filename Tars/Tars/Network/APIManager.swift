//
//  APIManager.swift
//  Tars
//
//  Created by 이윤영 on 2022/10/24.
//

import Foundation

class AstronomyAPIManager: NetworkService {
    func requestBodies() async throws -> [Body] {
        let parameters = try getBodiesPositionsParameters()
        let url = AstronomyURL.bodiesPosition
        let endpoint = url.getEndpoint(with: parameters)
        guard let request = endpoint.getURLRequest() else { throw  NetworkError.invalidURL}
        let data: BodiesPositionsResponse = try await getRequest(request)
        
        return data.bodiesData
    }
}

extension AstronomyAPIManager {
    func getBodiesPositionsParameters() throws -> [String: String] {
        // Get current Date
        var parameters: [String: String] = [:]
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentDate = formatter.string(from: Date()).split(separator: " ")
        let (currentDay, currentTime) = (currentDate[0], currentDate[1])
        parameters["from_date"] = String(currentDay)
        parameters["to_date"] =  String(currentDay)
        parameters["time"] =  String(currentTime)
        
        // Get current Location
        let locationManager = LocationManager()
        guard let (latitude, longtitude, elevation) = locationManager.getCurrentLocation() else { throw LocationError.currentLocationFailure}
        parameters["latitude"] = String(latitude)
        parameters["longitude"] = String(longtitude)
        parameters["elevation"] = String(elevation)
        
        return parameters
    }
}
