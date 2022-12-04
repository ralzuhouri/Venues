//
//  VenuesApp.swift
//  Venues
//
//  Created by Ramy Al Zuhouri on 29/11/2022.
//

import SwiftUI

@main
struct VenuesApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                VenuesListView()
            }
        }
    }
}
