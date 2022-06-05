import Foundation
import Publish
import SwiftSoup

public extension Plugin {
    struct SiteConfiguration {
        /// Your site's assigned identifier by Matomo.
        public let siteIdentifier: Int

        /// The host of your Matomo installation.
        public let trackingInstallationURL: URL

        public init(siteIdentifier: Int, trackingInstallationURL: URL) {
            self.siteIdentifier = siteIdentifier
            self.trackingInstallationURL = trackingInstallationURL
        }

        var trackingString: String {
            #"<noscript><p><img src="\#(trackingInstallationURL.absoluteString)/matomo.php?idsite=\#(siteIdentifier)&rec=1" style="border:0" alt=""/></p></noscript>"#
        }
    }

    private enum PluginError: Error {
        case noBodyNode
    }

    static func track(using configuration: SiteConfiguration) -> Self {
        let trackingHTML = configuration.trackingString

        return Plugin(name: "MatomoPublishPlugin") { context in
            let root = try context.folder(at: "")

            let files = root.files.recursive

            for file in files where file.extension == "html" {
                let html = try file.readAsString()

                let outputSettings = OutputSettings()

                let doc = try parse(html)
                doc.outputSettings(outputSettings)

                guard let bodyElement = doc.body() else {
                    throw PluginError.noBodyNode
                }

                try bodyElement.append(trackingHTML)
                try file.write(try doc.html())

                print(file.name)
            }
        }
    }
}
