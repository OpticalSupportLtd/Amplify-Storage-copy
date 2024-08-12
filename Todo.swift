// swiftlint:disable all
import Amplify
import Foundation

public struct Todo: Model, Identifiable, Equatable {
    public let id: String
    public var content: String?
    public var isDone: Bool
    public var createdAt: Temporal.DateTime?
    public var updatedAt: Temporal.DateTime?

    public init(id: String = UUID().uuidString,
                content: String? = nil,
                isDone: Bool = false) {
        self.init(id: id,
                  content: content,
                  isDone: isDone,
                  createdAt: nil,
                  updatedAt: nil)
    }

    internal init(id: String = UUID().uuidString,
                  content: String? = nil,
                  isDone: Bool = false,
                  createdAt: Temporal.DateTime? = nil,
                  updatedAt: Temporal.DateTime? = nil) {
        self.id = id
        self.content = content
        self.isDone = isDone
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
