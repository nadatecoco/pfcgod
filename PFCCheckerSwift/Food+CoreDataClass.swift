import Foundation
import CoreData

@objc(Food)
public class Food: NSManagedObject {}

extension Food: Identifiable {
    // Core DataのobjectIDをIdentifiableのidとして使用
    // または、モデルにUUID型のidプロパティがあればそれを使用
}
