# My personal modern NeoVim config


<img src="https://i.imgur.com/MRHEtoO.png" alt="Autocomplete" width="49%"/>
<img src="https://i.imgur.com/6favuEM.png" alt="Git diff" width="49%"/><br>
<img src="https://i.imgur.com/adZiidz.png" alt="Doc preview" width="49%"/>
<img src="https://i.imgur.com/FWuzSqD.png" alt="Glance" width="49%"/><br>
<img src="https://i.imgur.com/lh8K1GW.png" alt="Floating terminal" width="49%"/><br>
<img src="https://i.imgur.com/N61fK6b.png" alt="Telescope search" width="49%"/><br>

## Note for users
You're supposed to fork this repo and work from there (as oppose to cloning it and keep fetching updates by git pulling). This is just a place I share my configs in, not a neovim distribution (like LazyVim or NvChad). I make breaking changes unannounced and if I screw you up welp I told you so.

## Setup
0. Use the latest version of NVIM
1. Clone this repo into `~/.config/nvim`:

```
git clone  https://github.com/Stephan14/nvim-config.git ~/.config/nvim
```

2. Set up LSP

This setup uses [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) which contains config for most languages servers out there. See `lua/configs/autocomplete.lua`, edit the list of LSP's in this file to languages you need, and make sure those LSP's are installed globally.

3. Set up treesitter

Config for treesitter is in `lua/configs/treesitter.lua`, edit the list of languages in this file and run `:TSUpdate`.

4. Set up snippets

Snippet files are in `snippets/` (outside the `lua/` folder!), this setup uses [LuaSnip](https://github.com/L3MON4D3/LuaSnip) for snippets.

This setup configrued LuaSnip to use snipmate-like snippet syntax, but LuaSnip also supports VSCode-like JSON snippet syntax, to change it, change `"luasnip.loaders.from_snipmate"` to `"luasnip.loaders.from_vscode"` in `lua/configs/autocomplete.lua`, for more information see [related LuaSnip docs](https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#add-snippets).

## FAQ
> Why does the theme not match the screenshots?

I switch between a few themes sometimes during my usage just to fresh things up a bit, the screenshots are quite old and might not reflect the latest theme, you can change the theme at `lua/core/theme.lua`. You can also switch between light and dark mode using the keymap `<leader>vd` (dark) and `<leader>vl` (light).

> Why are there a bunch of question marks?

They are supposed to be the fancy file and arrow icons, to use these icons you need Nerd Fonts, a special kind of font that supports these icons.

> Why does it have a bunch of error messages?

First check if you have followed the setup instructions.

If you have and error messages still exist, that's because I've been lazy and couldn't keep up with the latest breaking changes in plugins or neovim.

## Contributing
### Having troubles

Report an issue If you have issues (don't DM me on social media, report an issue here).

### Adding more things

For now, you don't, this is *my personal config*. However if there's any problem with the documentation above feel free to correct or add more details by a PR.

## 快捷键

- 插入模式下, ctrl+g 等价于esc
- 正常模式下，\\+v+l 等价于切换成白色背景
- 正常模式下，\\+v+d 等价于切换成黑色背景

### lspsaga插件
- 正常模式下，\\+e+e 等价于对当前行进行诊断提示
- 正常模式下，\\+e+f 等价于对当前光标进行诊断提示
- 正常模式下，\\+e+l 等价于对当前打开的文件进行诊断提示
- 正常模式下，\\+l+q 等价于对当前窗口代码进行诊断提示
- 正常模式下，\\+l+k 等价于展示当前函数的参数介绍
- 正常模式下，\\+l+f 等价于展示当前函数的定义
- 正常模式下，\\+l+r 等价于重命名
- 正常模式下，\\+l+f 等价于格式化

### 展示状态栏
- 正常模式下，\\+w+8 等价于展示/隐藏左侧文件目录
- 正常模式下，\\+w+9 等价于展示/隐藏右侧git信息

### 搜索操作
- 正常模式下，\\+d+f 等价于展示所有文件并进行搜索
- 正常模式下，F11 等价于展示在buffer中文件并进行搜索
- 正常模式下，ctrl+p 等价于展示在buffer中文件并进行搜索
- 正常模式下，\\+s+s 等价于在当前文件中搜索
- 正常模式下，\\+s+w 等价于在所有文件中搜索


### 窗口操作
- 正常模式下，w1等价于最小化其他窗口，最大化当前窗口
- 正常模式下，wx等价于写入文件并退出
- 正常模式下，w2等于横向分屏
- 正常模式下，w2等价于纵向分屏

- 正常模式下，m-9等价于向左调整窗口
- 正常模式下，m-0等价于向右调整窗口
- 正常模式下，m--等价于向上调整窗口
- 正常模式下，m-=等价于向下调整窗口

### 跳转操作
- 正常模式下，\\+g+d等价于跳转到定义
- 正常模式下，\\+g+r等价于查找引用函数和变量的地方
- 正常模式下，\\+g+t等价于跳转到类型定义
- 正常模式下，\\+g+i等价于挑战到函数实现


### 终端操作
- 终端模式下，ctrl+g等价于退出终端模式
- 正常模式下，\\+t+t等价于终端弹出方式为tab
- 正常模式下，\\+t+f等价于终端弹出方式为浮窗

### git操作
- 正常模式下，\+h+b等价于查看当前行的commit
