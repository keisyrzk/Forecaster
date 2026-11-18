//
//  AppOverlayModifier.swift
//  Forecaster
//
//  Created by Esteban on 18/11/2026.
//

import SwiftUI

private struct AppOverlayModifier: ViewModifier {
    @Binding var overlay: AppOverlayType?

    func body(content: Content) -> some View {
        content
            .disabled(overlay != nil)
            .overlay {
                if overlay != nil {
                    switch overlay {
                    case .loader:
                        ZStack {
                            Color.black.opacity(0.5)
                                .ignoresSafeArea()
                            
                            AppLoader()
                        }
                        
                    case .alert(let message):
                        AppAlert(message: message) {
                            overlay = nil
                        }
                        
                    case nil:
                        EmptyView()
                    }
                }
            }
    }
}

extension View {
    func appOverlay(_ overlay: Binding<AppOverlayType?>) -> some View {
        modifier(AppOverlayModifier(overlay: overlay))
    }
}
