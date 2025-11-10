import Foundation
import SwiftUI

extension WizardState {
    public struct Node {
        public let title: String
        public let image: Image
        public let steps: [Step]

        public init(title: String, image: Image, steps: [Step]) {
            self.title = title
            self.image = image
            self.steps = steps
        }
    }
}

extension WizardState.Node: Identifiable {
    public var id: String { title }
}

extension WizardState.Node: Equatable {}

extension [WizardState.Node] {
    public func maybeGet(index: Int) -> WizardState.Node? {
        if !indices.contains(index) {
            return nil
        }

        return self[index]
    }

    public func maybeGet(location: WizardState.Location) -> (WizardState.Node, WizardState.Step)? {
        maybeGet(nodeIndex: location.node, stepIndex: location.step)
    }

    public func maybeGet(nodeIndex: Int, stepIndex: Int) -> (WizardState.Node, WizardState.Step)? {
        guard let node = maybeGet(index: nodeIndex) else { return nil }
        guard let step = node.steps.maybeGet(index: stepIndex) else { return nil }

        return (node, step)
    }
}

extension [WizardState.Node] {
    public var lastLocation: WizardState.Location {
        let nodeIndex = Swift.max(0, self.count - 1)
        let node = self[nodeIndex]
        return .init(node: nodeIndex, step: Swift.max(0, node.steps.count - 1))
    }

    public static var forPreview: [WizardState.Node] {
        [
            .init(
                title: "Cha Cha Slide", image: Image(systemName: "shoe"),
                steps: [
                    .init(title: "Left") { Text("Slide to the left") },
                    .init(title: "Right") { Text("Slide to the right") },
                    .init(title: "Back") { Text("Take it back now y'all") },
                    .init(title: "Hop") { Text("One hop this time") },
                    .init(title: "Stomp Right") { Text("Right foot let's stomp") },
                    .init(title: "Stomp Left") { Text("Left foot let's stomp") },
                    .init(title: "Cha Cha") { Text("Cha Cha real smooth") },
                ]),
            .init(
                title: "Konami Code", image: Image(systemName: "gamecontroller"),
                steps: [
                    .init(title: "Up Up") { Text("Up Up") },
                    .init(title: "Down Down") { Text("Down Down") },
                    .init(title: "Left Right Left Right") { Text("Left Right Left Right") },
                    .init(title: "B A") { Text("B A") },
                ]),
            .init(
                title: "Profit!", image: Image(systemName: "bitcoinsign"),
                steps: [
                    .init(title: "Step One") { Text("Collect underpants") },
                    .init(title: "?") { Text("???") },
                    .init(title: "Profit!") { Text("Profit") },
                ]),
        ]
    }
}
