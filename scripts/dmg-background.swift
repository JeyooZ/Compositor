import AppKit
let image = NSImage(size: NSSize(width: 640, height: 440))
image.lockFocus()
NSColor(calibratedWhite: 0.96, alpha: 1).setFill()
NSRect(x: 0, y: 0, width: 640, height: 440).fill()
func text(_ value: String, y: CGFloat, size: CGFloat, color: NSColor) {
    let style = NSMutableParagraphStyle()
    style.alignment = .center
    (value as NSString).draw(in: NSRect(x: 20, y: y, width: 600, height: 40), withAttributes: [
        .font: NSFont.systemFont(ofSize: size, weight: .medium), .foregroundColor: color, .paragraphStyle: style])
}
text("Compositor 中文版", y: 345, size: 28, color: .black)
text("站长小庞维护", y: 310, size: 16, color: .darkGray)
text("→", y: 205, size: 36, color: .gray)
image.unlockFocus()
let bitmap = NSBitmapImageRep(data: image.tiffRepresentation!)!
try bitmap.representation(using: .png, properties: [:])!.write(to: URL(fileURLWithPath: CommandLine.arguments[1]))
