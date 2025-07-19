//
//  HomeScreen.swift
//  Weather Forecast App
//
//  Created by Ishwari Hingne on 12/07/25.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var city: String = "Pune"
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("SkyBlue"), Color.blue]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                // Search Bar
                HStack {
                    TextField("Enter city", text: $city)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    Button(action: {
                        viewModel.fetchWeather(for: city)
                    }) {
                        Image(systemName: "magnifyingglass")
                            .padding(10)
                            .background(Color.white.opacity(0.3))
                            .clipShape(Circle())
                            .foregroundColor(.white)
                    }
                    .padding(.trailing)
                }

                if let weather = viewModel.weather {
                    VStack(spacing: 20) {
                        Text("📍 \(weather.name)")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)

                        VStack(spacing: 8) {
                            Text("\(Int(weather.main.temp))°")
                                .font(.system(size: 80))
                                .bold()
                                .foregroundColor(.white)

                            Text(weather.weather.first?.description.capitalized ?? "")
                                .font(.title3)
                                .foregroundColor(.white)
                        }

                        HStack(spacing: 20) {
                            WeatherInfoItem(icon: "drop.fill", title: "Humidity", value: "\(weather.main.humidity)%")
                            WeatherInfoItem(icon: "wind", title: "Wind", value: "\(Int(weather.wind.speed)) km/h")
                            WeatherInfoItem(icon: "sun.max.fill", title: "Feels", value: "\(Int(weather.main.temp))°")
                        }
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(16)
                        .foregroundColor(.white)

                        Spacer()
                    }
                    .padding(.top, 20)
                } else if viewModel.isLoading {
                    ProgressView("Loading weather...")
                        .foregroundColor(.white)
                } else {
                    Text("No data. Try again later.")
                        .foregroundColor(.white)
                }
            }
            .padding(.top, 60)
        }
        .onAppear {
            viewModel.fetchWeather(for: city)
        }
    }
}

// MARK: - Weather Info Item
struct WeatherInfoItem: View {
    let icon: String
    let title: String
    let value: String

    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title2)
            Text(title)
                .font(.caption)
            Text(value)
                .font(.headline)
                .bold()
        }
        .frame(width: 80)
    }
}

// MARK: - Hourly Card
struct HourCard: View {
    let hour: HourlyForecast

    var body: some View {
        VStack(spacing: 8) {
            Text(hour.time)
                .font(.caption)
            Image(systemName: hour.icon)
                .font(.title2)
            Text("\(hour.temperature)°")
                .bold()
        }
        .frame(width: 60, height: 100)
        .background(Color.white.opacity(0.3))
        .cornerRadius(12)
        .foregroundColor(.white)
    }
}

// MARK: - Preview
#Preview {
    HomeScreen()
}

// MARK: - Sample Hourly Data
struct HourlyForecast: Identifiable {
    let id = UUID()
    let time: String
    let icon: String
    let temperature: Int
}

let sampleHourlyData: [HourlyForecast] = [
    .init(time: "9 AM", icon: "sun.max.fill", temperature: 21),
    .init(time: "10 AM", icon: "sun.max.fill", temperature: 23),
    .init(time: "11 AM", icon: "cloud.sun.fill", temperature: 24),
    .init(time: "12 PM", icon: "cloud.fill", temperature: 25),
    .init(time: "1 PM", icon: "cloud.rain.fill", temperature: 22),
    .init(time: "2 PM", icon: "cloud.sun.rain.fill", temperature: 23)
]

