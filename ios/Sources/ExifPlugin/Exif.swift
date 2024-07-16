import Foundation

@objc public class Exif: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }

    @objc public func setCoordinates(_ pathToImage: String, _ latitude: Double, _ longitude: Double) -> void {
        print(pathToImage)
        print(latitude)
        print(longitude)
    }

}
