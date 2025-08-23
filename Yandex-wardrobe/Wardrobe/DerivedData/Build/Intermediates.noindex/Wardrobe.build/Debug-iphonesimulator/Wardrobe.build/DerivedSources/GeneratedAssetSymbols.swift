import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 11.0, macOS 10.13, tvOS 11.0, *)
extension ColorResource {

    /// The "DeliveryInfoBlue" asset catalog color resource.
    static let deliveryInfoBlue = ColorResource(name: "DeliveryInfoBlue", bundle: resourceBundle)

    /// The "FilterOnColor" asset catalog color resource.
    static let filterOn = ColorResource(name: "FilterOnColor", bundle: resourceBundle)

    /// The "ItemBackground" asset catalog color resource.
    static let itemBackground = ColorResource(name: "ItemBackground", bundle: resourceBundle)

    /// The "ItemBought" asset catalog color resource.
    static let itemBought = ColorResource(name: "ItemBought", bundle: resourceBundle)

    /// The "LinearBlue" asset catalog color resource.
    static let linearBlue = ColorResource(name: "LinearBlue", bundle: resourceBundle)

    /// The "LinearOrange" asset catalog color resource.
    static let linearOrange = ColorResource(name: "LinearOrange", bundle: resourceBundle)

    /// The "LinearPink" asset catalog color resource.
    static let linearPink = ColorResource(name: "LinearPink", bundle: resourceBundle)

    /// The "LinearPurple" asset catalog color resource.
    static let linearPurple = ColorResource(name: "LinearPurple", bundle: resourceBundle)

    /// The "LookScreenGradientEndColor" asset catalog color resource.
    static let lookScreenGradientEnd = ColorResource(name: "LookScreenGradientEndColor", bundle: resourceBundle)

    /// The "LookScreenGradientStartColor" asset catalog color resource.
    static let lookScreenGradientStart = ColorResource(name: "LookScreenGradientStartColor", bundle: resourceBundle)

    /// The "Wardrobe Black" asset catalog color resource.
    static let wardrobeBlack = ColorResource(name: "Wardrobe Black", bundle: resourceBundle)

    /// The "Wardrobe White" asset catalog color resource.
    static let wardrobeWhite = ColorResource(name: "Wardrobe White", bundle: resourceBundle)

    /// The "checkboxOff" asset catalog color resource.
    static let checkboxOff = ColorResource(name: "checkboxOff", bundle: resourceBundle)

    /// The "checkboxOn" asset catalog color resource.
    static let checkboxOn = ColorResource(name: "checkboxOn", bundle: resourceBundle)

    /// The "chevronBackground" asset catalog color resource.
    static let chevronBackground = ColorResource(name: "chevronBackground", bundle: resourceBundle)

    /// The "lightGray" asset catalog color resource.
    static let lightGray = ColorResource(name: "lightGray", bundle: resourceBundle)

    /// The "wardrobeBackground" asset catalog color resource.
    static let wardrobeBackground = ColorResource(name: "wardrobeBackground", bundle: resourceBundle)

}

// MARK: - Image Symbols -

@available(iOS 11.0, macOS 10.7, tvOS 11.0, *)
extension ImageResource {

    /// The "AliceGPT" asset catalog image resource.
    static let aliceGPT = ImageResource(name: "AliceGPT", bundle: resourceBundle)

    /// The "ArrowLeft" asset catalog image resource.
    static let arrowLeft = ImageResource(name: "ArrowLeft", bundle: resourceBundle)

    /// The "Basket-Filled" asset catalog image resource.
    static let basketFilled = ImageResource(name: "Basket-Filled", bundle: resourceBundle)

    /// The "Bought" asset catalog image resource.
    static let bought = ImageResource(name: "Bought", bundle: resourceBundle)

    /// The "BoughtCardsImage" asset catalog image resource.
    static let boughtCards = ImageResource(name: "BoughtCardsImage", bundle: resourceBundle)

    /// The "BoughtChipsImage" asset catalog image resource.
    static let boughtChips = ImageResource(name: "BoughtChipsImage", bundle: resourceBundle)

    /// The "BoughtNavBarImage" asset catalog image resource.
    static let boughtNavBar = ImageResource(name: "BoughtNavBarImage", bundle: resourceBundle)

    /// The "Cart" asset catalog image resource.
    static let cart = ImageResource(name: "Cart", bundle: resourceBundle)

    /// The "Cashback" asset catalog image resource.
    static let cashback = ImageResource(name: "Cashback", bundle: resourceBundle)

    /// The "Chat" asset catalog image resource.
    static let chat = ImageResource(name: "Chat", bundle: resourceBundle)

    /// The "Chevron" asset catalog image resource.
    static let chevron = ImageResource(name: "Chevron", bundle: resourceBundle)

    /// The "Coin" asset catalog image resource.
    static let coin = ImageResource(name: "Coin", bundle: resourceBundle)

    /// The "Compare" asset catalog image resource.
    static let compare = ImageResource(name: "Compare", bundle: resourceBundle)

    /// The "Disclaimer2" asset catalog image resource.
    static let disclaimer2 = ImageResource(name: "Disclaimer2", bundle: resourceBundle)

