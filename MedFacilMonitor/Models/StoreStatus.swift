import SwiftUI
enum StoreStatus: String, CaseIterable, Identifiable {
    case all, active, warning, offline
    var id: String { rawValue }
    var title: String {
        switch self { case .all: return "Todas"; case .active: return "Ativas"; case .warning: return "Atenção"; case .offline: return "Offline" }
    }
    var badgeTitle: String {
        switch self { case .all: return "TODAS"; case .active: return "ATIVO"; case .warning: return "ATENÇÃO"; case .offline: return "OFFLINE" }
    }
    var icon: String {
        switch self { case .all: return "square.grid.2x2.fill"; case .active: return "checkmark.circle.fill"; case .warning: return "exclamationmark.triangle.fill"; case .offline: return "wifi.slash" }
    }
    var color: Color {
        switch self { case .all: return AppTheme.accent; case .active: return AppTheme.success; case .warning: return AppTheme.warning; case .offline: return AppTheme.danger }
    }
}
