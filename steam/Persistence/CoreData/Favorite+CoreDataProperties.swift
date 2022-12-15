import Foundation
import CoreData

extension Favorite {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: Constants.name)
    }

    @NSManaged public var id: Int
    @NSManaged public var name: String
    @NSManaged public var isDiscount: Bool
    @NSManaged public var price: String
    @NSManaged public var discount: Int
    @NSManaged public var isFree: Bool
    @NSManaged public var finalPrice: Int
}

extension Favorite {
    struct Constants {
        static let name = "Favorite"
    }
}
