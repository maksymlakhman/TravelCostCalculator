//
//  TeamDataView.swift
//  TravelCostCalculator
//
//  Created by Максим Лахман on 16.03.2025.
//

import SwiftUI

struct TeamDataView: View {
    @Binding var teamData: TeamData
    @State private var totalPeopleText = ""
    @State private var athletesText = ""
    @State private var coachesText = ""
    @State private var twinRoomsText = ""
    @State private var singleRoomsText = ""
    @State private var stayDaysText = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Team Composition")) {
                    HStack {
                        Text("Total People")
                        Spacer()
                        TextField("Enter number", text: $totalPeopleText)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 120)
                            .onChange(of: totalPeopleText) { newValue in
                                if let value = Int(newValue) {
                                    teamData.totalPeople = value
                                } else {
                                    teamData.totalPeople = nil
                                }
                            }
                    }
                    
                    HStack {
                        Text("Athletes")
                        Spacer()
                        TextField("Enter number", text: $athletesText)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 120)
                            .onChange(of: athletesText) { newValue in
                                if let value = Int(newValue) {
                                    teamData.athletes = value
                                } else {
                                    teamData.athletes = nil
                                }
                            }
                    }
                    
                    HStack {
                        Text("Coaches")
                        Spacer()
                        TextField("Enter number", text: $coachesText)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 120)
                            .onChange(of: coachesText) { newValue in
                                if let value = Int(newValue) {
                                    teamData.coaches = value
                                } else {
                                    teamData.coaches = nil
                                }
                            }
                    }
                }
                
                Section(header: Text("Accommodation")) {
                    HStack {
                        Text("Twin Rooms")
                        Spacer()
                        TextField("Enter number", text: $twinRoomsText)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 120)
                            .onChange(of: twinRoomsText) { newValue in
                                if let value = Int(newValue) {
                                    teamData.twinRooms = value
                                } else {
                                    teamData.twinRooms = nil
                                }
                            }
                    }
                    
                    HStack {
                        Text("Single Rooms")
                        Spacer()
                        TextField("Enter number", text: $singleRoomsText)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 120)
                            .onChange(of: singleRoomsText) { newValue in
                                if let value = Int(newValue) {
                                    teamData.singleRooms = value
                                } else {
                                    teamData.singleRooms = nil
                                }
                            }
                    }
                    
                    HStack {
                        Text("Stay Duration (days)")
                        Spacer()
                        TextField("Enter number", text: $stayDaysText)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 120)
                            .onChange(of: stayDaysText) { newValue in
                                if let value = Int(newValue) {
                                    teamData.stayDays = value
                                } else {
                                    teamData.stayDays = nil
                                }
                            }
                    }
                }
            }
            .navigationTitle("Team Data")
        }
    }
}
