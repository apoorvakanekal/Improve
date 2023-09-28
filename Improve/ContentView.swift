//
//  ContentView.swift
//  Improve
//
//  Created by Apoorva Kanekal on 9/28/23.
//

import SwiftUI

var Bg = Color.blue

struct ContentView: View {
    
    var body: some View {
        
        TabView{
            HelloPageView()
                .toolbarBackground(.yellow, for: .tabBar) //helps the icon contrast on blue
                .tabItem{
                    Label("Home", systemImage:"house")
                }
            WeatherView()
                .tabItem{
                    Label("Weather", systemImage: "cloud")
                }
            ActivityView()
                .tabItem{
                    Label("Activities", systemImage:"person")
                }
        }
    }
    
    
    struct HelloPageView : View {
        
        @State var backgroundColor = Color.blue
        @State var circleColor = Color.yellow
        @State var changeColor = true
        @State var text = "Hello, Day"
        @State private var showingAlert = false
        @State private var navTitleColor = Color.black
        
        var body: some View {
            NavigationView{
                ZStack{
                    backgroundColor
                        .ignoresSafeArea()
                    VStack{
                        Text(text)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Circle()
                            .foregroundColor(circleColor)
                            .scaleEffect(0.75)
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(.white)
                                .frame(width:200,height:75)
                            
                            Button("Change Time"){
                                showingAlert = true
                            }
                            .foregroundColor(.black)
                            .alert("You are about to switch the timezone from which you are currently in. Continue?", isPresented: $showingAlert){
                                Button("No", role: .none){ }
                                Button("Yes", role: .cancel){
                                    if changeColor{
                                        self.backgroundColor = Color.black
                                        self.circleColor = Color.white
                                        self.text = "Hello, Night"
                                        self.changeColor = false
                                    }
                                    
                                    else{
                                        self.backgroundColor = Color.blue
                                        self.circleColor = Color.yellow
                                        self.text = "Hello, Day"
                                        self.changeColor = true
                                    }
                                }
                            }}}
                }
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}

