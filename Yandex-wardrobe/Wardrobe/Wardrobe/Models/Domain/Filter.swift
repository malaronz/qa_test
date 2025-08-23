import Foundation

struct Filter {
    let top: ItemFilter?
    let bottom: ItemFilter?
    let shoes: ItemFilter?
    let all: ItemFilter?
    let look: LookFilter?
}

struct ItemFilter {
    var types: [ClothesType]
    var subtypes: [ClothesSubtype]
    var variants: Option
}

struct LookFilter {
    var season: [String]
    var style: [String]
    var reason: [String]
}

struct Option {
    var size: [String]
    var color: [String]
    var gender: [String]
}
