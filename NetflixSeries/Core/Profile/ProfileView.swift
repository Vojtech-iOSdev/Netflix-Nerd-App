//
//  ProfileView.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 24.02.2023.
//

import SwiftUI
import PhotosUI
import CoreLocationUI

struct ProfileView: View {

    @StateObject var locationManager: LocationManager = LocationManager.shared
    @StateObject var onboardingVM: OnboardingViewModel = OnboardingViewModel()
    @StateObject var vm: ProfileViewModel = ProfileViewModel()
    
    // MARK: BODY
    var body: some View {
        ZStack {
            // BACKGROUND
            Color.black.edgesIgnoringSafeArea(.all)
            
            // FOREGROUND
            VStack {
                profilePicture
                Form {
                    personalInfoSection
                        .sheet(item: $vm.activeSheet) { selectedSheet in
                            switch selectedSheet {
                            case .editNameSheet:
                                EditNameSheet()
                            case .editAgeSheet:
                                EditAgeSheet()
                            case .editGenderSheet:
                                EditGenderSheet()
                            }
                        }
                    settingsSection
                    signOutButton
                }
                .foregroundColor(Color.black)
                .scrollContentBackground(.hidden)
            }
            .onAppear {
                vm.getProfilePicture()
            }
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

// MARK: COMPONENTS
extension ProfileView {
    
    
    // MARK: profilePicture
    private var profilePicture: some View {
        VStack {
            PhotosPicker(selection: $vm.selectedPhotos,
                         maxSelectionCount: 1,
                         matching: .images,
                         photoLibrary: .shared()) {
                
                if vm.profilePicture != nil {
                    VStack {
                        if let profilePicture = vm.profilePicture {
                            Image(uiImage: profilePicture) 
                                .resizable()
                                .scaledToFill()
                                .frame(width: 170, height: 170)
                                .clipped()
                                .cornerRadius(85)
                                .shadow(color: .white, radius: 6, x: 0, y: 0)
                        } else {
                            ProgressView()
                                .frame(width: 170, height: 170)
                        }
                        Text("edit ".uppercased())
                            .font(.system(.subheadline, design: .rounded, weight: .medium))
                    }
                } else {
                    VStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 170)
                            .foregroundColor(Color.gray.opacity(0.4))
                        Text("add picture ".uppercased())
                            .font(.system(.subheadline, design: .rounded, weight: .medium))
                    }
                }
            }
        }
        .padding()
    }
    
    // MARK: personalInfoSection
    private var personalInfoSection: some View {
        Section {
            HStack {
                Text("Name:          \(onboardingVM.currentUserName ?? onboardingVM.nameInput)")
                Spacer()
                Image(systemName: "pencil")
                    .foregroundColor(.red)
                    .font(.title2)
                    .onTapGesture {
                        vm.activeSheet = .editNameSheet
                    }
            }
            
            HStack {
                Text("Age:              \(onboardingVM.currentUserAge ?? 0)")
                Spacer()
                Image(systemName: "pencil")
                    .foregroundColor(.red)
                    .font(.title2)
                    .onTapGesture {
                        vm.activeSheet = .editAgeSheet
                    }
            }
            
            HStack {
                Text("Gender:       \(onboardingVM.currentUserGender ?? "Your gender is not set")")
                Spacer()
                Image(systemName: "pencil")
                    .foregroundColor(.red)
                    .font(.title2)
                    .onTapGesture {
                        vm.activeSheet = .editGenderSheet
                    }
            }
            
            HStack {
                Text("Country:      \(locationManager.country == nil ? onboardingVM.currentUserCountry ?? "Your country is not set" : locationManager.country ?? "")")
                Spacer()
                LocationButton {
                    Task {
                        try await locationManager.getCountryFromCurrentLocation()
                    }
                }
                .labelStyle(.iconOnly)
                .symbolVariant(.none)
                .font(.subheadline)
                .tint(.red)
                .cornerRadius(20)
            }
        } header: {
            Text("Personal Info")
                .foregroundColor(Color.white)
        }
        .formStyle(.grouped)
        .foregroundColor(Color.white)
        .font(.system(.headline, design: .rounded, weight: .medium))
        
    }
    
    // MARK: settingsSection
    private var settingsSection: some View {
        Section {
            Toggle(isOn: $vm.notificationsOn) {
                Text("Enable Notifications")
            }
            .tint(Color.red)
            Toggle(isOn: $vm.kidAccountOn) {
                Text("Enable account for kids")
            }
            .tint(Color.red)
            
            Text("Terms of service")
                .foregroundColor(Color.red)
                .onTapGesture {
                    vm.alertTermsOfServices = true
                }
                .alert(isPresented: $vm.alertTermsOfServices) {
                    Alert(title: Text("Terms Of Services"), message: Text("Do whatever you want to test this app!!!"))
                }
            
        } header: {
            Text("Settings")
                .foregroundColor(Color.white)
        }
        .formStyle(.grouped)
        .foregroundColor(Color.white)
        .font(.system(.headline, design: .rounded, weight: .medium))
        
    }
    
    // MARK: signOutButton
    private var signOutButton: some View {
        Button {
            vm.showConfirmationDialogToSignOut = true
        } label: {
            Label("Sign out".uppercased(), systemImage: "return")
                .foregroundColor(Color.red)
                .font(.system(.headline, design: .rounded, weight: .medium))
        }
        .confirmationDialog("Do you really wanna Sign out?", isPresented: $vm.showConfirmationDialogToSignOut, titleVisibility: .visible) {
            Button("Sign Out", role: .destructive) {
                locationManager.country = nil
                vm.deleteProfilePicture()
                vm.profilePicture = nil
                onboardingVM.signOut()
            }
        } message: {
            Text("If you sign out all your data will get lost!")
        }

    }
}
