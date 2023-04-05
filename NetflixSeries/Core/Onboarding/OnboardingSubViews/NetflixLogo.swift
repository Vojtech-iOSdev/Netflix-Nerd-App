//
//  NetflixLogo.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 04.04.2023.
//

import SwiftUI

struct NetflixLogo: View {
    var body: some View {
        Image("Netflix")
            .resizable()
            .scaledToFit()
            .frame(height: 160)
    }
}

struct NetflixLogo_Previews: PreviewProvider {
    static var previews: some View {
        NetflixLogo()
    }
}
