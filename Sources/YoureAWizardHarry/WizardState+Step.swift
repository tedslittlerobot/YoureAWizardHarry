import Foundation
import SwiftUI

extension WizardState {
    public struct Step {
        public let title: String
        let showNavigation: Bool
        let withValidation: Bool
        @ViewBuilder let content: () -> any View

        public init(
            title: String, showNavigation: Bool = true, withValidation: Bool = false,
            @ViewBuilder content: @escaping () -> any View
        ) {
            self.title = title
            self.showNavigation = showNavigation
            self.withValidation = withValidation
            self.content = content
        }
    }
}

extension WizardState.Step: Equatable {
    public static func == (lhs: WizardState.Step, rhs: WizardState.Step) -> Bool {
        lhs.title == rhs.title
    }
}

extension [WizardState.Step] {
    public func maybeGet(index: Int) -> WizardState.Step? {
        if !indices.contains(index) {
            return nil
        }

        return self[index]
    }
}
