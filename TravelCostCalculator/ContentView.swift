//
//  ContentView.swift
//  TravelCostCalculator
//
//  Created by Максим Лахман on 16.03.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var teamData = TeamData()
    @State private var priceData = PriceData()
    @State private var scheduleData = ScheduleData()
    @State private var useTransferPoolIndividual: Bool = true
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            TeamDataView(teamData: $teamData)
                .tabItem {
                    Label("Team", systemImage: "person.3")
                }
                .tag(0)
            
            PriceDataView(priceData: $priceData)
                .tabItem {
                    Label("Prices", systemImage: "dollarsign.circle")
                }
                .tag(1)
            
            ScheduleDataView(scheduleData: $scheduleData, useTransferPoolIndividual: $useTransferPoolIndividual)
                .tabItem {
                    Label("Schedule", systemImage: "calendar")
                }
                .tag(2)
            
            CalculationView(teamData: teamData, priceData: priceData, scheduleData: scheduleData, useTransferPoolIndividual: useTransferPoolIndividual)
                .tabItem {
                    Label("Results", systemImage: "sum")
                }
                .tag(3)
        }
        .padding()
    }
}
