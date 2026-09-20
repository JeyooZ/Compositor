import SwiftUI
import AppKit

enum CommunityAbout {
    static let projectURL = URL(string: "https://github.com/JeyooZ/Compositor-CN")!
    static let issuesURL = URL(string: "https://github.com/JeyooZ/Compositor-CN/issues")!
    static let weChat = "dlzzxp"
    private static var window: NSWindow?

    static func show() {
        if let window { window.makeKeyAndOrderFront(nil); return }
        let panel = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 440, height: 400),
                             styleMask: [.titled, .closable], backing: .buffered, defer: false)
        panel.title = L10n.string("About Compositor CN")
        panel.isReleasedWhenClosed = false
        panel.contentViewController = NSHostingController(rootView: CommunityAboutView())
        panel.center()
        window = panel
        panel.makeKeyAndOrderFront(nil)
    }
}

private struct CommunityAboutView: View {
    @State private var copied = false
    var body: some View {
        VStack(spacing: 16) {
            Image(nsImage: NSApp.applicationIconImage).resizable().frame(width: 64, height: 64)
            VStack(spacing: 4) {
                Text(L10n.string("Compositor CN")).font(.title2.bold())
                Text(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "")
                    .font(.caption).foregroundStyle(.secondary)
            }
            Text(L10n.string("Chinese localization and maintenance: 站长小庞"))
            HStack(spacing: 12) {
                Text(L10n.string("WeChat: dlzzxp")).textSelection(.enabled)
                Button(L10n.string(copied ? "Copied" : "Copy WeChat ID")) {
                    NSPasteboard.general.clearContents()
                    copied = NSPasteboard.general.setString(CommunityAbout.weChat, forType: .string)
                }.accessibilityIdentifier("copyWeChat")
            }
            HStack(spacing: 16) {
                Link(L10n.string("Project website"), destination: CommunityAbout.projectURL)
                Link(L10n.string("Report an issue"), destination: CommunityAbout.issuesURL)
            }
            Divider()
            VStack(spacing: 4) {
                Text("Based on robbietilton/Compositor")
                Text("© 2026 Wonder Assembly LLC · MIT")
                Text(L10n.string("Localization contributors: Chuangqi Li, Penny777btc"))
                Text(L10n.string("Community edition · Unofficial"))
            }.font(.caption).foregroundStyle(.secondary)
        }
        .padding(24).frame(width: 440)
    }
}
