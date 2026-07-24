import SwiftUI
struct SummaryCard: View {
 let title:String; let value:Int; let icon:String; let color:Color
 var body: some View { HStack(spacing:12){ ZStack{RoundedRectangle(cornerRadius:12).fill(color.opacity(0.18)); Image(systemName:icon).foregroundStyle(color)}.frame(width:46,height:46); VStack(alignment:.leading){Text(Formatters.number(value)).font(.title2.bold()).foregroundStyle(.white); Text(title).font(.caption).foregroundStyle(AppTheme.textSecondary)}; Spacer() }.padding(14).background(AppTheme.surface,in:RoundedRectangle(cornerRadius:16)).overlay{RoundedRectangle(cornerRadius:16).stroke(AppTheme.border)} }
}
