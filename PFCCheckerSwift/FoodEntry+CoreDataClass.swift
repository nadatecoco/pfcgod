import Foundation
import CoreData

@objc(FoodEntry)
public class FoodEntry: NSManagedObject {}

extension FoodEntry: Identifiable {
    // Core DataのidプロパティをIdentifiableのidとして使用
    // idがOptionalの場合、nilを許容しないように調整するか、
    // UUID()を割り当てるロジックを考慮する必要がある
    // 現在のモデル定義ではidは非Optionalと仮定
}
