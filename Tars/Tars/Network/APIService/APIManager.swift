//
//  APIManager.swift
//  Tars
//
//  Created by 이윤영 on 2022/10/24.
//

import Foundation

// MARK: - Astronomy API
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
        let locationManager = LocationManager.shared
        guard let (latitude, longtitude, elevation) = locationManager.getCurrentLocation() else { throw LocationError.currentLocationFailure}
        parameters["latitude"] = String(latitude)
        parameters["longitude"] = String(longtitude)
        parameters["elevation"] = String(elevation)
        
        return parameters
    }
}

// MARK: - Horizons API
class HorizonsAPIManager: NetworkService {
    func requestBodies() async throws -> [Body] {
        var bodiesData: [Body] = []
        let siteCoord = try getSiteCoordParameter()
        let (startTime, stopTime) = try getTimeParameter()
        let majorBodies: [MajorBody] = MajorBody.allCases
        for body in majorBodies {
            let parameters = try getBodiesPositionsParameters(command: body.command, siteCoord: siteCoord, startTime: startTime, stopTime: stopTime)
            let url = HorizonURL.horizonAPI
            let endpoint = url.getEndpoint(with: parameters)
            guard let request = endpoint.getURLRequest() else { throw  NetworkError.invalidURL}
            let data: HorizonResponse = try await getRequest(request)
            let (azimuth, altitude) = data.result.extractCoord()
            bodiesData.append(Body(id: body.id, name: body.name, altitude: altitude, azimuth: azimuth))
            print(body.id, body.name, body.command, azimuth, altitude)
        }

        return bodiesData
    }
}
extension HorizonsAPIManager {
    func getSiteCoordParameter() throws -> String {
        let locationManager = LocationManager.shared
        guard let (latitude, longtitude, elevation) = locationManager.getCurrentLocation() else { throw LocationError.currentLocationFailure}
        let eLon = String(format: "%.5f", longtitude)
        let lat = String(format: "%.5f", latitude)
        let alt = String(format: "%.3f", elevation/1000)
        let site_coord = String("'\(eLon),\(lat),\(alt)'")
        
        return site_coord
    }
    
    func getTimeParameter() throws -> (startTime: String, stopTime: String) {
        // Get time now and 1 minute later
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nowTime = Date()
        let afterTime = Date(timeInterval: 60, since: nowTime)
        let startTime = formatter.string(from: nowTime)
        let stopTime = formatter.string(from: afterTime)
        
        return (String("'\(startTime)'"), String("'\(stopTime)'"))
    }
    
    func getBodiesPositionsParameters(command: String, siteCoord: String, startTime: String, stopTime: String) throws -> [String: String] {
        var parameters: [String: String] = [:]
        
        parameters["format"] = String("json")
        parameters["COMMAND"] = String(command)
        parameters["APPARENT"] = String("REFRACTED")
        parameters["CENTER"] = String("coord")
        parameters["SITE_COORD"] = String(siteCoord)
        parameters["START_TIME"] = String(startTime)
        parameters["STOP_TIME"] = String(stopTime)
        parameters["STEP_SIZE"] = String("1d")
        parameters["QUANTITIES"] = String("4")

        return parameters
    }
}
