# Compositor 社区中文版

基于 [robbietilton/Compositor](https://github.com/robbietilton/Compositor) 的社区中文项目，面向中文用户提供原生 macOS 图像编辑体验。本项目为独立社区 fork，不代表原作者或官方发行版。

## 当前进度

已整合简体中文界面和英文回退，包含 562 条界面资源及 3 条文件类型名称。尚未发布签名、公证的中文安装包。

以 Chuangqi Li 的 [PR #29](https://github.com/robbietilton/Compositor/pull/29) 为基础，保留原作者提交署名；参考 Penny777btc 的 [PR #21](https://github.com/robbietilton/Compositor/pull/21) 整理工具提示逻辑，并补充 Finder 文件类型翻译。

中文系统下自动使用简体中文；也可在 macOS「系统设置 → 通用 → 语言与地区 → 应用程序」中为 Compositor 选择简体中文或英文，退出并重新打开应用后生效。

构建与回归验证见 [GitHub Actions](https://github.com/JeyooZ/Compositor/actions/workflows/localization.yml)。

## 运行与开发

- 原生 Mac 应用，目前没有 Windows 或网页版本。
- 当前工程最低系统版本为 macOS 26.5，构建需要支持该目标的 Xcode 与 macOS SDK。
- 使用 Xcode 打开 `Compositor.xcodeproj`，选择 `Compositor` scheme 构建。

## 体验版发布前

- [x] 审查并整合简体中文资源，保留英文回退。
- [ ] 校对菜单、工具、对话框和动态文案，检查中文布局。
- [ ] 验证打开、编辑、保存、导出等核心操作。
- [x] 配置独立应用标识并停用官方自动更新，避免覆盖社区版。
- [ ] 使用社区维护者自己的签名和公证配置制作安装包。

社区版应用标识为 `io.github.jeyooz.compositor`，暂不提供自动更新。上游签名、公证发布脚本仍需配置维护者自己的证书，不能直接作为社区正式发行配置使用。

## 许可与致谢

原项目由 Wonder Assembly LLC 开源，采用 [MIT 许可证](LICENSE)。本项目保留原版权及许可声明，并会保留所采用社区贡献的提交历史与署名。

---

以下为上游英文说明。

# Compositor

Adobe Photoshop costs too much and tools like GIMP don’t feel familiar enough for me to stay in flow. That’s why I built Compositor.

The goal was to create a full-featured image editor that is completely free and open source. I use Photoshop for compositing and post-processing, so Compositor is built around that workflow - with the tools needed to create a pixel-perfect final image.

Because it’s open source, you can download the Xcode project and add, remove, or modify any feature to fit your workflow.

## Features

### Layers
- Layers and folders, with blend modes and opacity
- Layer masks: paint, fill, invert, blur and feather them; link or unlink them to transform a mask on its own
- Clipping masks and folder masks
- Adjustment layers: Hue/Saturation, Levels, Curves, Exposure, Gradient Map and Grain
- Merge Down, Merge Layers and Merge Group (⌘E)
- Duplicate, rename inline, reorder and nest by drag and drop; Option-drag to duplicate
- Drag layers between open projects

### Transform
- Non-destructive move, scale, rotate and flip — images keep their full resolution however small you make them
- Free distort (⌘-drag a handle), with Shift to lock to an axis
- Transform several layers, or a whole folder, together
- Snapping to canvas and layer edges and centers, with guides
- Exact values for position, size, scale and angle, stepped with the arrow keys
- Flip Layer and Flip Canvas, horizontal and vertical

### Selections
- Rectangle and Ellipse Marquee, Freehand and Polygonal Lasso, and Magic Wand
- Add to and subtract from selections, move the outline, or move and duplicate the pixels inside
- Load a layer's pixels or a mask as a selection
- Content-Aware Fill, which can also extend an image past its edges

### Painting and retouching
- Brush with size, hardness and opacity, and Shift for straight lines
- Spot Healing Brush (content-aware)
- Clone Stamp, aligned or not, sampling one layer or all of them
- Blur tool, on pixels or masks
- Gradient tool and Shape tool (rectangles, rounded rectangles and ellipses)
- Eyedropper and a full color picker

### Adjustments and filters
- Levels (with Auto), Curves, Hue/Saturation, Exposure, Gradient Map, Grain and Invert
- Gaussian Blur and Motion Blur that spread past a layer's edges
- Add Noise, Lens Correction and Remove Background
- Live previews, limited to the selection when there is one

### Canvas and files
- Multiple projects in tabs
- Crop with snapping, and Option for symmetric cropping
- Canvas Size and Image Size
- Sharp high-quality downsampling when zoomed out, and a pixel grid when zoomed in
- Import JPEG, PNG, HEIC and TIFF — including dropped screenshots and images from other apps
- Export JPEG with a live preview (⇧⌥⌘S); Copy Merged
- Photoshop-style keyboard shortcuts throughout

## Requirements

- macOS 26
- Xcode 26 (to build from source)

## Languages

Compositor supports English and Simplified Chinese. It follows the macOS preferred language, including a per-app language selected in System Settings → General → Language & Region. Relaunch the app after changing its language.

Translations live in `Compositor/en.lproj/Localizable.strings` and `Compositor/zh-Hans.lproj/Localizable.strings`. Keep English lookup keys and positional format arguments in sync. Translate display labels only; persisted enum values, picker selections, and accessibility identifiers must stay language-independent.

## Building

Open `Compositor.xcodeproj` and run the **Compositor** scheme.

## Releasing

`scripts/release.sh` builds a Release version, signs it with Developer ID, notarizes and staples it, and packages it into `dist/Compositor-<version>.dmg`.

It needs, all kept outside this repository:

- a **Developer ID Application** certificate in the login keychain
- notarization credentials saved with `xcrun notarytool store-credentials "compositor-notary" …`
- [`create-dmg`](https://github.com/create-dmg/create-dmg) (`brew install create-dmg`)

## License

MIT — see [LICENSE](LICENSE).
