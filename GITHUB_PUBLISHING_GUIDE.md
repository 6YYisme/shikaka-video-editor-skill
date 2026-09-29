# GitHub 发布填写指南

## 新建仓库页面

打开 <https://github.com/new>，建议填写：

| GitHub 字段 | 建议内容 |
| --- | --- |
| Owner | 选择你自己的账号或食卡卡所属组织 |
| Repository name | `shikaka-video-editor-skill` |
| Description | `食卡卡 App 专属视频剪辑 Skills：运行环境检查安装、素材分析、字幕、预览、QA、正式导出与可选剪映草稿。` |
| Visibility | 先选 `Private`；确认没有内部信息后再改 `Public` |
| Add a README file | 不勾选，仓库里已经有 README |
| Add .gitignore | 选 `None`，仓库里已经有 `.gitignore` |
| Choose a license | 选 `None`，仓库里已经有 MIT `LICENSE` |

点击 **Create repository**。

## 用网页上传

1. 在新仓库中点击 **uploading an existing file**。
2. 把这个文件夹内的全部内容拖到页面中；仓库顶层应直接看到 `README.md`、`LICENSE`、`THIRD_PARTY_NOTICE.md` 和 `skills/`，不要再多套一层同名文件夹。
3. Commit message 填：`Add 食卡卡视频剪辑 skills`
4. 选择 **Commit directly to the main branch**，点击 **Commit changes**。
5. 分别打开 `skills/shikaka-video-editing-setup/SKILL.md` 和 `skills/shikaka-video-editor/SKILL.md`，确认中文和目录链接显示正常。

## 仓库 About 区域

仓库首页右侧 About 点击齿轮，填写：

- Description：与创建仓库时相同。
- Website：没有官网可留空；有食卡卡官网时再填。
- Topics：`agent-skills`、`codex`、`video-editing`、`ffmpeg`、`jianying`、`short-video`、`food-tech`

## 发布前检查

- 全仓搜索并确认没有本机用户名、盘符、绝对路径、API Key、旧产品名、客户数据或未授权音乐文件名。
- 把 README 安装命令中的 `<你的GitHub用户名>` 替换为真实用户名或组织名。
- 确认食卡卡名称、字体、图标和产品文案可以公开。
- 若准备开源，把仓库 Visibility 改为 `Public`；否则保持 `Private` 也能供团队使用。

## 安装测试

仓库上传后，在一个测试项目中运行：

```sh
npx skills add <你的GitHub用户名>/shikaka-video-editor-skill --full-depth
```

然后发起测试请求：

```text
请使用 $shikaka-video-editing-setup 只检查食卡卡视频剪辑环境，列出缺口，不要安装、上传或剪辑任何素材。
```
