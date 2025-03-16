//
//  ScheduleDataView.swift
//  TravelCostCalculator
//
//  Created by Максим Лахман on 16.03.2025.
//

import SwiftUI

struct ScheduleDataView: View {
    @Binding var scheduleData: ScheduleData
    @Binding var useTransferPoolIndividual: Bool
    @State private var gymSessionsText = ""
    @State private var poolSessionsText = ""
    @State private var lunchCountText = ""
    @State private var dinnerCountText = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Dates")) {
                    DatePicker("Arrival Date", selection: Binding(
                        get: { scheduleData.arrivalDate ?? Date() },
                        set: { scheduleData.arrivalDate = $0 }
                    ), displayedComponents: .date)
                    
                    DatePicker("Departure Date", selection: Binding(
                        get: { scheduleData.departureDate ?? Date() },
                        set: { scheduleData.departureDate = $0 }
                    ), displayedComponents: .date)
                }
                
                Section(header: Text("Activities")) {
                    HStack {
                        Text("Gym Sessions")
                        Spacer()
                        TextField("Enter number", text: $gymSessionsText)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 120)
                            .onChange(of: gymSessionsText) { newValue in
                                if let value = Int(newValue) {
                                    scheduleData.gymSessions = value
                                } else {
                                    scheduleData.gymSessions = nil
                                }
                            }
                    }
                    
                    HStack {
                        Text("Pool Sessions")
                        Spacer()
                        TextField("Enter number", text: $poolSessionsText)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 120)
                            .onChange(of: poolSessionsText) { newValue in
                                if let value = Int(newValue) {
                                    scheduleData.poolSessions = value
                                } else {
                                    scheduleData.poolSessions = nil
                                }
                            }
                    }
                }
                
                Section(header: Text("Meals")) {
                    HStack {
                        Text("Lunch Count")
                        Spacer()
                        TextField("Enter number", text: $lunchCountText)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 120)
                            .onChange(of: lunchCountText) { newValue in
                                if let value = Int(newValue) {
                                    scheduleData.lunchCount = value
                                } else {
                                    scheduleData.lunchCount = nil
                                }
                            }
                    }
                    
                    HStack {
                        Text("Dinner Count")
                        Spacer()
                        TextField("Enter number", text: $dinnerCountText)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 120)
                            .onChange(of: dinnerCountText) { newValue in
                                if let value = Int(newValue) {
                                    scheduleData.dinnerCount = value
                                } else {
                                    scheduleData.dinnerCount = nil
                                }
                            }
                    }
                }
                
                Section(header: Text("Transfer Options")) {
                    Toggle("Use Individual Pool Transfers", isOn: $useTransferPoolIndividual)
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                }
            }
            .navigationTitle("Schedule Data")
        }
    }
}
