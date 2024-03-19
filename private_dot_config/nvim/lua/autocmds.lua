-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd("Filetype", {
	pattern = { "json", "jsonc" },
	callback = function()
		vim.wo.spell = false
		vim.wo.conceallevel = 0
	end,
})

-- Buffer / Tabs helps to close the last one
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		-- If there's only one buffer and it's empty, close it when entering another buffer
		if
			vim.fn.winnr("$") == 1
			and (vim.fn.bufname() == "" or vim.fn.bufname() == "[No Name]")
			and vim.fn.line2byte("$") == -1
		then
			vim.cmd("bdelete")
		end
	end,
})

-- Custom function that can be called with lua to close the current buffer
function DomiCloseBuffer()
	local bufCount = #vim.fn.getbufinfo({ buflisted = true })

	if bufCount == 1 then
		-- Option 1: Quit Neovim
		vim.cmd("quit")

	-- Option 2: Open a new empty buffer (uncomment if preferred)
	-- vim.cmd("enew")
	else
		vim.cmd("bdelete")
	end
end

-- keymaps.lua
--vim.api.nvim_set_keymap("n", "<leader>q", ":lua DomiCloseBuffer()<CR>", { noremap = true, silent = true })

-- Custom command to quit all
vim.cmd([[
function! SmartCloseAllBuffersAndQuit()
    let l:unsaved_buffers = 0
    for buf in range(1, bufnr('$'))
        if getbufvar(buf, '&mod')
            let l:unsaved_buffers += 1
        endif
    endfor
    if l:unsaved_buffers > 0
        echo "There are unsaved buffers!"
        return
    endif
    bufdo bd!
    quit
endfunction
]])

vim.cmd([[
command! Q call SmartCloseAllBuffersAndQuit()
]])
-- keymaps.lua
--vim.api.nvim_set_keymap('n', ':q', ':Q<CR>', { noremap = true, silent = true })

-- Autocmd to change behavior of '^' in certain file types
-- maybe remove the first autocmd maybe it is already market as typst?...
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.typ",
	command = "set filetype=typ",
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "python", "markdown", "txt", "typ", "typst" },
	command = "inoremap ^ ^",
})
