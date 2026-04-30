[Zed](https://zed.dev/) 是一个类似于 vscode 的编辑器，由 rust 开发，性能很好。

## 插件

zed 内置了很多好用的插件，基本上开箱即用。在右上角菜单里选择 `extensions` 可以搜索和安装插件。

- 图标：`Colored Zed Icons Theme`
- 主题：`Github Theme`

## 快捷键

```json
{
  // Toggle inlay hint
  {
    "context": "!AcpThread > Editor && mode == full",
    "bindings": {
      "alt-x": "editor::ToggleInlayHints"
    }
  },
}
```

## 设置

### 通用设置

```json
{
  // -- AI设置 --
  // 添加自定义模型
  "language_models": {
    "openai_compatible": {
      "MiniMax": {
        "api_url": "https://api.minimaxi.com/v1",
        "available_models": [
          {
            "name": "MiniMax-M2.7",
            "max_tokens": 200000,
            "max_output_tokens": 32000,
            "max_completion_tokens": 200000,
            "capabilities": {
              "tools": true,
              "images": false,
              "parallel_tool_calls": true,
              "prompt_cache_key": true,
              "chat_completions": true,
              "interleaved_reasoning": false
            }
          }
        ]
      },
      "GLM": {
        "api_url": "https://open.bigmodel.cn/api/coding/paas/v4",
        "available_models": [
          {
            "name": "glm-5.1",
            "max_tokens": 200000,
            "max_output_tokens": 32000,
            "max_completion_tokens": 200000,
            "capabilities": {
              "tools": true,
              "images": false,
              "parallel_tool_calls": true,
              "prompt_cache_key": true,
              "chat_completions": true,
              "interleaved_reasoning": false
            }
          }
        ]
      }
    }
  },
  // 设置自动补全模型
  "edit_predictions": {
    "mode": "eager",
    "provider": "open_ai_compatible_api",
    "open_ai_compatible_api": {
      "prompt_format": "deepseek_coder",
      "model": "deepseek-v4-flash",
      "api_url": "https://api.deepseek.com/beta/completions"
    }
  },
  // 设置claude-code
  "agent_servers": {
    "claude-acp": {
      "type": "registry"
    }
  },
  // agent面板
  "agent": {
    "inline_assistant_model": {
      "provider": "deepseek",
      "model": "deepseek-v4-flash",
      "enable_thinking": false
    },
    "default_profile": "write",
    "default_model": {
      "provider": "GLM",
      "model": "glm-5.1",
      "enable_thinking": false
    },
    "show_turn_stats": true,
    "notify_when_agent_waiting": "all_screens",
    "sidebar_side": "right",
    "dock": "right",
    "favorite_models": [],
    "model_parameters": []
  },

  // -- 面板布局 --
  "debugger": {
    "dock": "left"
  },
  "terminal": {
    "shell": {
      "program": "fish"
    }
  },
  "collaboration_panel": {
    "button": false
  },
  "git_panel": {
    "status_style": "label_color",
    "file_icons": true,
    "tree_view": true,
    "dock": "left"
  },
  "project_panel": {
    "hide_root": true,
    "diagnostic_badges": true,
    "git_status_indicator": true,
    "dock": "left"
  },
  "tab_bar": {
    "show_pinned_tabs_in_separate_row": true
  },
  "tabs": {
    "show_diagnostics": "all",
    "file_icons": true,
    "git_status": true
  },
  "status_bar": {
    "show_active_file": true
  },
  "minimap": {
    "show": "auto"
  },

  // -- 编辑器 --
  "which_key": {
    "delay_ms": 100,
    "enabled": true
  },
  "diagnostics": {
    "inline": {
      "enabled": true
    }
  },
  "session": {
    "trust_all_worktrees": true
  },
  "completion_menu_scrollbar": "auto",
  "auto_signature_help": true,
  "format_on_save": "off",
  "colorize_brackets": true,
  "ui_font_size": 16,
  "buffer_font_size": 16.0,

  // -- 软件设置 --
  "telemetry": {
    "diagnostics": false,
    "metrics": false
  },
  "auto_update": false,

  // -- 外观主题 --
  "icon_theme": {
    "mode": "dark",
    "light": "Zed (Default)",
    "dark": "Colored Zed Icons Theme Dark"
  },
  "theme": {
    "mode": "dark",
    "light": "Gruvbox Light",
    // 需要安装 `Github Theme` 插件
    "dark": "GitHub Dark Dimmed"
  }
}
```
