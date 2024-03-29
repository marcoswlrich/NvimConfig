return {
  'nvim-tree/nvim-web-devicons',
  config = function()
    local ok, nvim_web_devicons = pcall(require, 'nvim-web-devicons')
    if not ok then
      return
    end

    local shared_configs = {
      rc_file = {
        icon = '',
        name = 'RCFile',
      },
      docker = {
        icon = '',
        color = '#2496ed',
        name = 'Docker',
      },
    }

    local tool_configs = {
      astro = {
        icon = '󱓞',
        color = '#ff7e33',
        name = 'AstroConfig',
      },
      next = {
        icon = '',
        color = '#000000',
        name = 'NextjsConfig',
      },
      remix = {
        icon = '',
        color = '#d83cd2',
        name = 'RemixConfig',
      },
      tailwind = {
        icon = '󱏿',
        color = '#0fa5e9',
        name = 'TailwindCSSConfig',
      },
      vite = {
        icon = '',
        color = '#ffcc24',
        name = 'ViteConfig',
      },
    }

    local web_config_file_endings = { '.js', '.ts', '.mjs', '.cjs' }
    local web_tool_configs = {}
    for tool_name, icon_config in pairs(tool_configs) do
      for _, file_ending in ipairs(web_config_file_endings) do
        web_tool_configs[tool_name .. '.config' .. file_ending] = icon_config
      end
    end

    local icon_configs = {
      ['.gitignore'] = {
        icon = '',
        color = '#f54d27',
        name = 'Gitignore',
      },
      ['yarn.lock'] = {
        icon = '',
        color = '#2188b6',
        name = 'YarnLockfile',
      },
      ['package-lock.json'] = {
        icon = '',
        color = '#84ba64',
        name = 'NPMLockfile',
      },
      ['package.json'] = {
        icon = '',
        color = '#cb0000',
        name = 'PackageJSON',
      },
      ['tsconfig.json'] = {
        icon = '',
        color = '#3278c6',
        name = 'TSConfig',
      },
      tmpl = {
        icon = '󰗀',
        color = '#f16529',
        name = 'GolangHTMLTemplate',
      },
      ['go.mod'] = {
        icon = '󰟓',
        color = '#519aba',
        name = 'GolangSum',
      },
      go = {
        icon = '',
        color = '#519aba',
        cterm_color = '74',
        name = 'Go',
      },
      html = {
        icon = '',
        color = '#f16529',
        name = 'HTML',
      },
      css = {
        icon = '',
        color = '#409ad6',
        name = 'CSS',
      },
      js = {
        icon = '󰌞',
        color = '#f6e400',
        name = 'Javascript',
      },
      mjs = {
        icon = '󰌞',
        color = '#f6e400',
        name = 'Javascript',
      },
      cjs = {
        icon = '󰌞',
        color = '#f6e400',
        name = 'Javascript',
      },
      ts = {
        icon = '󰛦',
        color = '#3278c6',
        name = 'Typescript',
      },
      njk = {
        icon = '',
        color = '#5cb85c',
        name = 'Nunjucks',
      },
      --lir_folder_icon = {
      --icon = '',
      --color = '#7ebae4',
      --name = 'LirFolderNode',
      --},
      ['test.js'] = {
        icon = '󰙨',
        color = '#cbcb41',
        name = 'JsTest',
      },
      ['spec.js'] = {
        icon = '󰙨',
        color = '#f6e400',
        name = 'JsSpec',
      },
      ['test.lua'] = {
        icon = '󰙨',
        color = '#51a0cf',
        name = 'LuaTest',
      },
      ['spec.lua'] = {
        icon = '󰙨',
        color = '#51a0cf',
        name = 'LuaSpec',
      },
      tl = {
        icon = '󰢱',
        color = '#0095a0',
        name = 'Teal',
      },
      jsonc = {
        icon = '',
        color = '#f6e400',
        name = 'JsonC',
      },
      graphql = {
        icon = '󰡷',
        color = '#e10298',
        name = 'GraphQL',
      },
      astro = {
        icon = '󱓞',
        color = '#ff7e33',
        name = 'Astro',
      },
      scm = {
        icon = '',
        color = '#afdb89',
        name = 'TreesitterQuery',
      },
      ['css.ts'] = {
        icon = '',
        color = '#3278c6',
        name = 'CSS.TS',
      },
      ['.prettierrc'] = shared_configs.rc_file,
      ['.prettierignore'] = shared_configs.rc_file,
      ['.prettierrc.json'] = shared_configs.rc_file,
      ['.eslintrc'] = shared_configs.rc_file,
      ['.eslintignore'] = shared_configs.rc_file,
      ['.eslintrc.json'] = shared_configs.rc_file,
      Dockerfile = shared_configs.docker,
      ['.dockerignore'] = shared_configs.docker,
      ['docker-compose.yml'] = shared_configs.docker,
    }

    -- load the configuration for the web-devicons plugin
    nvim_web_devicons.setup {
      override = vim.tbl_deep_extend('force', icon_configs, web_tool_configs),
      default = false,
    }
  end
}
