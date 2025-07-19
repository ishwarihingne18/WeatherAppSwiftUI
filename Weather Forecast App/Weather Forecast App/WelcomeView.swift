//
//  WelcomeView.swift
//  Weather Forecast App
//
//  Created by Ishwari Hingne on 12/07/25.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("SkyBlue"), Color.blue]),
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 30) {
                Image(systemName: "cloud.sun.rain.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.white)
                    .shadow(radius: 10)

                Text("Weather Forecasts")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                NavigationLink(destination: HomeScreen()) {
                    Text("Get Start")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 180)
                        .background(Color.yellow)
                        .cornerRadius(25)
                        .shadow(radius: 5)
                }
            }
        }
    }
}

