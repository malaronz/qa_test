import UIKit

protocol ImageProcessingService {
    func process(image: UIImage, clothingURLs: [String]?) async throws -> UIImage
}

struct ImageProcessingServiceImpl: ImageProcessingService {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    func process(image: UIImage, clothingURLs: [String]?) async throws -> UIImage {
        if let clothingURLs = clothingURLs, !clothingURLs.isEmpty {
            return try await performVirtualTryOn(image: image, clothingURLs: clothingURLs)
        }
        
        return image
    }
    
    private func performVirtualTryOn(image: UIImage, clothingURLs: [String]) async throws -> UIImage {
        guard clothingURLs.count >= 3 else {
            throw ImageProcessingError.insufficientClothingItems
        }
        
        guard let imageData = image.jpegData(compressionQuality: 0.9) else {
            throw ImageProcessingError.imageConversionFailed
        }
        
        let base64String = imageData.base64EncodedString(options: [])
        
        let topURL = clothingURLs.indices.contains(0) ? clothingURLs[0] : ""
        let bottomURL = clothingURLs.indices.contains(1) ? clothingURLs[1] : ""
        let shoesURL = clothingURLs.indices.contains(2) ? clothingURLs[2] : ""
        
        let request = VirtualTryOnRequest(
            person: base64String,
            top: topURL,
            bottom: bottomURL,
            shoes: shoesURL
        )
        
        print("   📏 Image size: \(imageData.count) bytes")
        print("   📊 Base64 length: \(base64String.count)")
        print("   👕 Top: \(topURL)")
        print("   👖 Bottom: \(bottomURL)")
        print("   👟 Shoes: \(shoesURL)")
        
        let url = URL(string: "\(Constants.baseUrl)/virtual-try-on")!
        let resultImageURL: String = try await networkClient.request(
            url: url,
            method: .post,
            requestBody: request,
            responseType: String.self
        )
        
        print("📥 Received result URL: \(resultImageURL)")
        
        guard let imageURL = URL(string: resultImageURL) else {
            print("❌ Invalid result URL: \(resultImageURL)")
            throw ImageProcessingError.invalidResultURL
        }
        
        print("🔗 Loading image from: \(imageURL)")
        let (resultImageData, _) = try await URLSession.shared.data(from: imageURL)
        
        guard let resultImage = UIImage(data: resultImageData) else {
            print("❌ Failed to create image from data: \(resultImageData.count) bytes")
            throw ImageProcessingError.resultImageDownloadFailed
        }
        
        print("✅ Successfully loaded result image: \(resultImageData.count) bytes")
        return resultImage
    }
}
