import Vapor
import Fluent

final class Acronym: Model, Content {
    // Name of the table or collection.
    static let schema = "acronymus"

    // Unique identifier for this Acronym
    @ID(key: .id)
    var id: UUID?

    // The Acronym's fiels.
    @Field(key: "short")
    var short: String

    @Field(key: "long")
    var long: String

    // Greates a new, empty acronym
    init() { }

    // Creates a new Acronym with all properties set.
    init(id: UUID? = nil, short: String, long: String) {
        self.id = id
        self.short = short
        self.long = long

    }

}