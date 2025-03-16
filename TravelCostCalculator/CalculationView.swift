//
//  CalculationView.swift
//  TravelCostCalculator
//
//  Created by Максим Лахман on 16.03.2025.
//

import SwiftUI

struct CalculationView: View {
    let teamData: TeamData
    let priceData: PriceData
    let scheduleData: ScheduleData
    let useTransferPoolIndividual: Bool
    
    var accommodationCost: Double {
        guard let twinRooms = teamData.twinRooms,
              let singleRooms = teamData.singleRooms,
              let stayDays = teamData.stayDays,
              let twinRoomPrice = priceData.twinRoomPrice,
              let singleRoomPrice = priceData.singleRoomPrice else {
            return 0
        }
        
        let twinCost = Double(twinRooms) * twinRoomPrice * Double(stayDays)
        let singleCost = Double(singleRooms) * singleRoomPrice * Double(stayDays)
        return twinCost + singleCost
    }
    
    var transferAirportCost: Double {
        guard let totalPeople = teamData.totalPeople,
              let transferSmall = priceData.transferAirportHotelSmall,
              let transferLarge = priceData.transferAirportHotelLarge else {
            return 0
        }
        
        if totalPeople <= 20 {
            return transferSmall * 2 // round trip
        } else {
            return transferLarge * 2 // round trip
        }
    }
    
    var transferPoolCost: Double {
        guard let poolSessions = scheduleData.poolSessions else {
            return 0
        }
        
        if useTransferPoolIndividual {
            guard let transferPrice = priceData.transferHotelPoolPrice else {
                return 0
            }
            // Each pool session requires 2 transfers (to and from)
            return transferPrice * Double(poolSessions) * 2
        } else {
            guard let busDayPrice = priceData.busDayRentalPrice else {
                return 0
            }
            // Using day rental for pool days
            let poolDays = (poolSessions + 1) / 2 // Approximate number of days with pool sessions
            return busDayPrice * Double(poolDays)
        }
    }
    
    var mealsCost: Double {
        guard let totalPeople = teamData.totalPeople else {
            return 0
        }
        
        var cost: Double = 0
        
        if let lunchCount = scheduleData.lunchCount, let lunchPrice = priceData.lunchPrice {
            cost += lunchPrice * Double(totalPeople) * Double(lunchCount)
        }
        
        if let dinnerCount = scheduleData.dinnerCount, let dinnerPrice = priceData.dinnerPrice {
            cost += dinnerPrice * Double(totalPeople) * Double(dinnerCount)
        }
        
        return cost
    }
    
    var gymCost: Double {
        guard let gymSessions = scheduleData.gymSessions,
              let gymPrice = priceData.gymPrice else {
            return 0
        }
        
        return gymPrice * Double(gymSessions)
    }
    
    var poolCost: Double {
        guard let poolSessions = scheduleData.poolSessions,
              let athletes = teamData.athletes,
              let swimLanePrice = priceData.swimLanePrice else {
            return 0
        }
        
        // Assuming about 3 athletes per lane as per original data
        let lanesNeeded = ceil(Double(athletes) / 3.0)
        return swimLanePrice * lanesNeeded * Double(poolSessions) * 2 // 2 hours per session
    }
    
    var servicesCost: Double {
        return transferAirportCost + transferPoolCost + mealsCost + gymCost + poolCost
    }
    
    var totalCost: Double {
        return accommodationCost + servicesCost
    }
    
    var servicesPerPersonPerDay: Double {
        guard let totalPeople = teamData.totalPeople,
              let stayDays = teamData.stayDays,
              totalPeople > 0,
              stayDays > 0 else {
            return 0
        }
        
        return servicesCost / Double(totalPeople) / Double(stayDays)
    }
    
    var pricePerPersonInSinglePerDay: Double {
        guard let singleRoomPrice = priceData.singleRoomPrice else {
            return 0
        }
        
        return servicesPerPersonPerDay + singleRoomPrice
    }
    
    var pricePerPersonInTwinPerDay: Double {
        guard let twinRoomPrice = priceData.twinRoomPrice else {
            return 0
        }
        
        return servicesPerPersonPerDay + (twinRoomPrice / 2.0) // Divided by 2 for per person
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Accommodation Costs")) {
                    HStack {
                        Text("Twin Rooms")
                        Spacer()
                        Text("$\(accommodationCost, specifier: "%.2f")")
                    }
                }
                