    /// The "DownloadButton" asset catalog image resource.
    static let downloadButton = ImageResource(name: "DownloadButton", bundle: resourceBundle)

    /// The "Favorite" asset catalog image resource.
    static let favorite = ImageResource(name: "Favorite", bundle: resourceBundle)

    /// The "Filter" asset catalog image resource.
    static let filter = ImageResource(name: "Filter", bundle: resourceBundle)

    /// The "FittingPlaceholderPhoto" asset catalog image resource.
    static let fittingPlaceholderPhoto = ImageResource(name: "FittingPlaceholderPhoto", bundle: resourceBundle)

    /// The "Home" asset catalog image resource.
    static let home = ImageResource(name: "Home", bundle: resourceBundle)

    /// The "JacketImage" asset catalog image resource.
    static let jacket = ImageResource(name: "JacketImage", bundle: resourceBundle)

    /// The "JeansImage" asset catalog image resource.
    static let jeans = ImageResource(name: "JeansImage", bundle: resourceBundle)

    /// The "Liked" asset catalog image resource.
    static let liked = ImageResource(name: "Liked", bundle: resourceBundle)

    /// The "LookArrowLeft" asset catalog image resource.
    static let lookArrowLeft = ImageResource(name: "LookArrowLeft", bundle: resourceBundle)

    /// The "LookImageViewBack" asset catalog image resource.
    static let lookImageViewBack = ImageResource(name: "LookImageViewBack", bundle: resourceBundle)

    /// The "LookImageViewFront" asset catalog image resource.
    static let lookImageViewFront = ImageResource(name: "LookImageViewFront", bundle: resourceBundle)

    /// The "More button" asset catalog image resource.
    static let moreButton = ImageResource(name: "More button", bundle: resourceBundle)

    /// The "Orders" asset catalog image resource.
    static let orders = ImageResource(name: "Orders", bundle: resourceBundle)

    /// The "PantForMyLooks" asset catalog image resource.
    static let pantForMyLooks = ImageResource(name: "PantForMyLooks", bundle: resourceBundle)

    /// The "Pencil" asset catalog image resource.
    static let pencil = ImageResource(name: "Pencil", bundle: resourceBundle)

    /// The "PlusBadge" asset catalog image resource.
    static let plusBadge = ImageResource(name: "PlusBadge", bundle: resourceBundle)

    /// The "PlusSymbol" asset catalog image resource.
    static let plusSymbol = ImageResource(name: "PlusSymbol", bundle: resourceBundle)

    /// The "PopupImage" asset catalog image resource.
    static let popup = ImageResource(name: "PopupImage", bundle: resourceBundle)

    /// The "PrizeWheel" asset catalog image resource.
    static let prizeWheel = ImageResource(name: "PrizeWheel", bundle: resourceBundle)

    /// The "Profile" asset catalog image resource.
    static let profile = ImageResource(name: "Profile", bundle: resourceBundle)

    /// The "ProfilePhoto" asset catalog image resource.
    static let profilePhoto = ImageResource(name: "ProfilePhoto", bundle: resourceBundle)

    /// The "Promocode" asset catalog image resource.
    static let promocode = ImageResource(name: "Promocode", bundle: resourceBundle)

    /// The "Returns" asset catalog image resource.
    static let returns = ImageResource(name: "Returns", bundle: resourceBundle)

    /// The "Reviews" asset catalog image resource.
    static let reviews = ImageResource(name: "Reviews", bundle: resourceBundle)

    /// The "SelectedProfile" asset catalog image resource.
    static let selectedProfile = ImageResource(name: "SelectedProfile", bundle: resourceBundle)

    /// The "Settings" asset catalog image resource.
    static let settings = ImageResource(name: "Settings", bundle: resourceBundle)

    /// The "ShoeForMyLook" asset catalog image resource.
    static let shoeForMyLook = ImageResource(name: "ShoeForMyLook", bundle: resourceBundle)

    /// The "Shop" asset catalog image resource.
    static let shop = ImageResource(name: "Shop", bundle: resourceBundle)

    /// The "Tooltip" asset catalog image resource.
    static let tooltip = ImageResource(name: "Tooltip", bundle: resourceBundle)

    /// The "TshirtForMyLook" asset catalog image resource.
    static let tshirtForMyLook = ImageResource(name: "TshirtForMyLook", bundle: resourceBundle)

    /// The "Wardrobe" asset catalog image resource.
    static let wardrobe = ImageResource(name: "Wardrobe", bundle: resourceBundle)

    /// The "YLavka" asset catalog image resource.
    static let yLavka = ImageResource(name: "YLavka", bundle: resourceBundle)

    /// The "YLogo" asset catalog image resource.
    static let yLogo = ImageResource(name: "YLogo", bundle: resourceBundle)

    /// The "YPay" asset catalog image resource.
    static let yPay = ImageResource(name: "YPay", bundle: resourceBundle)

    /// The "YSplit" asset catalog image resource.
    static let ySplit = ImageResource(name: "YSplit", bundle: resourceBundle)

