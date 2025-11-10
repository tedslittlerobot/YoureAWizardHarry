import Foundation

extension WizardState {
    public struct Location {
        public let node: Int
        public let step: Int

        public static func initial() -> Location { Location(node: 0, step: 0) }

        public func advancing(nodes: Int) -> Location {
            .init(node: node + 1, step: 0)
        }

        public func advancing(steps: Int) -> Location {
            .init(node: node, step: step + 1)
        }
    }
}

extension WizardState.Location: Identifiable {
    public var id: String { "\(node)-\(step)" }
}

extension WizardState.Location: Equatable {}
