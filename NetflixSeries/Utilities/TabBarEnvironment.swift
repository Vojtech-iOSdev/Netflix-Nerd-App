//
//  TabBarEnvironment.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 13.04.2023.
//

import SwiftUI

struct CurrentTabKey: EnvironmentKey {
    static var defaultValue: Binding<SearchViewModel.Tab> = .constant(.homeView)
}

extension EnvironmentValues {
    var currentTab: Binding<SearchViewModel.Tab> {
        get { self[CurrentTabKey.self] }
        set { self[CurrentTabKey.self] = newValue }
    }
}
