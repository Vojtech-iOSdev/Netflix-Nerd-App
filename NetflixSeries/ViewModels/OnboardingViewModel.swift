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
    // MARK: PROPERTIES
    
    // PROFILE VIEW ACCOUNT OPTIONS
    @Published var notificationsOn: Bool = true
    @Published var kidAccountOn: Bool = false
    
    // ONBOARDING VIEW STATE, THE ALERT AND TRANSITIONS
    @Published var onboardingState: Int = 0
    @Published private var text: String = ""
    @Published var alertForName: Bool = false
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing),
                                                removal: .move(edge: .leading))
    
    // APP STORAGE
    @AppStorage("name") var currentUserName: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("nationality") var currentUserNationality: String?
    @AppStorage("isSigned") var isSigned: Bool = false
        
    // ONBOARDING INPUTS
    @Published var name: String = ""
    @Published var nameIsValid: Bool = false
    @Published var age: Double = 20
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
        currentUserNationality = nationality
        withAnimation(.spring()) {
            isSigned = true
        }
    }
    
    func signOut() {
        currentUserName = nil
        currentUserAge = nil
        currentUserGender = nil
        currentUserNationality = nil
        withAnimation(.spring()) {
            isSigned = false
        }
    }
    
}
