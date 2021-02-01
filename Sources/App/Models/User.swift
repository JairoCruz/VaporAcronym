import Vapor
import Fluent

final class User: Model, Content {

    struct UserPublic: Content {
    var id: UUID
    var name: String
    var username: String
    var created_at: Date?
    var updated_at: Date?
}

    // Name of the table or collection.

    static let schema = "users"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "username")
    var username: String

    @Field(key: "password")
    var password: String

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    @Children(for: \.$user)
    var acronyms: [Acronym]
    

    init() { }

    init(name: String, username: String, password: String) {
        self.name = name
        self.username = username
        self.password = password
    }

    // Inner Class
    final class Public: Codable {
        var id: UUID?
        var name: String
        var username: String

        init(id: UUID?, name: String, username: String) {
            self.id = id
            self.name = name
            self.username = username
        }
    }

}

extension User {

    func convertToPublic() throws -> UserPublic {
        return UserPublic(id: try requireID(), 
        name: name, 
        username: username,
        created_at: createdAt,
        updated_at: updatedAt
        )
    }
    
}

