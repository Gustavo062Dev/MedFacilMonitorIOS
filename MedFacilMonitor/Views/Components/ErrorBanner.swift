import SwiftUI
struct ErrorBanner: View {
 let message:String; let retryAction:()->Void
 var body: some View { HStack{Image(systemName:"wifi.exclamationmark").foregroundStyle(AppTheme.danger);Text(message).font(.caption).foregroundStyle(.white);Spacer();Button("Tentar novamente",action:retryAction).font(.caption.bold()).foregroundStyle(AppTheme.danger)}.padding(14).background(AppTheme.danger.opacity(0.13),in:RoundedRectangle(cornerRadius:14)) }
}
