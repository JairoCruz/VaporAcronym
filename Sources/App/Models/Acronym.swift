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

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    @Parent(key: "user_id")
    var user: User

    // Greates a new, empty acronym
    init() { }

    // Creates a new Acronym with all properties set.
    init(id: UUID? = nil, short: String, long: String, userID: UUID) {
        self.id = id
        self.short = short
        self.long = long
        self.$user.id = userID

    }

}