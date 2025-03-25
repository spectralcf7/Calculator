//
//  Calculator_iOSApp.swift
//  Calculator-iOS
//
//  Created by Mihnea Amihailesei on 02.04.2024.
//

import SwiftUI

@main
struct Calculator_iOSApp: App {
    var body: some Scene {
        WindowGroup {
            CalculatorView().environmentObject(CalculatorView.ViewModel())
        }
    }
}