    /// The "altHeart" asset catalog image resource.
    static let altHeart = ImageResource(name: "altHeart", bundle: resourceBundle)

    /// The "bottom1" asset catalog image resource.
    static let bottom1 = ImageResource(name: "bottom1", bundle: resourceBundle)

    /// The "bottom2" asset catalog image resource.
    static let bottom2 = ImageResource(name: "bottom2", bundle: resourceBundle)

    /// The "bottom3" asset catalog image resource.
    static let bottom3 = ImageResource(name: "bottom3", bundle: resourceBundle)

    /// The "cancel" asset catalog image resource.
    static let cancel = ImageResource(name: "cancel", bundle: resourceBundle)

    /// The "disclaimer3" asset catalog image resource.
    static let disclaimer3 = ImageResource(name: "disclaimer3", bundle: resourceBundle)

    /// The "likeOff" asset catalog image resource.
    static let likeOff = ImageResource(name: "likeOff", bundle: resourceBundle)

    /// The "likeOn" asset catalog image resource.
    static let likeOn = ImageResource(name: "likeOn", bundle: resourceBundle)

    /// The "mock" asset catalog image resource.
    static let mock = ImageResource(name: "mock", bundle: resourceBundle)

    /// The "newButton" asset catalog image resource.
    static let newButton = ImageResource(name: "newButton", bundle: resourceBundle)

    /// The "shoes1" asset catalog image resource.
    static let shoes1 = ImageResource(name: "shoes1", bundle: resourceBundle)

    /// The "shoes2" asset catalog image resource.
    static let shoes2 = ImageResource(name: "shoes2", bundle: resourceBundle)

    /// The "shoes3" asset catalog image resource.
    static let shoes3 = ImageResource(name: "shoes3", bundle: resourceBundle)

    /// The "top1" asset catalog image resource.
    static let top1 = ImageResource(name: "top1", bundle: resourceBundle)

    /// The "top2" asset catalog image resource.
    static let top2 = ImageResource(name: "top2", bundle: resourceBundle)

    /// The "top3" asset catalog image resource.
    static let top3 = ImageResource(name: "top3", bundle: resourceBundle)

}

// MARK: - Color Symbol Extensions -

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    /// The "DeliveryInfoBlue" asset catalog color.
    static var deliveryInfoBlue: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .deliveryInfoBlue)
#else
        .init()
#endif
    }

    /// The "FilterOnColor" asset catalog color.
    static var filterOn: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .filterOn)
#else
        .init()
#endif
    }

    /// The "ItemBackground" asset catalog color.
    static var itemBackground: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .itemBackground)
#else
        .init()
#endif
    }

    /// The "ItemBought" asset catalog color.
    static var itemBought: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .itemBought)
#else
        .init()
#endif
    }

    /// The "LinearBlue" asset catalog color.
    static var linearBlue: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .linearBlue)
#else
        .init()
#endif
    }

    /// The "LinearOrange" asset catalog color.
    static var linearOrange: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .linearOrange)
#else
        .init()
#endif
    }

    /// The "LinearPink" asset catalog color.
    static var linearPink: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .linearPink)
#else
        .init()
#endif
    }

    /// The "LinearPurple" asset catalog color.
    static var linearPurple: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .linearPurple)
#else
        .init()
#endif
    }

    /// The "LookScreenGradientEndColor" asset catalog color.
    static var lookScreenGradientEnd: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .lookScreenGradientEnd)
#else
        .init()
#endif
    }

    /// The "LookScreenGradientStartColor" asset catalog color.
    static var lookScreenGradientStart: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .lookScreenGradientStart)
#else
        .init()
#endif
    }

    /// The "Wardrobe Black" asset catalog color.
    static var wardrobeBlack: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .wardrobeBlack)
#else
        .init()
#endif
    }

    /// The "Wardrobe White" asset catalog color.
    static var wardrobeWhite: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .wardrobeWhite)
#else
        .init()
#endif
    }

    /// The "checkboxOff" asset catalog color.
    static var checkboxOff: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .checkboxOff)
#else
        .init()
#endif
    }

    /// The "checkboxOn" asset catalog color.
    static var checkboxOn: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .checkboxOn)
#else
        .init()
#endif
    }

    /// The "chevronBackground" asset catalog color.
    static var chevronBackground: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .chevronBackground)
#else
        .init()
#endif
    }

    #warning("The \"lightGray\" color asset name resolves to a conflicting NSColor symbol \"lightGray\". Try renaming the asset.")

    /// The "wardrobeBackground" asset catalog color.
    static var wardrobeBackground: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .wardrobeBackground)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    /// The "DeliveryInfoBlue" asset catalog color.
    static var deliveryInfoBlue: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .deliveryInfoBlue)
#else
        .init()
#endif
    }

    /// The "FilterOnColor" asset catalog color.
    static var filterOn: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .filterOn)
#else
        .init()
#endif
    }

    /// The "ItemBackground" asset catalog color.
    static var itemBackground: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .itemBackground)
#else
        .init()
#endif
    }

    /// The "ItemBought" asset catalog color.
    static var itemBought: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .itemBought)
#else
        .init()
