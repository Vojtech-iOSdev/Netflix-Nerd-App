//
//  SeriesViewModel.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 21.02.2023.
//

import Foundation
import SwiftUI
import Combine

class SeriesViewModel: ObservableObject {
    // MARK: PROPERTIES
    
    // OTHER VIEW STUFF --- NEEDS REFACTORING
    @Published var notificationsOn: Bool = true
    @Published var kidAccountOn: Bool = false
    
    @Published var favouriteSeries: [Series] = []
    @Published var isFavourite: Bool = false
    
    // ONBOARDING INPUTS
    @Published var name: String = ""
    @Published var nameIsValid: Bool = false
    @Published var age: Double = 30
    @Published var gender: String = ""
    @Published var nationality: String = ""
    
    @Published var cancellables = Set<AnyCancellable>()

    
    init() {
        CheckIfNameIsValid()
        
    }
    
    // MARK: METHODS
    func CheckIfNameIsValid() {
        $name
            .debounce(for: .seconds(0.5) , scheduler: DispatchQueue.main)
            .map { (name) -> Bool in
                if name.count >= 2 && name.count < 13 {
                    return true
                }else{
                    return false
                }
            }
            .sink { [weak self] (nameIsValidated) in
                self?.nameIsValid = nameIsValidated
            }
            .store(in: &cancellables)
    }
    
    
    
}