                Section(header: Text("Service Costs")) {
                    HStack {
                        Text("Airport Transfers")
                        Spacer()
                        Text("$\(transferAirportCost, specifier: "%.2f")")
                    }
                    
                    HStack {
                        Text("Pool Transfers")
                        Spacer()
                        Text("$\(transferPoolCost, specifier: "%.2f")")
                    }
                    
                    HStack {
                        Text("Meals")
                        Spacer()
                        Text("$\(mealsCost, specifier: "%.2f")")
                    }
                    
                    HStack {
                        Text("Gym")
                        Spacer()
                        Text("$\(gymCost, specifier: "%.2f")")
                    }
                    
                    HStack {
                        Text("Pool")
                        Spacer()
                        Text("$\(poolCost, specifier: "%.2f")")
                    }
                    
                    HStack {
                        Text("Services Subtotal")
                        Spacer()
                        Text("$\(servicesCost, specifier: "%.2f")")
                            .fontWeight(.bold)
                    }
                }
                
                Section(header: Text("Total")) {
                    HStack {
                        Text("Total Cost")
                        Spacer()
                        Text("$\(totalCost, specifier: "%.2f")")
                            .fontWeight(.bold)
                    }
                    
                    HStack {
                        Text("Services per Person per Day")
                        Spacer()
                        Text("$\(servicesPerPersonPerDay, specifier: "%.2f")")
                    }
                }
                
                Section(header: Text("Per Person Pricing")) {
                    HStack {
                        Text("Price per Person (SGL) per Day")
                        Spacer()
                        Text("$\(pricePerPersonInSinglePerDay, specifier: "%.2f")")
                    }
                    
                    HStack {
                        Text("Price per Person (TWIN) per Day")
                        Spacer()
                        Text("$\(pricePerPersonInTwinPerDay, specifier: "%.2f")")
                    }
                }
                
                Section(header: Text("Summary Report")) {
                    Button("Share Calculation") {
                        let report = generateReport()
                        let activityVC = UIActivityViewController(activityItems: [report], applicationActivities: nil)
                        
                        // Find the active window scene and present from there
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                           let window = windowScene.windows.first,
                           let rootVC = window.rootViewController {
                            rootVC.present(activityVC, animated: true)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .buttonStyle(.borderedProminent)
                }
            }
            .navigationTitle("Calculation Results")
        }
    }
    
    func generateReport() -> String {
        var report = "Travel Cost Calculation\n"
        report += "=====================\n\n"
        
        // Team data
        report += "Team Details:\n"
        if let totalPeople = teamData.totalPeople {
            report += "Total People: \(totalPeople)\n"
        }
        if let athletes = teamData.athletes {
            report += "Athletes: \(athletes)\n"
        }
        if let coaches = teamData.coaches {
            report += "Coaches: \(coaches)\n"
        }
        report += "\n"
        
        // Accommodation
        report += "Accommodation:\n"
        if let twinRooms = teamData.twinRooms {
            report += "Twin Rooms: \(twinRooms)\n"
        }
        if let singleRooms = teamData.singleRooms {
            report += "Single Rooms: \(singleRooms)\n"
        }
        if let stayDays = teamData.stayDays {
            report += "Stay Duration: \(stayDays) days\n"
        }
        report += "Accommodation Cost: $\(String(format: "%.2f", accommodationCost))\n\n"
        
        // Services
        report += "Services:\n"
        report += "Airport Transfers: $\(String(format: "%.2f", transferAirportCost))\n"
        report += "Pool Transfers: $\(String(format: "%.2f", transferPoolCost))\n"
        report += "Meals: $\(String(format: "%.2f", mealsCost))\n"
        report += "Gym: $\(String(format: "%.2f", gymCost))\n"
        report += "Pool: $\(String(format: "%.2f", poolCost))\n"
        report += "Services Subtotal: $\(String(format: "%.2f", servicesCost))\n\n"
        
        // Total
        report += "Total Cost: $\(String(format: "%.2f", totalCost))\n"
        report += "Services per Person per Day: $\(String(format: "%.2f", servicesPerPersonPerDay))\n"
        report += "Price per Person (SGL) per Day: $\(String(format: "%.2f", pricePerPersonInSinglePerDay))\n"
        report += "Price per Person (TWIN) per Day: $\(String(format: "%.2f", pricePerPersonInTwinPerDay))\n"
        
        return report
    }
}