#endif
    }

    /// The "LinearBlue" asset catalog color.
    static var linearBlue: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .linearBlue)
#else
        .init()
#endif
    }

    /// The "LinearOrange" asset catalog color.
    static var linearOrange: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .linearOrange)
#else
        .init()
#endif
    }

    /// The "LinearPink" asset catalog color.
    static var linearPink: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .linearPink)
#else
        .init()
#endif
    }

    /// The "LinearPurple" asset catalog color.
    static var linearPurple: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .linearPurple)
#else
        .init()
#endif
    }

    /// The "LookScreenGradientEndColor" asset catalog color.
    static var lookScreenGradientEnd: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .lookScreenGradientEnd)
#else
        .init()
#endif
    }

    /// The "LookScreenGradientStartColor" asset catalog color.
    static var lookScreenGradientStart: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .lookScreenGradientStart)
#else
        .init()
#endif
    }

    /// The "Wardrobe Black" asset catalog color.
    static var wardrobeBlack: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .wardrobeBlack)
#else
        .init()
#endif
    }

    /// The "Wardrobe White" asset catalog color.
    static var wardrobeWhite: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .wardrobeWhite)
#else
        .init()
#endif
    }

    /// The "checkboxOff" asset catalog color.
    static var checkboxOff: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .checkboxOff)
#else
        .init()
#endif
    }

    /// The "checkboxOn" asset catalog color.
    static var checkboxOn: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .checkboxOn)
#else
        .init()
#endif
    }

    /// The "chevronBackground" asset catalog color.
    static var chevronBackground: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .chevronBackground)
#else
        .init()
#endif
    }

    #warning("The \"lightGray\" color asset name resolves to a conflicting UIColor symbol \"lightGray\". Try renaming the asset.")

    /// The "wardrobeBackground" asset catalog color.
    static var wardrobeBackground: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .wardrobeBackground)
#else
        .init()
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    /// The "DeliveryInfoBlue" asset catalog color.
    static var deliveryInfoBlue: SwiftUI.Color { .init(.deliveryInfoBlue) }

    /// The "FilterOnColor" asset catalog color.
    static var filterOn: SwiftUI.Color { .init(.filterOn) }

    /// The "ItemBackground" asset catalog color.
    static var itemBackground: SwiftUI.Color { .init(.itemBackground) }

    /// The "ItemBought" asset catalog color.
    static var itemBought: SwiftUI.Color { .init(.itemBought) }

    /// The "LinearBlue" asset catalog color.
    static var linearBlue: SwiftUI.Color { .init(.linearBlue) }

    /// The "LinearOrange" asset catalog color.
    static var linearOrange: SwiftUI.Color { .init(.linearOrange) }

    /// The "LinearPink" asset catalog color.
    static var linearPink: SwiftUI.Color { .init(.linearPink) }

    /// The "LinearPurple" asset catalog color.
    static var linearPurple: SwiftUI.Color { .init(.linearPurple) }

    /// The "LookScreenGradientEndColor" asset catalog color.
    static var lookScreenGradientEnd: SwiftUI.Color { .init(.lookScreenGradientEnd) }

    /// The "LookScreenGradientStartColor" asset catalog color.
    static var lookScreenGradientStart: SwiftUI.Color { .init(.lookScreenGradientStart) }

    /// The "Wardrobe Black" asset catalog color.
    static var wardrobeBlack: SwiftUI.Color { .init(.wardrobeBlack) }

    /// The "Wardrobe White" asset catalog color.
    static var wardrobeWhite: SwiftUI.Color { .init(.wardrobeWhite) }

    /// The "checkboxOff" asset catalog color.
    static var checkboxOff: SwiftUI.Color { .init(.checkboxOff) }

    /// The "checkboxOn" asset catalog color.
    static var checkboxOn: SwiftUI.Color { .init(.checkboxOn) }

    /// The "chevronBackground" asset catalog color.
    static var chevronBackground: SwiftUI.Color { .init(.chevronBackground) }

    /// The "lightGray" asset catalog color.
    static var lightGray: SwiftUI.Color { .init(.lightGray) }

    /// The "wardrobeBackground" asset catalog color.
    static var wardrobeBackground: SwiftUI.Color { .init(.wardrobeBackground) }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    /// The "DeliveryInfoBlue" asset catalog color.
    static var deliveryInfoBlue: SwiftUI.Color { .init(.deliveryInfoBlue) }

    /// The "FilterOnColor" asset catalog color.
    static var filterOn: SwiftUI.Color { .init(.filterOn) }

    /// The "ItemBackground" asset catalog color.
    static var itemBackground: SwiftUI.Color { .init(.itemBackground) }

    /// The "ItemBought" asset catalog color.
    static var itemBought: SwiftUI.Color { .init(.itemBought) }

    /// The "LinearBlue" asset catalog color.
    static var linearBlue: SwiftUI.Color { .init(.linearBlue) }

    /// The "LinearOrange" asset catalog color.
    static var linearOrange: SwiftUI.Color { .init(.linearOrange) }

    /// The "LinearPink" asset catalog color.
    static var linearPink: SwiftUI.Color { .init(.linearPink) }

    /// The "LinearPurple" asset catalog color.
    static var linearPurple: SwiftUI.Color { .init(.linearPurple) }

    /// The "LookScreenGradientEndColor" asset catalog color.
    static var lookScreenGradientEnd: SwiftUI.Color { .init(.lookScreenGradientEnd) }

    /// The "LookScreenGradientStartColor" asset catalog color.
    static var lookScreenGradientStart: SwiftUI.Color { .init(.lookScreenGradientStart) }

    /// The "Wardrobe Black" asset catalog color.
    static var wardrobeBlack: SwiftUI.Color { .init(.wardrobeBlack) }

    /// The "Wardrobe White" asset catalog color.
    static var wardrobeWhite: SwiftUI.Color { .init(.wardrobeWhite) }

    /// The "checkboxOff" asset catalog color.
    static var checkboxOff: SwiftUI.Color { .init(.checkboxOff) }

    /// The "checkboxOn" asset catalog color.
    static var checkboxOn: SwiftUI.Color { .init(.checkboxOn) }

    /// The "chevronBackground" asset catalog color.
    static var chevronBackground: SwiftUI.Color { .init(.chevronBackground) }

    /// The "lightGray" asset catalog color.
    static var lightGray: SwiftUI.Color { .init(.lightGray) }

    /// The "wardrobeBackground" asset catalog color.
    static var wardrobeBackground: SwiftUI.Color { .init(.wardrobeBackground) }

}
#endif

