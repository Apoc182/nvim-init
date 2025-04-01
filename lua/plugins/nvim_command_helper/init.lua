
local M = {}

M.api_key = os.getenv("OPENAI_API_KEY") or nil  -- Set this dynamically
M.model = "gpt-4o"  -- Change if needed

-- Function to display text in a floating window

local function show_message(message)
    -- Split the message by newline
    local lines = {}
    for line in message:gmatch("([^\n]*)\n?") do
        table.insert(lines, line)
    end

    -- Determine the longest line for width
    local width = 0
    for _, line in ipairs(lines) do
        if #line > width then
            width = #line
        end
    end
    width = width + 4

    local height = #lines

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    local opts = {
        relative = "editor",
        width = width,
        height = height,
        row = 5,
        col = 10,
        style = "minimal",
        border = "rounded",
    }

    vim.api.nvim_open_win(buf, false, opts)
    vim.defer_fn(function()
        vim.api.nvim_buf_delete(buf, { force = true })
    end, 10000)
end
-- Function to send an API request to OpenAI
local function fetch_openai_response(user_input)
    if not M.api_key then
        show_message("API key not set!")
        return
    end

    local api_url = "https://api.openai.com/v1/chat/completions"
    local headers = {
        "-H", "Content-Type: application/json",
        "-H", "Authorization: Bearer " .. M.api_key
    }

    local body = vim.fn.json_encode({
        model = M.model,
        messages = {
            { role = "system", content = "You are an AI assistant that provides Neovim key sequences. Provide only the sequences. Also add a very brief description of each key's role in the command." },
            { role = "user", content = user_input }
        }
    })

    -- Execute curl request
    
    local cmd = "curl -s -X POST " .. api_url ..
    ' -H "Content-Type: application/json"' ..
    ' -H "Authorization: Bearer ' .. M.api_key .. '"' ..
    ' -d "' .. body:gsub('"', '\\"') .. '"'
   
    local response = vim.fn.system(cmd)

    local result = vim.fn.json_decode(response)

    if result and result.choices and result.choices[1] then
        show_message("Keys: " .. result.choices[1].message.content)
    else
    local lines = {}
    for s in response:gmatch("[^\r\n]+") do
        table.insert(lines, s)
    end
        show_message(table.concat(lines, " "))
    end

end

-- Function to open an input prompt and query OpenAI
function M.ask_command()
    vim.ui.input({ prompt = "Enter a command description: " }, function(input)
        if input and input ~= "" then
            fetch_openai_response(input)
        end
    end)
end

-- Command to set API key (for security, use env variable in production)
function M.set_api_key(key)
    M.api_key = key
    show_message("API key set!")
end

-- Create a Neovim command to trigger the input prompt
vim.api.nvim_create_user_command("AskCommand", M.ask_command, {})

vim.api.nvim_create_user_command("SetApiKey", function(opts)
    M.set_api_key(opts.args)
end, { nargs = 1 })

return M
