//
//  OnboardingViewModel.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 21.02.2023.
//

import Foundation
import SwiftUI
import Combine

class OnboardingViewModel: ObservableObject {

    // ONBOARDING VIEW STATE, THE ALERT AND TRANSITIONS
    @Published var onboardingState: Int = 4
    @Published private var text: String = ""
    @Published var alertForName: Bool = false
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing),
                                                removal: .move(edge: .leading))
    @Published var showListOfCountries: Bool = false
    @Published var showSaveButton: Bool = false
    
    // APP STORAGE
    @AppStorage("name") var currentUserName: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("country") var currentUserCountry: String?
    @AppStorage("isSigned") var isSigned: Bool = false
        
    // ONBOARDING INPUTS
    @Published var name: String = ""
    @Published var nameIsValid: Bool = false
    @Published var age: Double = 45
    @Published var gender: String = ""
    @Published var country: String = ""
    
    @Published var cancellables = Set<AnyCancellable>()
    
    
    init() {
        checkIfNameIsValid()
    }
    
    func checkIfNameIsValid() {
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
    
    func showNextOnboardingScreen() {
        switch onboardingState {
        case 1:
            if name.count >= 2 && name.count < 13 {
                withAnimation(.spring()){
                    onboardingState += 1
                }
            }else {
                alertForName = true
            }
        case 4:
            signIn()
        default:
            withAnimation(.spring()){
                onboardingState += 1
            }
        }
    }
    
    func signIn() {
        currentUserName = name
        currentUserAge = Int(age)
        currentUserGender = gender
        //currentUserCountry = country
        withAnimation(.spring()) {
            isSigned = true
        }
    }
    
    func signOut() {
        currentUserName = nil
        currentUserAge = nil
        currentUserGender = nil
        currentUserCountry = nil
        withAnimation(.spring()) {
            isSigned = false
        }
    }
    
    func countryFlag(_ countryCode: String) -> String {
        String(String.UnicodeScalarView(countryCode.unicodeScalars.compactMap {
            UnicodeScalar(127397 + $0.value)
        }))
    }
    
    func convertToCountryName(selectedCountryCode: String) -> String {
        Locale.current.localizedString(forRegionCode: selectedCountryCode) ?? ""
    }
    
}
