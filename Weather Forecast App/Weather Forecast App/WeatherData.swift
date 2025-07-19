//
//  WeatherData.swift
//  Weather Forecast App
//
//  Created by Ishwari Hingne on 12/07/25.
//

import Foundation

// MARK: - WeatherData.swift
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind

    struct Main: Codable {
        let temp: Double
        let humidity: Int
    }

    struct Weather: Codable {
        let main: String
        let description: String
        let icon: String
    }

    struct Wind: Codable {
        let speed: Double
    }
}

// MARK: - WeatherViewModel.swift
import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherData?
    @Published var isLoading = false

    let apiKey = "82c2a6fc71be708cac22935117251652" // Replace with your actual OpenWeatherMap API key

    func fetchWeather(for city: String) {
        isLoading = true
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            guard let data = data, error == nil else {
                print("Network error:", error?.localizedDescription ?? "Unknown error")
                return
            }

            // Print the raw JSON response
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON response:\n\(jsonString)")
            }

            do {
                let decoded = try JSONDecoder().decode(WeatherData.self, from: data)
                DispatchQueue.main.async {
                    self.weather = decoded
                }
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
    }

}