// MARK: - Image Symbol Extensions -

#if canImport(AppKit)
@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    /// The "AliceGPT" asset catalog image.
    static var aliceGPT: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .aliceGPT)
#else
        .init()
#endif
    }

    /// The "ArrowLeft" asset catalog image.
    static var arrowLeft: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .arrowLeft)
#else
        .init()
#endif
    }

    /// The "Basket-Filled" asset catalog image.
    static var basketFilled: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .basketFilled)
#else
        .init()
#endif
    }

    /// The "Bought" asset catalog image.
    static var bought: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .bought)
#else
        .init()
#endif
    }

    /// The "BoughtCardsImage" asset catalog image.
    static var boughtCards: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .boughtCards)
#else
        .init()
#endif
    }

    /// The "BoughtChipsImage" asset catalog image.
    static var boughtChips: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .boughtChips)
#else
        .init()
#endif
    }

    /// The "BoughtNavBarImage" asset catalog image.
    static var boughtNavBar: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .boughtNavBar)
#else
        .init()
#endif
    }

    /// The "Cart" asset catalog image.
    static var cart: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .cart)
#else
        .init()
#endif
    }

    /// The "Cashback" asset catalog image.
    static var cashback: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .cashback)
#else
        .init()
#endif
    }

    /// The "Chat" asset catalog image.
    static var chat: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .chat)
#else
        .init()
#endif
    }

    /// The "Chevron" asset catalog image.
    static var chevron: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .chevron)
#else
        .init()
#endif
    }

    /// The "Coin" asset catalog image.
    static var coin: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .coin)
#else
        .init()
#endif
    }

    /// The "Compare" asset catalog image.
    static var compare: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .compare)
#else
        .init()
#endif
    }

    /// The "Disclaimer2" asset catalog image.
    static var disclaimer2: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .disclaimer2)
#else
        .init()
#endif
    }

    /// The "DownloadButton" asset catalog image.
    static var downloadButton: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .downloadButton)
#else
        .init()
#endif
    }

    /// The "Favorite" asset catalog image.
    static var favorite: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .favorite)
#else
        .init()
#endif
    }

    /// The "Filter" asset catalog image.
    static var filter: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .filter)
#else
        .init()
#endif
    }

    /// The "FittingPlaceholderPhoto" asset catalog image.
    static var fittingPlaceholderPhoto: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .fittingPlaceholderPhoto)
#else
        .init()
#endif
    }

    /// The "Home" asset catalog image.
    static var home: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .home)
#else
        .init()
#endif
    }

    /// The "JacketImage" asset catalog image.
    static var jacket: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .jacket)
#else
        .init()
#endif
    }

    /// The "JeansImage" asset catalog image.
    static var jeans: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .jeans)
#else
        .init()
#endif
    }

    /// The "Liked" asset catalog image.
    static var liked: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .liked)
#else
        .init()
#endif
    }

    /// The "LookArrowLeft" asset catalog image.
    static var lookArrowLeft: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .lookArrowLeft)
#else
        .init()
#endif
    }

    /// The "LookImageViewBack" asset catalog image.
    static var lookImageViewBack: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .lookImageViewBack)
#else
        .init()
#endif
    }

    /// The "LookImageViewFront" asset catalog image.
    static var lookImageViewFront: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .lookImageViewFront)
#else
        .init()
#endif
    }

    /// The "More button" asset catalog image.
    static var moreButton: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .moreButton)
#else
        .init()
#endif
    }

    /// The "Orders" asset catalog image.
    static var orders: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .orders)
#else
        .init()
#endif
    }

    /// The "PantForMyLooks" asset catalog image.
    static var pantForMyLooks: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .pantForMyLooks)
