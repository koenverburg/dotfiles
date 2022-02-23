local ts_utils = require("nvim-treesitter.ts_utils")
local ns = vim.api.nvim_create_namespace("ns")
local M = {}

local method_start_targets = {
	-- Lua
	"function",
	"function_name",
	"local_function",

	-- Go,
	"function_declaration",
	-- 'if_statement',
	-- 'return_statement',
}

local function P(value)
	print(vim.inspect(value))
end

-- local Helpers = {}

-- function Helpers.DetermineIfStatementScore(node)
--   print('hii from helpers')
-- end

local nodes_table = {
	var_declaration = 1,
	short_var_declaration = 1,

	if_statement = 1, -- Helpers.DetermineIfStatementScore(node),
	binary_expression = 1,
	parenthesized_expression = 1,
}

local edges_table = {
	return_statement = 1,
}

-- M = (E − N) + 2
--
-- E = the number of edges of the graph.
-- N = the number of nodes of the graph.

-- Edges are number of exit paths of the method
local function calculateEdges(node)
	local result = 0
	local node_type = node:type()

	if not vim.tbl_contains(vim.tbl_keys(edges_table), node_type) then
		return 0
	end

	result = result + tonumber(edges_table[node_type])

	return result
end

-- Edges are number of exit paths of the method
local function calculateNodes(node)
	local result = 0
	local node_type = node:type()

	if not vim.tbl_contains(vim.tbl_keys(nodes_table), node_type) then
		return 0
	end

	result = result + tonumber(nodes_table[node_type])

	P(nodes_table[node_type])

	return result
end

local function loopOverChildren(node)
	local m = 0
	local edges = 0
	local nodes = 0
	local child_nodes = ts_utils.get_named_children(node)
	if not child_nodes then
		return
	end

	for _, key in ipairs(child_nodes) do
		if key:type() == "block" then
			for _, j in ipairs(ts_utils.get_named_children(key)) do
				local raw_edges = calculateEdges(j)

				if raw_edges ~= nil then
					edges = tonumber(raw_edges)
				end

				local raw_nodes = calculateEdges(j)
				if raw_nodes ~= nil then
					nodes = tonumber(raw_nodes)
				end
			end
		end
	end

	m = edges - nodes + 2

	print(m .. " = " .. edges .. "E" .. " - " .. nodes .. "N" .. " + 2")

	return m
end

local function setVirtualText(node, score)
	local targetLineNumber = node:start()
	local virtualText = " CC: " .. score
	vim.api.nvim_buf_set_virtual_text(0, ns, targetLineNumber, { { virtualText, "Comment" } }, {})
end

function M.show()
	local node = ts_utils.get_node_at_cursor()

	if not node then
		vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
		return
	end

	if vim.tbl_contains(method_start_targets, node:type()) then
		local score = loopOverChildren(node)
		setVirtualText(node, score)
	end
end

return M
