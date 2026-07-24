import Foundation
enum Formatters {
    static let numberFormatter: NumberFormatter = { let f=NumberFormatter(); f.locale=Locale(identifier:"pt_BR"); f.numberStyle=.decimal; return f }()
    static let timeFormatter: DateFormatter = { let f=DateFormatter(); f.locale=Locale(identifier:"pt_BR"); f.dateFormat="HH:mm:ss"; return f }()
    static func number(_ value: Int) -> String { numberFormatter.string(from: NSNumber(value:value)) ?? String(value) }
    static func relativeDate(_ date: Date?) -> String {
        guard let date else { return "Sem comunicação" }
        let f=RelativeDateTimeFormatter(); f.locale=Locale(identifier:"pt_BR"); f.unitsStyle=.full
        return f.localizedString(for: date, relativeTo: Date())
    }
}
