//
//  ListOfCountries.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 05.04.2023.
//

import SwiftUI

struct ListOfCountries: View {
    
    @StateObject private var vm: OnboardingViewModel = .init()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // LIST OF COUNTRIES
            List {
                Picker(selection: $vm.country) {
                    ForEach(NSLocale.isoCountryCodes, id: \.self) { countryCode in
                        HStack {
                            Text(vm.countryFlag(countryCode))
                            Text(Locale.current.localizedString(forRegionCode: countryCode) ?? "")
                            Spacer()
                            Text(countryCode)
                        }
                    }
                } label: {
                    Text("Select a Country")
                }
                .pickerStyle(.inline)
                .accentColor(Color.white)
                .foregroundColor(Color.white)
                .onChange(of: vm.country) { selectedCountryCode in
                    withAnimation(.spring()) {
                        vm.showSaveButton = true
                        vm.currentUserCountry = vm.convertToCountryName(selectedCountryCode: selectedCountryCode)
                    }
                }
            }
            
            // SAVE BUTTON
            if vm.showSaveButton {
                Button {
                    dismiss()
                } label: {
                    Text("SAVE")
                        .foregroundColor(Color.red)
                        .font(.system(.title, design: .rounded, weight: .medium))
                        .frame(width: 310, height: 50)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.bottom)
                }
            }
        }

    }
}

struct ListOfCountries_Previews: PreviewProvider {
    static var previews: some View {
        ListOfCountries()
    }
}
