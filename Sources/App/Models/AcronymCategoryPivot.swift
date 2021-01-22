import Vapor
import Fluent
//DF533DB1-ACB3-47DE-B1F9-7C6B6AF3265E categories
//69FF8B5E-2C24-4D5A-B171-8BB4345B0D7B acronym
final class AcronymCategoryPivot: Model {
    
    static let schema = "acronym-category-pivot"
    
    @ID(key: .id)
    var id: UUID?

    @Parent(key: "acronymID")
    var acronym: Acronym

    @Parent(key: "categoryID")
    var category: Category

    init() { }

    init(id: UUID? = nil, acronym: Acronym, category: Category) throws {
        self.id = id
        self.$acronym.id = try acronym.requireID()
        self.$category.id = try category.requireID()
    }

}