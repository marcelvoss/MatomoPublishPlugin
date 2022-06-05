# MatomoPublishPlugin

MatomoPublishPlugin is a tiny Swift package that provides a way of injecting Matomo (previously Piwik) HTML tracking code into any generation pipeline of the [Publish](https://github.com/JohnSundell/Publish) static-site generator.

This does not use any JavaScript and keeps your site static by only injecting an image-based tracking beacon. It is less evil than JavaScript and collects less information about any users of your website.

## Installation

To install it into your Publish package, add it as a dependency within your Package.swift manifest:

```swift
let package = Package(
    ...
    dependencies: [
        ...
        .package(name: "MatomoPublishPlugin", url: "https://github.com/marcelvoss/MatomoPublishPlugin", from: "0.1.0")
    ],
    targets: [
        .target(
            ...
            dependencies: [
                ...
                "MatomoPublishPlugin"
            ]
        )
    ]
    ...
)
```

Then import SplashPublishPlugin wherever you’d like to use it:

```swift
import MatomoPublishPlugin
```

## Usage
The plugin can then be used within any publishing pipeline like this:

```swift
import SplashPublishPlugin
...
try DeliciousRecipes().publish(using: [
    .generateHTML(withTheme: .theme),
    .installPlugin(.track(using: .init(siteIdentifier: your-site-identifier,
                                                       trackingInstallationURL: URL(string: "https://your-matomo-installation.com")!))),
    ...
])
```

Just keep in mind to install the plugin **after your generateHTML step**, as it modifies the previously generated HTML files. 
