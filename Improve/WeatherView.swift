//
//  WeatherView.swift
//  Improve
//
//  Created by Apoorva Kanekal on 9/28/23.
//

import SwiftUI

struct WeatherData: Codable{
    var current_weather: WeatherNow
}

struct WeatherNow: Codable{
    var temperature: Double
}


struct WeatherView: View {
    
    @State var tempNow: WeatherNow?
    @State private var showingSheet = false
    
    func getTemp() async -> () {
        do{
            let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=40.015&longitude=-105.2706&hourly=temperature_2m,precipitation_probability,uv_index&daily=sunrise,sunset&current_weather=true&temperature_unit=fahrenheit&windspeed_unit=mph&precipitation_unit=inch&timezone=America%2FDenver&forecast_days=1")!
            let (data, _) = try await URLSession.shared.data(from: url)
            print(data)
            let weatherData = try JSONDecoder().decode(WeatherData.self, from:data)
            tempNow = weatherData.current_weather
        } catch{
            print("Error: \(error.localizedDescription)")
        }
        
    }
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack(content:{
                    Circle()
                        .foregroundColor(Color.yellow)
                        .scaleEffect(0.75)
                    
                    Text("\(tempNow?.temperature ?? 0.0)"+"º")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                })
                
                Button("See Hourly Temperatures"){
                    showingSheet = true
                }
                .foregroundColor(.black)
                .sheet(isPresented:$showingSheet){
                    SpecificsView()
                }
            }
            .task {
                await getTemp()
            }

            .padding()
            .navigationBarTitle("Now in Boulder, CO")
        }
    }
}

struct HourData: Codable{
    var hourly: TimeInHours
}
                    

struct TimeInHours: Codable{
    var time: [String]
    var temperature_2m: [Double]
}
    
    struct SpecificsView: View {
        @Environment(\.dismiss) var dismiss
//        @State var hours = HourData?
//
//        func getHours() async -> () {
//            do{
//                let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=40.015&longitude=-105.2706&hourly=temperature_2m,precipitation_probability,uv_index&daily=sunrise,sunset&current_weather=true&temperature_unit=fahrenheit&windspeed_unit=mph&precipitation_unit=inch&timezone=America%2FDenver&forecast_days=1")!
//                let (data, _) = try await URLSession.shared.data(from: url)
//                print(data)
//                hours = try JSONDecoder().decode(HourData.self, from:data)
//            } catch{
//                print("Error: \(error.localizedDescription)")
//            }
//
//        }

        var body: some View {
            Button("Press to Dismiss"){
                dismiss()
            }
            .foregroundColor(.black)
            Text("hi")
            
//            .task {
//            await getHours()
        }
            
        }
    
    struct WeatherView_Previews: PreviewProvider {
        static var previews: some View {
            WeatherView()
        }
    }
