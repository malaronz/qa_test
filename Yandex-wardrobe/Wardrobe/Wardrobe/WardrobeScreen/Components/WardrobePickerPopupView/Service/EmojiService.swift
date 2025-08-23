import Foundation

protocol EmojiProviding {
    func randomEmoji() -> String
    var defaultEmoji: String { get }
}

struct EmojiService: EmojiProviding {
    
    private let emojiPool: [String] = [
        "🐻", "🐱", "🐶", "🐼", "🦊", 
        "🐯", "🐨", "🦁", "🐷", "🐰"
    ]
    
    var defaultEmoji: String {
        "🙂"
    }
    
    func randomEmoji() -> String {
        emojiPool.randomElement() ?? defaultEmoji
    }
}
