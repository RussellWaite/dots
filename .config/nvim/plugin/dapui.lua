require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7"),
  layout = {
    {
      elements = {
        { id = 'scopes',      size = 0.5  },
        { id = 'breakpoints', size = 0.15 },
        { id = 'stacks',      size = 0.2  },
        -- { id = 'watches',     size = 0.15 }
      },
      size = 80,
      position = 'left',
    },
    {
      elements = {
          { id = 'repl',    size = 0.65},
          -- { id = 'console', size = 0.35},
      },
      size = 20,
      position = 'bottom',
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
  }
})
