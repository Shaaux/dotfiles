-- dap-react.lua — drop-in LazyVim spec for this repo (React debug + run helpers).
--
-- INSTALL
--   Copy this file to:  ~/.config/nvim/lua/plugins/dap-react.lua
--   Then restart Neovim (LazyVim auto-loads anything under lua/plugins/).
--
-- PREREQS (enable once via :LazyExtras)
--   * dap.core         -> nvim-dap, nvim-dap-ui, mason-nvim-dap
--   * lang.typescript  -> installs the js-debug-adapter used for the React app
--   These specs use `optional = true`, so they only *augment* the extras above;
--   they pull in no plugins on their own.
--
-- WHAT YOU GET
--   * VS Code-style keys:  <F5> start/continue, <F10>/<F11> step, <F9> breakpoint,
--                          <F17> stop (= Shift-F5 in most terminals; <leader>dt also works)
--   * <F5> imports this repo's .vscode/launch.json, so the React configs are reused.
--   * :ReactDev            -> json-server + Vite together; close the terminal to stop BOTH.
--   * :MauiAndroid         -> build & run the MAUI Android head (CLI only; no breakpoints).
--   * :StartAndroidEmulator -> boot the Pixel9 AVD in the background.
--
-- ASSUMPTION
--   Open Neovim from the repo root (the folder containing .vscode/ and ReactApp/),
--   so :ReactDev's `cd ReactApp` and the launch.json path resolve correctly.

-- ── Run helpers (eager; need no plugins) ────────────────────────────────────
local function in_term(cmd)
  vim.cmd("tabnew | term bash -lc " .. vim.fn.shellescape(cmd))
  vim.cmd("startinsert")
end

vim.api.nvim_create_user_command("ReactDev", function()
  -- The kill-trap stops both servers when the terminal is closed or <C-c>'d.
  in_term("cd ReactApp && trap 'kill 0' SIGINT; npm run server & npm run dev & wait")
end, { desc = "React: run json-server + Vite (close terminal to stop both)" })

vim.api.nvim_create_user_command("StartAndroidEmulator", function()
  -- AVD lives under ~/.config/.android/avd/ on this machine (XDG relocation).
  in_term("ANDROID_AVD_HOME=$HOME/.config/.android/avd $HOME/Android/Sdk/emulator/emulator -avd Pixel9")
end, { desc = "Android: boot the Pixel9 AVD (close terminal to shut it down)" })

vim.api.nvim_create_user_command("MauiAndroid", function()
  in_term("cd MAUIApp && dotnet build -t:Run -f net10.0-android")
end, { desc = "MAUI: build & run the Android head (needs an emulator/device)" })

-- ── DAP setup: js-debug adapters + import launch.json (idempotent) ──────────
local function ensure_react_dap()
  local ok, dap = pcall(require, "dap")
  if not ok then
    vim.notify("nvim-dap not found — enable the dap.core LazyExtra", vim.log.levels.WARN)
    return
  end

  -- js-debug server installed by mason (via the lang.typescript extra).
  local server = vim.fn.stdpath("data")
    .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"

  -- Register both the modern (pwa-*) and legacy (node/chrome) type names so a
  -- VS Code launch.json using "type": "node" resolves to the js-debug server.
  for _, name in ipairs({ "pwa-node", "node", "pwa-chrome", "chrome" }) do
    dap.adapters[name] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = { command = "node", args = { server, "${port}" } },
    }
  end

  -- Import the repo's VS Code configs (json-server / vite) for <F5>.
  local launch = vim.fn.getcwd() .. "/.vscode/launch.json"
  if vim.fn.filereadable(launch) == 1 then
    require("dap.ext.vscode").load_launchjs(launch, {
      ["pwa-node"] = { "javascript", "typescript" },
      ["node"] = { "javascript", "typescript" },
      ["pwa-chrome"] = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      ["chrome"] = { "javascript", "javascriptreact" },
    })
  end
end

-- ── Plugin specs (augment the LazyVim extras) ───────────────────────────────
return {
  -- Make sure the JS debug adapter is installed even if lang.typescript is off.
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "js") -- js-debug-adapter
    end,
  },

  -- VS Code-style debug keymaps (additive — they extend LazyVim's <leader>d maps).
  {
    "mfussenegger/nvim-dap",
    optional = true,
    keys = {
      {
        "<F5>",
        function()
          ensure_react_dap()
          require("dap").continue()
        end,
        desc = "Debug: Start/Continue",
      },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
      { "<F17>", function() require("dap").terminate() end, desc = "Debug: Stop (Shift-F5)" },
      { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
    },
  },
}
