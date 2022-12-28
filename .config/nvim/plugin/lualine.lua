-- Lualine configuration

local non_language_ft = {'fugitive', 'startify'}

local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then return ''
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
       return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
    end
    return str
  end
end

require('lualine').setup({
  options = {
    theme = "tokyonight",
    -- Separators might look weird for certain fonts (eg Cascadia)
    -- component_separators = {left = '', right = ''},
    component_separators = '|',
    section_separators = {left = '', right = ''},
    -- section_separators = {left = '', right = ''},
  },
  sections = {
    lualine_a = {'mode'},
    -- lualine_a = { { 'mode',  right_padding = 0 }, },
    -- lualine_b = {'branch', 'diff'},
    lualine_b = {
        {
            'diagnostics',
            sources = {'nvim_diagnostic'},
            -- sources = {'nvim'},
            sections = {'error', 'warn', 'info'},
        },
    },
    lualine_c = {
      'filetype',
      {'branch'},
      {
        function()
          local msg = 'No LSP'
          local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
          local clients = vim.lsp.get_active_clients()

          if next(clients) == nil  then
            return msg
          end

          -- Check for utility buffers
          for ft in non_language_ft do
            if ft:match(buf_ft) then
              return ''
            end
          end

          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes

            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              -- return 'LSP:'..client.name  -- Return LSP name
              return ''  -- Only display if no LSP is found
            end
          end

          return msg
        end,
        color = {fg = '#ffffff', gui = 'bold'},
        separator = "",
      },
      {function() return require'lsp-status'.status() end},
    },
    lualine_x = {'filename', 'encoding'},
    lualine_y = {'progress'},
    -- lualine_z = {
    --   {function () return '' end},
    --   {'location'},
    -- }
    lualine_z = { 'location' },
  },
})

