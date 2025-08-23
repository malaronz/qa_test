import Foundation
import AppMetricaCore

final class AnalyticsService {

    // MARK: - Static Properties

    private static let apiKey = "0444306b-af7e-4cf5-8f60-017a7ee77523"
    private static var reporter: AppMetricaReporting?

    // MARK: - Initialization

    static func initialize() {
        guard let configuration = AppMetricaConfiguration(apiKey: apiKey) else {
            print("[AnalyticsService] ❌ Failed to create AppMetricaConfiguration")
            return
        }

        configuration.sessionsAutoTracking = false

        configuration.sessionTimeout = 15

        AppMetrica.activate(with: configuration)

        guard let reporter = AppMetrica.reporter(for: apiKey) else {
            print("[AnalyticsService] ❌ Failed to create reporter")
            return
        }

        self.reporter = reporter
        print("[AnalyticsService] ✅ Initialized with manual session control")
    }

    // MARK: - Session Control

    static func startSession() {
        reporter?.resumeSession()
        print("[AnalyticsService] ▶️ Session started")
    }

    static func pauseSession() {
        reporter?.pauseSession()
        print("[AnalyticsService] ⏸ Session paused")
    }

    // MARK: - Reporting

    static func reportEvent(
        name: String,
        screen: String? = nil,
        item: String? = nil,
        additionalParams: [AnyHashable: Any] = [:]
    ) {
        var params: [AnyHashable: Any] = additionalParams
        if let screen = screen { params["screen"] = screen }
        if let item = item { params["item"] = item }

        reporter?.reportEvent(name: name, parameters: params, onFailure: { error in
            print("[AnalyticsService] ❌ Failed to report '\(name)': \(error.localizedDescription)")
        })

        print("[AnalyticsService] 📊 Reported '\(name)' with params: \(params)")
    }
}
