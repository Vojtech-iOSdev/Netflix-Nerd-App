//
//  ProfileViewModel.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 31.03.2023.
//

import Foundation
import SwiftUI
import PhotosUI
import Combine

class ProfileViewModel: ObservableObject {
    
    // ACCOUNT OPTIONS
    @Published var selectedPhotos: [PhotosPickerItem] = []
    @Published var data: Data?
    @Published var notificationsOn: Bool = true
    @Published var kidAccountOn: Bool = false
    @Published var alertTermsOfServices: Bool = false
    
    
    // PROFILE EDITS INPUTS
    @Published var editedName: String = ""
    private var cancelEditedNameIsValid = Set<AnyCancellable>()
    @Published var editedNameIsValid: Bool = false
    @Published var editedAge: Double = 20
//    @Published var gender: String = ""
//    @Published var nationality: String = ""
    
    // SHEETS
    @Published var showSheetForEditName: Bool = false
    @Published var showSheetForEditAge: Bool = false



    init() {
        CheckIfEditedNameIsValid()
    }
    
    func CheckIfEditedNameIsValid() {
        $editedName
            .debounce(for: .seconds(0.5) , scheduler: DispatchQueue.main)
            .map { (editedName) -> Bool in
                if editedName.count >= 2 && editedName.count < 13 {
                    return true
                }else{
                    return false
                }
            }
            .sink { [weak self] (nameIsValidated) in
                self?.editedNameIsValid = nameIsValidated
            }
            .store(in: &cancelEditedNameIsValid)
    }
    
//    func checkIfAgeIsValid() {
//        if editedAge >= 18 && editedAge < 100 {
//
//        } else {
//
//        }
//    }
    
}
    

