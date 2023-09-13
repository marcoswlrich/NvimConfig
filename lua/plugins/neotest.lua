return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-python",
    "haydenmeade/neotest-jest",
  },
  keys = {
    { "<leader>ty", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
    {
      "<leader>tT",
      function() require("neotest").run.run(vim.loop.cwd()) end,
      desc =
      "Run All Test Files"
    },
    {
      "<leader>tr",
      function() require("neotest").run.run() end,
      desc =
      "Run Nearest"
    },
    {
      "<leader>ts",
      function() require("neotest").summary.toggle() end,
      desc =
      "Toggle Summary"
    },
    {
      "<leader>to",
      function() require("neotest").output.open({ enter = true, auto_close = true }) end,
      desc =
      "Show Output"
    },
    {
      "<leader>tO",
      function() require("neotest").output_panel.toggle() end,
      desc =
      "Toggle Output Panel"
    },
    { "<leader>tS", function() require("neotest").run.stop() end,                  desc = "Stop" },
  },
  config = function()
    -- get neotest namespace (api call creates or returns namespace)
    local neotest_ns = vim.api.nvim_create_namespace("neotest")

    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
          return message
        end,
      },
    }, neotest_ns)

    require("neotest").setup({
      -- your neotest config here
      adapters = {
        require("neotest-go"),
        require("neotest-python")({
          -- Extra arguments for nvim-dap configuration
          -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
          dap = { justMyCode = false },
          -- Command line arguments for runner
          -- Can also be a function to return dynamic values
          args = { "--log-level", "DEBUG" },
          -- Runner to use. Will use pytest if available by default.
          -- Can be a function to return dynamic value.
          runner = "pytest",
          -- Custom python path for the runner.
          -- Can be a string or a list of strings.
          -- Can also be a function to return dynamic value.
          -- If not provided, the path will be inferred by checking for
          -- virtual envs in the local directory and for Pipenev/Poetry configs
          python = ".venv/bin/python",
          -- Returns if a given file path is a test file.
          -- NB: This function is called a lot so don't perform any heavy tasks within it.
          is_test_file = function(file_path)

          end,

        }),
        require('neotest-jest')({
          jestCommand = "npm test --",
          jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        }),
      },
      -- status = {virtual_text = true}
      output = { open_on_run = true },
      quickfix = {
        open = function()
          vim.cmd("Trouble quickfix")
        end
      }
    })
  end
}
