import SwiftUI
struct FilterChip: View {
 let status:StoreStatus; let count:Int; let isSelected:Bool; let action:()->Void
 var body: some View { Button(action:action){HStack(spacing:7){Image(systemName:status.icon);Text(status.title).font(.subheadline.weight(.semibold));Text(Formatters.number(count)).font(.caption2.bold())}.foregroundStyle(isSelected ? Color.white : AppTheme.textSecondary).padding(.horizontal,13).padding(.vertical,9).background(isSelected ? status.color.opacity(0.30) : AppTheme.surface,in:Capsule()).overlay{Capsule().stroke(isSelected ? status.color : AppTheme.border)}}.buttonStyle(.plain) }
}
