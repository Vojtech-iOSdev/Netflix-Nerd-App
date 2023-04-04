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

@MainActor
class ProfileViewModel: ObservableObject {
    // ACCOUNT OPTIONS
    @Published var images: [Image] = []
    @Published var selectedPhotos: [PhotosPickerItem] = [] {
        didSet {
            Task {
                if !selectedPhotos.isEmpty {
                    try await loadTransferable(from: selectedPhotos)
                }
            }
        }
    }
    @Published var notificationsOn: Bool = true
    @Published var kidAccountOn: Bool = false
    @Published var alertTermsOfServices: Bool = false
    
    // PROFILE EDITS INPUTS
    @Published var editedName: String = ""
    private var cancelEditedNameIsValid = Set<AnyCancellable>()
    @Published var editedAge: Double = 50
    @Published var editedGender: String = ""
//    @Published var nationality: String = ""
    
    // CHECKING IF INPUTS ARE VALID
    @Published var editedNameIsValid: Bool = false
    @Published var editedGenderIsValid: Bool = false
    
    // SHEETS
    @Published var activeSheet: ActiveSheet? = nil
    enum ActiveSheet: Identifiable {
        case editNameSheet
        case editAgeSheet
        case editGenderSheet
        
        var id: Int { hashValue }
    }
    
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
    
    func loadTransferable(from selectedPhotos: [PhotosPickerItem]) async throws{
        do {
            for photo in selectedPhotos {
                if let data = try await photo.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        self.images.append(Image(uiImage: uiImage))
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
    

