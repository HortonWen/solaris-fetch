# SOLARIS-FETCH

东南大学成贤学院 RoboMaster **SOLARIS 战队**的终端横幅程序 —— 打开终端，就能看到战队的太阳。

一个**独立**的 Bash 小程序（不依赖 neofetch / fastfetch 等任何 fetch 工具）：左侧是战队视觉标识，右侧是实时系统信息。

## 预览

```text
───█▀█ █▀█ █▀▄ █▀█ █▄▀▄█ █▀█ █▀▀ ▀█▀ █▀▀ █▀█────   SEU CXXY · ROBOMASTER
───██▀ █ █ █▀▄ █ █ █ ▀ █ ███ ▀▀█  █  ██  ██▀────   ╭────────────────────────────╮
───█ █ ▀▀▀ ▀▀▀ ▀▀▀ █   █ █ █ ▀▀▀  █  ▀▀▀ █ █────   │   S O L A R I S  T E A M   │
 ████   ████  ██      ████  █████  ██████  ████    ╰────────────────────────────╯
██     ██  ██ ██     ██  ██ ██  ██   ██   ██       host   seu@robo-master
██     ██  ██ ██     ██  ██ ██  ██   ██   ██       os     Ubuntu 22.04.5 LTS
 ███   ██  ██ ██     ██████ █████    ██    ███     kernel 6.8.0-49-generic
    ██ ██  ██ ██     ██  ██ ██ █     ██       ██   uptime 7m
    ██ ██  ██ ██     ██  ██ ██  █    ██       ██   shell  bash
███     ████  ██████ ██  ██ ██   █ ██████ ███      cpu    Intel Core Ultra 9 285H
  ╭──── 東南大學 ────╮                             gpu    Discrete GPU
  │    ╲ ▄▄▄▄▄▄ ╱    │                             mem    1024 / 16384 MiB
  │ 1902 ▟████▙ 南京 │                             school 东南大学成贤学院 (SEU CXXY)
  │       ╲▀▀╱       │                             team   Solaris
  ╰──── 止於至善 ────╯                             slogan 秣陵形胜，共赴千山
                                                   ────────────────────────────
                                                   ▸ SYS.ACTIVE ● SOLARIS-2026 ● TEAM-01
▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇

  秣陵形胜，共赴千山
  BEYOND LIMITS · DEFEND OUR HONOR · UNITED WE BUILD VICTORY
```

> 实际运行效果为真彩色（TrueColor）：`ROBOMASTER` 为银白金属双色艺体字，`SOLARIS` 为琥珀金→太阳红水平渐变，校徽为东大原色（黄环+绿三角），底部为渐变能量条。请在支持 TrueColor 的终端（Windows Terminal、WezTerm、kitty、iTerm2 等）中观看。

## 设计元素

| 元素 | 说明 |
|---|---|
| `R O B O M A S T E R` 艺体字 | 3 行半块字符手绘字形；横笔亮银高光、竖笔枪铁蓝灰，金属装甲质感 |
| `SOLARIS` 主标识 | 7 行块状字，琥珀金 → 太阳红水平真彩渐变，呼应海报机甲的橙色发光描边 |
| 校徽 | 东南大学校徽简化版：黄环 +「東南大學」「止於至善」+ 绿倒三角 + 大礼堂剪影 +「1902 / 南京」 |
| 信息栏 | 红字英文标签（host / os / kernel / … / school / team / slogan），米白数值 |
| 能量条 + 口号 | 底部橙红渐变条，战队口号「秣陵形胜，共赴千山」 |

## 安装

依赖：仅 `bash`（以及常规 coreutils / awk / sed）。Ubuntu / Debian / WSL 可直接使用。

```bash
git clone https://github.com/HortonWen/solaris-fetch.git
cd solaris-fetch
sudo install -m 755 solaris-fetch /usr/local/bin/solaris-fetch
```

或单文件拷贝：把 `solaris-fetch` 放到 `$PATH` 中任意位置并 `chmod +x` 即可。

## 使用

```bash
solaris-fetch        # 显示横幅
solaris-fetch -a     # 逐行动画显示（开机自检既视感）
```

想每次开终端自动展示，可在 `~/.bashrc` 末尾加一行 `solaris-fetch`。

## PowerShell 版（Windows）

`solaris-fetch.ps1` 是与 bash 版视觉完全一致的独立实现（系统信息改由 WMI/CIM 采集），适用于 Windows Terminal / pwsh / Windows PowerShell 5.1+：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\solaris-fetch.ps1            # 直接显示
powershell -NoProfile -ExecutionPolicy Bypass -File .\solaris-fetch.ps1 -Animate   # 逐行动画
```

想随手调用，可在 PowerShell `$PROFILE` 中加：

```powershell
function sf { & 'C:\path\to\solaris-fetch.ps1' @args }
```

> 注：脚本为 UTF-8 with BOM 编码（Windows PowerShell 5.1 正确读取中文所需），请勿以 ANSI 重新保存。

## 计算机协会版 cxa-fetch

`cxa-fetch` 是东南大学成贤学院**计算机协会**的终端横幅，与本仓库同款块状字设计语言，但换了一套视觉：

- 顶部 `COMPUTER / ASSOCIATION` 两行艺体字，科技青→蓝渐变
- 中部**奶龙像素画**：黄色圆顶头+梨形身、绿环黑瞳圆眼、细黑微笑线、奶白肚皮（招新海报同款形象）
- 左下角保留东南大学校徽；信息栏仅保留 school 一栏与系统信息，**无口号**
- 底部青色渐变能量条

```bash
sudo install -m 755 cxa-fetch /usr/local/bin/cxa-fetch
cxa-fetch        # 显示横幅
cxa-fetch -a     # 逐行动画
```

## 天文爱好者协会版 astro-fetch

`astro-fetch` 是东南大学成贤学院**天文爱好者协会**的终端横幅，像素画还原协会徽章：

- 星空圆环：左上蓝 → 右下紫对角渐变 + 伪随机白色星点，环上六处四角星芒
- 白色花瓣形内框，框内为徽章的占星少女：灰蓝魔女帽（帽上星星+侧边行星珠）、猫耳冰白发、异色瞳（左青右紫）、右眼金色单片眼镜、腮红微笑
- 顶部 `ASTRONOMY / ASSOCIATION` 暮紫渐变艺体字；信息栏保留 school 一栏，无口号
- 底部蓝紫渐变能量条，状态行 `▸ CLEAR SKY ● ASTRO-2026 ● AD ASTRA`

```bash
sudo install -m 755 astro-fetch /usr/local/bin/astro-fetch
astro-fetch        # 显示横幅
astro-fetch -a     # 逐行动画
```

## 自定义

脚本为单文件 Bash，全部视觉定义集中在文件头部：

- `g_S / g_O / g_L / g_A / g_R / g_I`：SOLARIS 七行块字字形（`#` 为实心块）
- `rR / rO / rB / rM / rA / rS / rT / rE`：ROBOMASTER 三行艺体字字形
- `tc R G B`：TrueColor 上色函数；渐变范围在字标循环中调整
- 校徽、信息栏、口号均为普通字符串数组，直接改文字即可

## License

MIT © SOLARIS Team, SEU Chengxian College RoboMaster
