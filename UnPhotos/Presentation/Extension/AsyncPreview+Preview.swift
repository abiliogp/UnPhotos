//
//  AsyncPreview+Preview.swift
//  UnPhotos
//
//  Created by Abilio Gambim Parada on 08/05/2026.
//

import SwiftUI

extension Preview {
    struct AsyncPreview<Content: View, ActionTask>: View {
        var viewBuilder: (ActionTask) -> Content
        var action: () async throws -> ActionTask
        
        @State private var actionResult: ActionTask?
        
        var body: some View {
            Group {
                if let actionResult = actionResult {
                    viewBuilder(actionResult)
                } else {
                    Color.clear
                }
            }
            .task {
                actionResult = try? await action()
            }
        }
    }
}
