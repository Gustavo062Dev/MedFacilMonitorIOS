import Foundation

enum Formatters {
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.numberStyle = .decimal
        return formatter
    }()

    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()

    static func number(_ value: Int) -> String {
        numberFormatter.string(
            from: NSNumber(value: value)
        ) ?? String(value)
    }

    static func relativeDate(_ date: Date?) -> String {
        guard let date else {
            return "Sem comunicação"
        }

        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.unitsStyle = .full

        return formatter.localizedString(
            for: date,
            relativeTo: Date()
        )
    }
}