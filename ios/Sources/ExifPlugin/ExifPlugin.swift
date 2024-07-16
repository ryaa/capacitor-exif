import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(ExifPlugin)
public class ExifPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "ExifPlugin"
    public let jsName = "Exif"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "echo", returnType: CAPPluginReturnPromise)
    ]
    private let implementation = Exif()

    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }

    @objc func setCoordinates(_ call: CAPPluginCall) {

        let pathToImage = call.getString("pathToImage")
        let latitude = call.getInt("latitude")
        let longitude = call.getInt("longitude")

        guard pathToImage else {
            call.reject("pathToImage is required")
            return
        }
        guard latitude else {
            call.reject("latitude is required")
            return
        }
        guard longitude else {
            call.reject("longitude is required")
            return
        }

        implementation.setCoordinates(pathToImage, latitude, longitude)

        call.resolve()

    }

}