#else
        .init()
#endif
    }

    /// The "Pencil" asset catalog image.
    static var pencil: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .pencil)
#else
        .init()
#endif
    }

    /// The "PlusBadge" asset catalog image.
    static var plusBadge: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .plusBadge)
#else
        .init()
#endif
    }

    /// The "PlusSymbol" asset catalog image.
    static var plusSymbol: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .plusSymbol)
#else
        .init()
#endif
    }

    /// The "PopupImage" asset catalog image.
    static var popup: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .popup)
#else
        .init()
#endif
    }

    /// The "PrizeWheel" asset catalog image.
    static var prizeWheel: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .prizeWheel)
#else
        .init()
#endif
    }

    /// The "Profile" asset catalog image.
    static var profile: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .profile)
#else
        .init()
#endif
    }

    /// The "ProfilePhoto" asset catalog image.
    static var profilePhoto: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .profilePhoto)
#else
        .init()
#endif
    }

    /// The "Promocode" asset catalog image.
    static var promocode: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .promocode)
#else
        .init()
#endif
    }

    /// The "Returns" asset catalog image.
    static var returns: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .returns)
#else
        .init()
#endif
    }

    /// The "Reviews" asset catalog image.
    static var reviews: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .reviews)
#else
        .init()
#endif
    }

    /// The "SelectedProfile" asset catalog image.
    static var selectedProfile: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .selectedProfile)
#else
        .init()
#endif
    }

    /// The "Settings" asset catalog image.
    static var settings: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .settings)
#else
        .init()
#endif
    }

    /// The "ShoeForMyLook" asset catalog image.
    static var shoeForMyLook: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .shoeForMyLook)
#else
        .init()
#endif
    }

    /// The "Shop" asset catalog image.
    static var shop: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .shop)
#else
        .init()
#endif
    }

    /// The "Tooltip" asset catalog image.
    static var tooltip: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .tooltip)
#else
        .init()
#endif
    }

    /// The "TshirtForMyLook" asset catalog image.
    static var tshirtForMyLook: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .tshirtForMyLook)
#else
        .init()
#endif
    }

    /// The "Wardrobe" asset catalog image.
    static var wardrobe: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .wardrobe)
#else
        .init()
#endif
    }

    /// The "YLavka" asset catalog image.
    static var yLavka: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .yLavka)
#else
        .init()
#endif
    }

    /// The "YLogo" asset catalog image.
    static var yLogo: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .yLogo)
#else
        .init()
#endif
    }

    /// The "YPay" asset catalog image.
    static var yPay: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .yPay)
#else
        .init()
#endif
    }

    /// The "YSplit" asset catalog image.
    static var ySplit: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .ySplit)
#else
        .init()
#endif
    }

    /// The "altHeart" asset catalog image.
    static var altHeart: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .altHeart)
#else
        .init()
#endif
    }

    /// The "bottom1" asset catalog image.
    static var bottom1: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .bottom1)
#else
        .init()
#endif
    }

    /// The "bottom2" asset catalog image.
    static var bottom2: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .bottom2)
#else
        .init()
#endif
    }

    /// The "bottom3" asset catalog image.
    static var bottom3: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .bottom3)
#else
        .init()
#endif
    }

    /// The "cancel" asset catalog image.
    static var cancel: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .cancel)
#else
        .init()
#endif
    }

    /// The "disclaimer3" asset catalog image.
    static var disclaimer3: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .disclaimer3)
#else
        .init()
#endif
    }

    /// The "likeOff" asset catalog image.
    static var likeOff: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .likeOff)
#else
        .init()
#endif
    }

    /// The "likeOn" asset catalog image.
    static var likeOn: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .likeOn)
#else
        .init()
#endif
    }

    /// The "mock" asset catalog image.
    static var mock: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .mock)
#else
        .init()
#endif
    }

    /// The "newButton" asset catalog image.
    static var newButton: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .newButton)
#else
        .init()
#endif
    }

    /// The "shoes1" asset catalog image.
    static var shoes1: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .shoes1)
#else
        .init()
#endif
    }

    /// The "shoes2" asset catalog image.
    static var shoes2: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .shoes2)
#else
        .init()
#endif
    }

    /// The "shoes3" asset catalog image.
    static var shoes3: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .shoes3)
#else
        .init()
#endif
    }

    /// The "top1" asset catalog image.
    static var top1: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .top1)
#else
        .init()
#endif
    }

    /// The "top2" asset catalog image.
    static var top2: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .top2)
#else
        .init()
#endif
    }

    /// The "top3" asset catalog image.
    static var top3: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .top3)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// The "AliceGPT" asset catalog image.
    static var aliceGPT: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .aliceGPT)
#else
        .init()
#endif
    }

    /// The "ArrowLeft" asset catalog image.
    static var arrowLeft: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .arrowLeft)
#else
        .init()
#endif
    }

    /// The "Basket-Filled" asset catalog image.
    static var basketFilled: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .basketFilled)
#else
        .init()
#endif
    }

    /// The "Bought" asset catalog image.
    static var bought: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .bought)
#else
        .init()
