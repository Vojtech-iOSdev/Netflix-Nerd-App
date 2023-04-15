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
    @Published var onboardingState: Int = 0
    @Published private var text: String = ""
    @Published var alertForName: Bool = false
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing),
                                                removal: .move(edge: .leading))
    @Published var showListOfCountries: Bool = false
    @Published var showSaveButton: Bool = false
    @Published var amount: Double = 0
    @Published var showConfettiAnimation: Bool = false
    @Published var finishConfettiAnimation: Bool = false
    
    // APP STORAGE
    @AppStorage("name", store: .standard) var currentUserName: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("country") var currentUserCountry: String?
    @AppStorage("isSigned") var isSigned: Bool = false
        
    // ONBOARDING INPUTS
    @Published var nameInput: String = ""
    @Published var nameIsValid: Bool = false
    @Published var age: Double = 45
    @Published var gender: String = ""
    @Published var country: String = ""
    
    @Published var cancellables = Set<AnyCancellable>()
    
    
    init() {
        checkIfNameIsValid()
    }
    
    func checkIfNameIsValid() {
        $nameInput
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
            if nameInput.count >= 2 && nameInput.count < 13 {
                withAnimation(.spring()){
                    onboardingState += 1
                }
            }else {
                alertForName = true
            }
        case 4:
            signIn()
            onboardingState += 1
        default:
            withAnimation(.spring()){
                onboardingState += 1
            }
        }
    }

    func signIn() {
        currentUserName = nameInput
        currentUserAge = Int(age)
        currentUserGender = gender
        //currentUserCountry = country
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
    
    func runCounter(counter: Binding<Double>, start: Double, end: Double, speed: Double) {
        counter.wrappedValue = start

        Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { timer in
            counter.wrappedValue += 1.0
            if counter.wrappedValue == end {
                timer.invalidate()
            }
        }
    }
    
    func doConfettiAnimation() {
        withAnimation(.spring()) {
            showConfettiAnimation = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 ) {
            withAnimation(.easeInOut(duration: 1)) {
                self.finishConfettiAnimation = true
            }
            
            // resetting after animation finished
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.finishConfettiAnimation = false
                self.showConfettiAnimation = false
            }
        }
        
    }
    
}
