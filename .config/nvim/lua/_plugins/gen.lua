local is_enabled = require("logic.functions").is_enabled

if is_enabled('gen') then
  local gen, ok = pcall(require, 'gen')

  if ok then
    gen.prompts['Elaborate_Text'] = {
      prompt = "Elaborate the following text:\n$text",
      replace = true
    }
    gen.prompts['Fix_Code'] = {
      prompt = "Fix the following code. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
      replace = true,
      extract = "```$filetype\n(.-)```"
    }
    gen.prompts['Optimize the following code'] = {
      prompt = "Optimize the following code. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
      replace = true,
      extract = "```$filetype\n(.-)```"
    }
    gen.prompts['Refactor this code'] = {
      prompt = "Refactor the following code to be more readable. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
      replace = true,
      extract = "```$filetype\n(.-)```"
    }
  end
end


return {
  {
    "David-Kunz/gen.nvim",
    lazy = false,
    enabled = is_enabled('gen'),
    opts = {
      model         = "codellama",
      display_mode  = "float", -- The display mode. Can be "float" or "split".
      show_model    = true, -- Displays which model you are using at the beginning of your chat session.
      show_prompt   = true, -- Shows the Prompt submitted to Ollama.
      no_auto_close = false, -- Never closes the window automatically.
      init = function(options)
        pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
      end,
      command = "curl --silent --no-buffer -X POST http://localhost:11434/api/generate -d $body",
      -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
      -- This can also be a lua function returning a command string, with options as the input parameter.
      -- The executed command must return a JSON object with { response, context }
      -- (context property is optional).
      -- list_models = "<function>", -- Retrieves a list of model names
      debug = false, -- Prints errors and the command which is run.
    },
  },
}