#endif
    }

    /// The "BoughtCardsImage" asset catalog image.
    static var boughtCards: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .boughtCards)
#else
        .init()
#endif
    }

    /// The "BoughtChipsImage" asset catalog image.
    static var boughtChips: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .boughtChips)
#else
        .init()
#endif
    }

    /// The "BoughtNavBarImage" asset catalog image.
    static var boughtNavBar: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .boughtNavBar)
#else
        .init()
#endif
    }

    /// The "Cart" asset catalog image.
    static var cart: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .cart)
#else
        .init()
#endif
    }

    /// The "Cashback" asset catalog image.
    static var cashback: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .cashback)
#else
        .init()
#endif
    }

    /// The "Chat" asset catalog image.
    static var chat: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .chat)
#else
        .init()
#endif
    }

    /// The "Chevron" asset catalog image.
    static var chevron: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .chevron)
#else
        .init()
#endif
    }

    /// The "Coin" asset catalog image.
    static var coin: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .coin)
#else
        .init()
#endif
    }

    /// The "Compare" asset catalog image.
    static var compare: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .compare)
#else
        .init()
#endif
    }

    /// The "Disclaimer2" asset catalog image.
    static var disclaimer2: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .disclaimer2)
#else
        .init()
#endif
    }

    /// The "DownloadButton" asset catalog image.
    static var downloadButton: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .downloadButton)
#else
        .init()
#endif
    }

    /// The "Favorite" asset catalog image.
    static var favorite: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .favorite)
#else
        .init()
#endif
    }

    /// The "Filter" asset catalog image.
    static var filter: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .filter)
#else
        .init()
#endif
    }

    /// The "FittingPlaceholderPhoto" asset catalog image.
    static var fittingPlaceholderPhoto: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .fittingPlaceholderPhoto)
#else
        .init()
#endif
    }

    /// The "Home" asset catalog image.
    static var home: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .home)
#else
        .init()
#endif
    }

    /// The "JacketImage" asset catalog image.
    static var jacket: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .jacket)
#else
        .init()
#endif
    }

    /// The "JeansImage" asset catalog image.
    static var jeans: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .jeans)
#else
        .init()
#endif
    }

    /// The "Liked" asset catalog image.
    static var liked: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .liked)
#else
        .init()
#endif
    }

    /// The "LookArrowLeft" asset catalog image.
    static var lookArrowLeft: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .lookArrowLeft)
#else
        .init()
#endif
    }

    /// The "LookImageViewBack" asset catalog image.
    static var lookImageViewBack: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .lookImageViewBack)
#else
        .init()
#endif
    }

    /// The "LookImageViewFront" asset catalog image.
    static var lookImageViewFront: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .lookImageViewFront)
#else
        .init()
#endif
    }

    /// The "More button" asset catalog image.
    static var moreButton: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .moreButton)
#else
        .init()
#endif
    }

    /// The "Orders" asset catalog image.
    static var orders: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .orders)
#else
        .init()
#endif
    }

    /// The "PantForMyLooks" asset catalog image.
    static var pantForMyLooks: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .pantForMyLooks)
#else
        .init()
#endif
    }

    /// The "Pencil" asset catalog image.
    static var pencil: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .pencil)
#else
        .init()
#endif
    }

    /// The "PlusBadge" asset catalog image.
    static var plusBadge: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .plusBadge)
#else
        .init()
#endif
    }

    /// The "PlusSymbol" asset catalog image.
    static var plusSymbol: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .plusSymbol)
#else
        .init()
#endif
    }

    /// The "PopupImage" asset catalog image.
    static var popup: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .popup)
#else
        .init()
#endif
    }

    /// The "PrizeWheel" asset catalog image.
    static var prizeWheel: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .prizeWheel)
#else
        .init()
#endif
    }

    /// The "Profile" asset catalog image.
    static var profile: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .profile)
#else
        .init()
#endif
    }

    /// The "ProfilePhoto" asset catalog image.
    static var profilePhoto: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .profilePhoto)
#else
        .init()
#endif
    }

    /// The "Promocode" asset catalog image.
    static var promocode: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .promocode)
#else
        .init()
#endif
    }

    /// The "Returns" asset catalog image.
    static var returns: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .returns)
#else
        .init()
#endif
    }

    /// The "Reviews" asset catalog image.
    static var reviews: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .reviews)
#else
        .init()
#endif
    }

    /// The "SelectedProfile" asset catalog image.
    static var selectedProfile: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .selectedProfile)
#else
        .init()
#endif
    }

    /// The "Settings" asset catalog image.
    static var settings: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .settings)
#else
        .init()
#endif
    }

    /// The "ShoeForMyLook" asset catalog image.
    static var shoeForMyLook: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .shoeForMyLook)
#else
        .init()
#endif
    }

    /// The "Shop" asset catalog image.
    static var shop: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .shop)
#else
        .init()
#endif
    }

    /// The "Tooltip" asset catalog image.
    static var tooltip: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .tooltip)
#else
        .init()
#endif
    }

    /// The "TshirtForMyLook" asset catalog image.
    static var tshirtForMyLook: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .tshirtForMyLook)
