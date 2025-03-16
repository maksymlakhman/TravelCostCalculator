//
//  PriceDataView.swift
//  TravelCostCalculator
//
//  Created by Максим Лахман on 16.03.2025.
//

import SwiftUI

struct PriceDataView: View {
    @Binding var priceData: PriceData
    @State private var singleRoomPriceText = ""
    @State private var twinRoomPriceText = ""
    @State private var swimLanePriceText = ""
    @State private var gymPriceText = ""
    @State private var transferAirportHotelSmallText = ""
    @State private var transferAirportHotelLargeText = ""
    @State private var transferHotelPoolPriceText = ""
    @State private var busDayRentalPriceText = ""
    @State private var lunchPriceText = ""
    @State private var dinnerPriceText = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Accommodation Prices")) {
                    HStack {
                        Text("Single Room Price")
                        Spacer()
                        TextField("Enter price", text: $singleRoomPriceText)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 120)
                            .onChange(of: singleRoomPriceText) { newValue in
                                if let value = Double(newValue) {
                                    priceData.singleRoomPrice = value
                                } else {
                                    priceData.singleRoomPrice = nil
                                }
                            }
                    }
                    
                    HStack {
                        Text("Twin Room Price")
                        Spacer()
                        TextField("Enter price", text: $twinRoomPriceText)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 120)
                            .onChange(of: twinRoomPriceText) { newValue in
                                if let value = Double(newValue) {
                                    priceData.twinRoomPrice = value
                                } else {
                                    priceData.twinRoomPrice = nil
                                }
                            }
                    }
                }
                
                Section(header: Text("Facility Prices")) {
                    HStack {
                        Text("Swim Lane Price (per hour)")
                        Spacer()
                        TextField("Enter price", text: $swimLanePriceText)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 120)
                            .onChange(of: swimLanePriceText) { newValue in
                                if let value = Double(newValue) {
                                    priceData.swimLanePrice = value
                                } else {
                                    priceData.swimLanePrice = nil
                                }
                            }
                    }
                    
                    HStack {
                        Text("Gym Price (per 2h visit)")
                        Spacer()
                        TextField("Enter price", text: $gymPriceText)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 120)
                            .onChange(of: gymPriceText) { newValue in
                                if let value = Double(newValue) {
                                    priceData.gymPrice = value
                                } else {
                                    priceData.gymPrice = nil
                                }
                            }
                    }
                }
                
                Section(header: Text("Transfer Prices")) {
                    HStack {
                        Text("Airport-Hotel (20 pax)")
                        Spacer()
                        TextField("Enter price", text: $transferAirportHotelSmallText)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 120)
                            .onChange(of: transferAirportHotelSmallText) { newValue in
                                if let value = Double(newValue) {
                                    priceData.transferAirportHotelSmall = value
                                } else {
                                    priceData.transferAirportHotelSmall = nil
                                }
                            }
                    }
                    
                    HStack {
                        Text("Airport-Hotel (45 pax)")
                        Spacer()
                        TextField("Enter price", text: $transferAirportHotelLargeText)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 120)
                            .onChange(of: transferAirportHotelLargeText) { newValue in
                                if let value = Double(newValue) {
                                    priceData.transferAirportHotelLarge = value
                                } else {
                                    priceData.transferAirportHotelLarge = nil
                                }
                            }
                    }
                    
                    HStack {
                        Text("Hotel-Pool (per transfer)")
                        Spacer()
                        TextField("Enter price", text: $transferHotelPoolPriceText)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 120)
                            .onChange(of: transferHotelPoolPriceText) { newValue in
                                if let value = Double(newValue) {
                                    priceData.transferHotelPoolPrice = value
                                } else {
                                    priceData.transferHotelPoolPrice = nil
                                }
                            }
                    }
                    
                    HStack {
                        Text("Bus Day Rental")
                        Spacer()
                        TextField("Enter price", text: $busDayRentalPriceText)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 120)
                            .onChange(of: busDayRentalPriceText) { newValue in
                                if let value = Double(newValue) {
                                    priceData.busDayRentalPrice = value
                                } else {
                                    priceData.busDayRentalPrice = nil
                                }
                            }
                    }
                }
                
                Section(header: Text("Meal Prices")) {
                    HStack {
                        Text("Lunch Price (per person)")
                        Spacer()
                        TextField("Enter price", text: $lunchPriceText)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 120)
                            .onChange(of: lunchPriceText) { newValue in
                                if let value = Double(newValue) {
                                    priceData.lunchPrice = value
                                } else {
                                    priceData.lunchPrice = nil
                                }
                            }
                    }
                    
                    HStack {
                        Text("Dinner Price (per person)")
                        Spacer()
                        TextField("Enter price", text: $dinnerPriceText)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 120)
                            .onChange(of: dinnerPriceText) { newValue in
                                if let value = Double(newValue) {
                                    priceData.dinnerPrice = value
                                } else {
                                    priceData.dinnerPrice = nil
                                }
                            }
                    }
                }
            }
            .navigationTitle("Price Data")
        }
    }
}
