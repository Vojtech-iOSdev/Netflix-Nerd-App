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
    @StateObject var vm: SeriesViewModel = SeriesViewModel()
    
    @State var alertTermsOfServices: Bool = false
    @State var selectedItems: [PhotosPickerItem] = []
    @State var data: Data?
    
    // APP STORAGE
    @AppStorage("name") var currentUserName: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("nationality") var currentUserNationality: String?
    @AppStorage("isSigned") var isSigned: Bool = false
    
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
    
    private var profilePicture: some View {
        VStack {
            if let data = data, let uiimage = UIImage(data: data) {
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
                selection: $selectedItems,
                maxSelectionCount: 1,
                matching: .images
            ) {
                if selectedItems.count >= 1 {
                    Text("edit ".uppercased())
                        .font(.system(.headline, design: .rounded, weight: .medium))
                } else {
                    VStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 160)
                            .foregroundColor(Color.white)
                        Text("edit picture ".uppercased())
                            .font(.system(.headline, design: .rounded, weight: .medium))
                    }
                }
            }
            .onChange(of: selectedItems) { newValue in
                guard let item = selectedItems.first else {
                    return
                }
                item.loadTransferable(type: Data.self) { result in
                    switch result {
                    case .success(let data):
                        if let data = data {
                            self.data = data
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
    
    private var personalInfoSection: some View {
        Section {
            Text("Name: \(currentUserName ?? "Your name is not set")")
            Text("Age: \(String(currentUserAge ?? 0))")
            Text("Gender: \(currentUserGender ?? "Your gender is not set")")
            Text("Nationality: \(currentUserNationality ?? "Your name is not set")")
            
            
        } header: {
            Text("Personal Info")
                .foregroundColor(Color.white)
        }
        .formStyle(.grouped)
        .foregroundColor(Color.white)
        .font(.system(.headline, design: .rounded, weight: .medium))

    }
    
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
                    alertTermsOfServices = true
                }.alert(isPresented: $alertTermsOfServices) {
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
    
    private var signOutButton: some View {
        Button {
            vm.signOut()
        } label: {
            Label("Sign out".uppercased(), systemImage: "return")
                .foregroundColor(Color.white)
                .font(.system(.headline, design: .rounded, weight: .medium))


        }
    }
    
}
