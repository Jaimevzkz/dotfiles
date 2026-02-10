return {
  'fei6409/log-highlight.nvim',
  opts = {},
  config = function ()
    require('log-highlight').setup {
      ---@type string|string[]  File extensions. Default: 'log'
      extension = {
        'log',
        'txt',
        'tmlog'
      },

      ---@type string|string[]  File names or full file paths. Default: {}
      filename = {
        -- log.txt  
      },

      ---@type string|string[]  File name/path glob patterns. Default: {}
      pattern = {
        -- Use `%` to escape special characters and match them literally.
--        '%/var%/log%/.*',
--       'console%-ramoops.*',
--       'log.*%.txt',
--        'logcat.*',
      },
    }

  end
}
