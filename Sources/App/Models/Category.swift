import Vapor
import Fluent

final class Category: Model, Content {

    static let schema = "categories"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    

    @Siblings(through: AcronymCategoryPivot.self, from: \.$category, to: \.$acronym)
    public var acronyms: [Acronym]

    init() { }

    init(id: UUID? = nil, name: String) {
        self.name = name
    }
}