#else
        .init()
#endif
    }

    /// The "Wardrobe" asset catalog image.
    static var wardrobe: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .wardrobe)
#else
        .init()
#endif
    }

    /// The "YLavka" asset catalog image.
    static var yLavka: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .yLavka)
#else
        .init()
#endif
    }

    /// The "YLogo" asset catalog image.
    static var yLogo: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .yLogo)
#else
        .init()
#endif
    }

    /// The "YPay" asset catalog image.
    static var yPay: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .yPay)
#else
        .init()
#endif
    }

    /// The "YSplit" asset catalog image.
    static var ySplit: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .ySplit)
#else
        .init()
#endif
    }

    /// The "altHeart" asset catalog image.
    static var altHeart: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .altHeart)
#else
        .init()
#endif
    }

    /// The "bottom1" asset catalog image.
    static var bottom1: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .bottom1)
#else
        .init()
#endif
    }

    /// The "bottom2" asset catalog image.
    static var bottom2: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .bottom2)
#else
        .init()
#endif
    }

    /// The "bottom3" asset catalog image.
    static var bottom3: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .bottom3)
#else
        .init()
#endif
    }

    /// The "cancel" asset catalog image.
    static var cancel: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .cancel)
#else
        .init()
#endif
    }

    /// The "disclaimer3" asset catalog image.
    static var disclaimer3: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .disclaimer3)
#else
        .init()
#endif
    }

    /// The "likeOff" asset catalog image.
    static var likeOff: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .likeOff)
#else
        .init()
#endif
    }

    /// The "likeOn" asset catalog image.
    static var likeOn: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .likeOn)
#else
        .init()
#endif
    }

    /// The "mock" asset catalog image.
    static var mock: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .mock)
#else
        .init()
#endif
    }

    /// The "newButton" asset catalog image.
    static var newButton: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .newButton)
#else
        .init()
#endif
    }

    /// The "shoes1" asset catalog image.
    static var shoes1: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .shoes1)
#else
        .init()
#endif
    }

    /// The "shoes2" asset catalog image.
    static var shoes2: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .shoes2)
#else
        .init()
#endif
    }

    /// The "shoes3" asset catalog image.
    static var shoes3: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .shoes3)
#else
        .init()
#endif
    }

    /// The "top1" asset catalog image.
    static var top1: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .top1)
#else
        .init()
#endif
    }

    /// The "top2" asset catalog image.
    static var top2: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .top2)
#else
        .init()
#endif
    }

    /// The "top3" asset catalog image.
    static var top3: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .top3)
#else
        .init()
#endif
    }

}
#endif

// MARK: - Thinnable Asset Support -

@available(iOS 11.0, macOS 10.13, tvOS 11.0, *)
@available(watchOS, unavailable)
extension ColorResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if AppKit.NSColor(named: NSColor.Name(thinnableName), bundle: bundle) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIColor(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    private convenience init?(thinnableResource: ColorResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    private convenience init?(thinnableResource: ColorResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    private init?(thinnableResource: ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    private init?(thinnableResource: ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}
#endif

@available(iOS 11.0, macOS 10.7, tvOS 11.0, *)
@available(watchOS, unavailable)
extension ImageResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if bundle.image(forResource: NSImage.Name(thinnableName)) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIImage(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    private convenience init?(thinnableResource: ImageResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    private convenience init?(thinnableResource: ImageResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

// MARK: - Backwards Deployment Support -

/// A color resource.
struct ColorResource: Swift.Hashable, Swift.Sendable {

    /// An asset catalog color resource name.
    fileprivate let name: Swift.String

    /// An asset catalog color resource bundle.
    fileprivate let bundle: Foundation.Bundle

    /// Initialize a `ColorResource` with `name` and `bundle`.
    init(name: Swift.String, bundle: Foundation.Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

/// An image resource.
struct ImageResource: Swift.Hashable, Swift.Sendable {

    /// An asset catalog image resource name.
    fileprivate let name: Swift.String

    /// An asset catalog image resource bundle.
    fileprivate let bundle: Foundation.Bundle

    /// Initialize an `ImageResource` with `name` and `bundle`.
    init(name: Swift.String, bundle: Foundation.Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    /// Initialize a `NSColor` with a color resource.
    convenience init(resource: ColorResource) {
        self.init(named: NSColor.Name(resource.name), bundle: resource.bundle)!
    }

}

protocol _ACResourceInitProtocol {}
extension AppKit.NSImage: _ACResourceInitProtocol {}

@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension _ACResourceInitProtocol {

    /// Initialize a `NSImage` with an image resource.
    init(resource: ImageResource) {
        self = resource.bundle.image(forResource: NSImage.Name(resource.name))! as! Self
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    /// Initialize a `UIColor` with a color resource.
    convenience init(resource: ColorResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}

@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// Initialize a `UIImage` with an image resource.
    convenience init(resource: ImageResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    /// Initialize a `Color` with a color resource.
    init(_ resource: ColorResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Image {

    /// Initialize an `Image` with an image resource.
    init(_ resource: ImageResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}
#endif