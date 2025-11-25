# Qwen Persona

一个便于用户自定义、保存并同步 Qwen Chat 自定义角色的 Tampermonkey 脚本。
A Tampermonkey script for customizing user-defined personas in Qwen Chat.

<p align="center">
  <img src="docs/image.png" alt="QwenPersona selection dropdown menu" width="45%" />
  <img src="docs/image-1.png" alt="QwenPersona add persona panel" width="45%" />
</p>

## 安装 Installation

1. 安装 [Tampermonkey](https://www.tampermonkey.net/) 浏览器扩展。
2. 下载脚本：
    - 从 [GreasyFork](https://greasyfork.org/zh-CN/scripts/556914-qwenpersona) 安装脚本（推荐）；
    - 或者自行构建：

     ```bash
     git clone https://github.com/kev1nweng/qwen-persona.git
     cd qwen-persona
     ./build.sh
     ```

      脚本将生成在 `dist/QwenPersona.user.js`，通过 Tampermonkey 导入该文件即可。
3. 访问 [Qwen Chat](https://chat.qwen.ai/) 并开始使用自定义角色功能。
