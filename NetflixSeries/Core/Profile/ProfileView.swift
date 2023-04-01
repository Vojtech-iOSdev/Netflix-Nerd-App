//
//  ProfileView.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 24.02.2023.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    // MARK: PROPERTIES
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
                    settingsSection
                    signOutButton
                }
                .foregroundColor(Color.black)
                .scrollContentBackground(.hidden)
            }
        }
        
    }
}

// MARK: PREVIEW
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
            if let data = vm.data, let uiimage = UIImage(data: data) {
                Image(uiImage: uiimage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(maxWidth: 250)
                    .minimumScaleFactor(0.3)
                    .tint(Color.gray)
                    .font(.caption)
                
            }
            
            PhotosPicker(
                selection: $vm.selectedPhotos,
                maxSelectionCount: 1,
                matching: .images
            ) {
                if vm.selectedPhotos.count >= 1 {
                    Text("edit ".uppercased())
                        .font(.system(.headline, design: .rounded, weight: .medium))
                } else {
                    VStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 160)
                            .foregroundColor(Color.white)
                        Text("add picture ".uppercased())
                            .font(.system(.headline, design: .rounded, weight: .medium))
                    }
                }
            }
            .onChange(of: vm.selectedPhotos) { newValue in
                guard let item = vm.selectedPhotos.first else {
                    return
                }
                item.loadTransferable(type: Data.self) { result in
                    switch result {
                    case .success(let data):
                        if let data = data {
                            self.vm.data = data
                        } else {
                            print("Data is nil")
                        }
                    case .failure(let failure):
                        fatalError("\(failure)")
                    }
                }
            }
        }
    }
    
    // MARK: personalInfoSection
    private var personalInfoSection: some View {
        Section {
            HStack {
                Text("Name:   \(onboardingVM.currentUserName ?? "Your name is not set")")
                Spacer()
                Image(systemName: "pencil")
                    .onTapGesture {
                        vm.showSheetForEditName = true
                    }
                    .sheet(isPresented: $vm.showSheetForEditName) {
                        EditNameSheet()
                    }
            }
            
            HStack {
                Text("Age:   \(onboardingVM.currentUserAge ?? 0)")
                Spacer()
                Image(systemName: "pencil")
                    .onTapGesture {
                        vm.showSheetForEditAge = true
                    }
                    .sheet(isPresented: $vm.showSheetForEditAge) {
                        EditAgeSheet()
                    }
            }
            Text("Gender: \(onboardingVM.currentUserGender ?? "Your gender is not set")")
            Text("Nationality: \(onboardingVM.currentUserNationality ?? "Your nationality is not set")")  
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
            onboardingVM.signOut()
        } label: {
            Label("Sign out".uppercased(), systemImage: "return")
                .foregroundColor(Color.white)
                .font(.system(.headline, design: .rounded, weight: .medium))
            
            
        }
    }
    
}
