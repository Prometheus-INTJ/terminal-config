# 终端配置文件

本仓库包含常用的终端配置文件，用于简化命令行操作，提升效率。这些配置可以在 macOS 或其他基于 Unix 的系统中使用，支持 `bash` 和 `zsh`。

## 文件说明

- **`.env`**  
  环境变量配置文件，包含系统路径、语言环境等设置。

- **`.aliases`**  
  常用别名配置文件，用于快速执行简化命令。

- **`.functions`**  
  自定义函数配置文件，用于封装常用的复杂命令逻辑。

## 使用方法

### 克隆仓库
将本仓库克隆到本地，例如：
```bash
git clone https://github.com/username/terminal-config.git ~/terminal-config
```

### 加载配置文件

#### 方法一：手动加载
在终端配置文件（如 `~/.zshrc` 或 `~/.bashrc`）中加入以下内容：
```bash
# 加载环境变量
if [ -f ~/.terminal-config/.env ]; then
    source ~/.terminal-config/.env
fi

# 加载别名
if [ -f ~/.terminal-config/.aliases ]; then
    source ~/.terminal-config/.aliases
fi

# 加载自定义函数
if [ -f ~/.terminal-config/.functions ]; then
    source ~/.terminal-config/.functions
fi
```

保存后重新加载终端配置：
```bash
source ~/.zshrc
```

#### 方法二：在 `.bash_profile` 或 `.zshrc` 中引用外部文件

你可以直接在终端配置文件（如 `~/.bash_profile` 或 `~/.zshrc`）中手动引用这些外部文件，无需运行任何安装脚本。具体步骤如下：

1. **打开配置文件**
   - 如果使用 `zsh`，编辑 `~/.zshrc`：
     ```bash
     nano ~/.zshrc
     ```
   - 如果使用 `bash`，编辑 `~/.bash_profile`：
     ```bash
     nano ~/.bash_profile
     ```

2. **添加引用外部文件的命令**
   在文件末尾添加以下内容：

   ```bash
   # 加载环境变量
   if [ -f ~/.terminal-config/.env ]; then
       source ~/.terminal-config/.env
   fi

   # 加载别名
   if [ -f ~/.terminal-config/.aliases ]; then
       source ~/.terminal-config/.aliases
   fi

   # 加载自定义函数
   if [ -f ~/.terminal-config/.functions ]; then
       source ~/.terminal-config/.functions
   fi
   ```

3. **保存并生效**
   - 保存文件后，重新加载配置：
     ```bash
     source ~/.zshrc  # 如果使用 zsh
     source ~/.bash_profile  # 如果使用 bash
     ```

4. **使用验证**
   - 执行命令 `ll` 验证别名是否生效。
   - 执行 `echo $PATH` 验证环境变量是否正确加载。

### 使用示例

1. **环境变量**  
   配置在 `.env` 文件中，例如：
   ```bash
   export PATH="$PATH:/usr/local/bin:/opt/homebrew/bin"
   export LANG="zh_CN.UTF-8"
   ```

2. **别名**  
   配置在 `.aliases` 文件中，例如：
   ```bash
   alias ll='ls -lh'
   alias gs='git status'
   alias brewup='brew update && brew upgrade'
   ```

   使用示例：
   ```bash
   $ ll
   drwxr-xr-x  5 user staff  160 Nov 24 15:00 Documents
   ```

3. **自定义函数**  
   配置在 `.functions` 文件中，例如：
   ```bash
   create_iso() {
       if [ "$#" -lt 1 ]; then
           echo "Usage: create_iso <folder_path> [iso_name]"
           return 1
       fi
       folder_path="$1"
       iso_name="${2:-$(basename "$folder_path")_backup.iso}"
       output_path=$(dirname "$folder_path")/"$iso_name"
       echo "Creating ISO..."
       hdiutil makehybrid -o "$output_path" "$folder_path" -iso
       echo "ISO created at $output_path"
   }
   ```

   使用示例：
   ```bash
   $ create_iso ~/Documents my_backup.iso
   ```

## 注意事项

1. **检查敏感信息**  
   确保 `.env` 文件中没有包含 API 密钥、密码等私密信息。

2. **支持的终端**  
   本配置适用于 `bash` 和 `zsh`。如需支持其他终端，请根据需要调整。
