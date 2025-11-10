import SwiftUI

@Observable public class WizardState {
    public let nodes: [Node]
    public var location: Location {
        didSet {
            if isComplete {
                completionCount += 1
            }
        }
    }

    public var stepIsValid: Bool? = nil
    public var completionCount: Int = 0

    public var canContinue: Bool {
        guard let (_, step, _) = current else { return false }
        guard step.withValidation == true else { return true }

        return stepIsValid ?? false
    }

    public var isOnFirstStep: Bool {
        return location.node == 0 && location.step == 0
    }

    public var isOnLastStep: Bool {
        return location.node == nodes.count - 1
            && location.step == (nodes.last?.steps.count ?? 0) - 1
    }

    @discardableResult
    public func next() -> Self {
        guard let currentNode else {
            return self
        }

        stepIsValid = nil
        if location.step == currentNode.steps.count - 1 {
            location = location.advancing(nodes: 1)
        } else {
            location = location.advancing(steps: 1)
        }

        return self
    }

    @discardableResult
    public func previous() -> Self {
        if location.step > 0 {
            location = .init(node: location.node, step: location.step - 1)
        } else if location.node > 0 {
            if let newNode = nodes.maybeGet(index: location.node - 1) {
                location = .init(node: location.node - 1, step: newNode.steps.count - 1)
            } else {
                location = .init(node: location.node - 1, step: 0)
            }
        } else {
            location = .init(node: 0, step: 0)
        }

        return self
    }

    public var isComplete: Bool {
        location.node == nodes.count
    }

    public init(nodes: [Node], location: Location) {
        self.nodes = nodes
        self.location = location
    }

    public func setLocation(node: Int, step: Int) -> Self {
        location = .init(node: node, step: step)
        return self
    }
}

extension WizardState {
    public var current: (Node, Step, Location)? {
        guard let (node, step) = nodes.maybeGet(location: location) else { return nil }

        return (node, step, location)
    }
}

/// Extensions for Nodes
extension WizardState {
    public var currentNode: Node? {
        nodes.maybeGet(index: location.node)
    }

    public var nextNode: Node? {
        nodes.maybeGet(index: location.node + 1)
    }

    public var previousNode: Node? {
        nodes.maybeGet(index: location.node + 1)
    }

    public var firstNode: Node? {
        nodes.maybeGet(index: 0)
    }

    public var finalNode: Node? {
        nodes.maybeGet(index: nodes.count - 1)
    }
}

extension WizardState {
    public static var forPreview: WizardState {
        .init(nodes: .forPreview, location: .initial())
    }

    public static var forPreviewMiddle: WizardState {
        .init(nodes: .forPreview, location: .init(node: 1, step: 1))
    }

    public static var forPreviewComplete: WizardState {
        .init(nodes: .forPreview, location: [Node].forPreview.lastLocation)
    }
}
