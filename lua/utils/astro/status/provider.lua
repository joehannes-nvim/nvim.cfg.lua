-- [nfnl] Compiled from fnl/utils/astro/status/provider.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
local condition = require("utils.astro.status.condition")
local env = require("utils.astro.status.env")
local status_utils = require("utils.astro.status.utils")
local utils = require("utils.astro")
local extend_tbl = utils.extend_tbl
local get_icon = utils.get_icon
local luv = (vim.uv or vim.loop)
M.fill = function()
  return "%="
end
M.signcolumn = function(opts)
  opts = extend_tbl({escape = false}, opts)
  return status_utils.stylize("%s", opts)
end
M.numbercolumn = function(opts)
  opts = extend_tbl({culright = true, escape = false, thousands = false}, opts)
  local function _1_(self)
    local lnum, rnum, virtnum = vim.v.lnum, vim.v.relnum, vim.v.virtnum
    local num, relnum = (vim.opt.number):get(), (vim.opt.relativenumber):get()
    local signs = ((vim.opt.signcolumn):get():find("nu") and ((vim.fn.sign_getplaced((self.bufnr or vim.api.nvim_get_current_buf()), {group = "*", lnum = lnum}))[1]).signs)
    local str = nil
    if (virtnum ~= 0) then
      str = "%="
    elseif (signs and (#signs > 0)) then
      local sign = (vim.fn.sign_getdefined((signs[1]).name))[1]
      str = ("%=%#" .. sign.texthl .. "#" .. sign.text .. "%*")
    elseif (not num and not relnum) then
      str = "%="
    else
      local cur = ((relnum and (((rnum > 0) and rnum) or ((num and lnum) or 0))) or lnum)
      if (opts.thousands and (cur > 999)) then
        cur = string.reverse(cur):gsub("%d%d%d", ("%1" .. opts.thousands)):reverse():gsub(("^%" .. opts.thousands), "")
      else
      end
      str = (((((rnum == 0) and not opts.culright) and relnum) and (cur .. "%=")) or ("%=" .. cur))
    end
    return status_utils.stylize(str, opts)
  end
  return _1_
end
M.foldcolumn = function(opts)
  opts = extend_tbl({escape = false}, opts)
  local ffi = require("utils.astro.ffi")
  local fillchars = (vim.opt.fillchars):get()
  local foldopen = (fillchars.foldopen or get_icon("FoldOpened"))
  local foldclosed = (fillchars.foldclose or get_icon("FoldClosed"))
  local foldsep = (fillchars.foldsep or get_icon("FoldSeparator"))
  local function _4_()
    local wp = ffi.C.find_window_by_handle(0, ffi.new("Error"))
    local width = ffi.C.compute_foldcolumn(wp, 0)
    local foldinfo = (((width > 0) and ffi.C.fold_info(wp, vim.v.lnum)) or {level = 0, lines = 0, llevel = 0, start = 0})
    local str = ""
    if (width ~= 0) then
      str = (((vim.v.relnum > 0) and "%#FoldColumn#") or "%#CursorLineFold#")
      if (foldinfo.level == 0) then
        str = (str .. (" "):rep(width))
      else
        local closed = (foldinfo.lines > 0)
        local first_level = (((foldinfo.level - width) - ((closed and 1) or 0)) + 1)
        if (first_level < 1) then
          first_level = 1
        else
        end
        for col = 1, width do
          str = (str .. (((((vim.v.virtnum ~= 0) and foldsep) or ((closed and ((col == foldinfo.level) or (col == width))) and foldclosed)) or (((foldinfo.start == vim.v.lnum) and ((first_level + col) > foldinfo.llevel)) and foldopen)) or foldsep))
          if (col == foldinfo.level) then
            str = (str .. (" "):rep((width - col)))
            break
          else
          end
        end
      end
    else
    end
    return status_utils.stylize((str .. "%*"), opts)
  end
  return _4_
end
M.tabnr = function()
  local function _9_(self)
    return (((self and self.tabnr) and ("%" .. self.tabnr .. "T " .. self.tabnr .. " %T")) or "")
  end
  return _9_
end
M.spell = function(opts)
  opts = extend_tbl({icon = {kind = "Spellcheck"}, show_empty = true, str = ""}, opts)
  local function _10_()
    return status_utils.stylize(((vim.wo.spell and opts.str) or nil), opts)
  end
  return _10_
end
M.paste = function(opts)
  opts = extend_tbl({icon = {kind = "Paste"}, show_empty = true, str = ""}, opts)
  local paste = vim.opt.paste
  if (type(paste) ~= "boolean") then
    paste = paste:get()
  else
  end
  local function _12_()
    return status_utils.stylize(((paste and opts.str) or nil), opts)
  end
  return _12_
end
M.macro_recording = function(opts)
  opts = extend_tbl({prefix = "@"}, opts)
  local function _13_()
    local register = vim.fn.reg_recording()
    if (register ~= "") then
      register = (opts.prefix .. register)
    else
    end
    return status_utils.stylize(register, opts)
  end
  return _13_
end
M.showcmd = function(opts)
  opts = extend_tbl({maxwid = 5, minwid = 0, escape = false}, opts)
  return status_utils.stylize(("%%%d.%d(%%S%%)"):format(opts.minwid, opts.maxwid), opts)
end
M.search_count = function(opts)
  local search_func
  local function _15_()
    return vim.fn.searchcount()
  end
  local function _16_()
    return vim.fn.searchcount(opts)
  end
  search_func = ((vim.tbl_isempty((opts or {})) and _15_) or _16_)
  local function _17_()
    local search_ok, search = pcall(search_func)
    if ((search_ok and (type(search) == "table")) and search.total) then
      return status_utils.stylize(string.format("%s%d/%s%d", (((search.current > search.maxcount) and ">") or ""), math.min(search.current, search.maxcount), (((search.incomplete == 2) and ">") or ""), math.min(search.total, search.maxcount)), opts)
    else
      return nil
    end
  end
  return _17_
end
M.mode_text = function(opts)
  local max_length
  local function _19_(str)
    return #str[1]
  end
  max_length = math.max(unpack(vim.tbl_map(_19_, vim.tbl_values(env.modes))))
  local function _20_()
    local text = env.modes[vim.fn.mode()][1]
    if (opts and opts.pad_text) then
      local padding = (max_length - #text)
      if (opts.pad_text == "right") then
        text = (string.rep(" ", padding) .. text)
      elseif (opts.pad_text == "left") then
        text = (text .. string.rep(" ", padding))
      elseif (opts.pad_text == "center") then
        text = (string.rep(" ", math.floor((padding / 2))) .. text .. string.rep(" ", math.ceil((padding / 2))))
      else
      end
    else
    end
    return status_utils.stylize(text, opts)
  end
  return _20_
end
M.percentage = function(opts)
  opts = extend_tbl({edge_text = true, fixed_width = true, escape = false}, opts)
  local function _23_()
    local text = ("%" .. ((opts.fixed_width and ((opts.edge_text and "2") or "3")) or "") .. "p%%")
    if opts.edge_text then
      local current_line = vim.fn.line(".")
      if (current_line == 1) then
        text = "Top"
      elseif (current_line == vim.fn.line("$")) then
        text = "Bot"
      else
      end
    else
    end
    return status_utils.stylize(text, opts)
  end
  return _23_
end
M.ruler = function(opts)
  opts = extend_tbl({pad_ruler = {char = 2, line = 3}}, opts)
  local padding_str = string.format("%%%dd:%%-%dd", opts.pad_ruler.line, opts.pad_ruler.char)
  local function _26_()
    local line = vim.fn.line(".")
    local char = vim.fn.virtcol(".")
    return status_utils.stylize(string.format(padding_str, line, char), opts)
  end
  return _26_
end
M.scrollbar = function(opts)
  local sbar = {"\226\150\129", "\226\150\130", "\226\150\131", "\226\150\132", "\226\150\133", "\226\150\134", "\226\150\135", "\226\150\136"}
  local function _27_()
    local curr_line = (vim.api.nvim_win_get_cursor(0))[1]
    local lines = vim.api.nvim_buf_line_count(0)
    local i = (math.floor((((curr_line - 1) / lines) * #sbar)) + 1)
    if sbar[i] then
      return status_utils.stylize(string.rep(sbar[i], 2), opts)
    else
      return nil
    end
  end
  return _27_
end
M.close_button = function(opts)
  opts = extend_tbl({kind = "BufferClose"}, opts)
  return status_utils.stylize(get_icon(opts.kind), opts)
end
M.filetype = function(opts)
  local function _29_(self)
    local buffer = vim.bo[((self and self.bufnr) or 0)]
    return status_utils.stylize(string.lower(buffer.filetype), opts)
  end
  return _29_
end
M.filename = function(opts)
  local function _30_(nr)
    return vim.api.nvim_buf_get_name(nr)
  end
  opts = extend_tbl({fallback = "Untitled", fname = _30_, modify = ":t"}, opts)
  local function _31_(self)
    local path = opts.fname(((self and self.bufnr) or 0))
    local filename = vim.fn.fnamemodify(path, opts.modify)
    return status_utils.stylize((((path == "") and opts.fallback) or filename), opts)
  end
  return _31_
end
M.file_encoding = function(opts)
  local function _32_(self)
    local buf_enc = (vim.bo[((self and self.bufnr) or 0)]).fenc
    return status_utils.stylize(string.upper((((buf_enc ~= "") and buf_enc) or vim.o.enc)), opts)
  end
  return _32_
end
M.file_format = function(opts)
  local function _33_(self)
    local buf_format = (vim.bo[((self and self.bufnr) or 0)]).fileformat
    return status_utils.stylize(string.upper((((buf_format ~= "") and buf_format) or vim.o.fileformat)), opts)
  end
  return _33_
end
M.unique_path = function(opts)
  local function _34_(bufnr)
    return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t")
  end
  opts = extend_tbl({buf_name = _34_, bufnr = 0, max_length = 16}, opts)
  local function path_parts(bufnr)
    local parts = {}
    for ___match___ in ((vim.api.nvim_buf_get_name(bufnr) .. "/")):gmatch(("(.-)" .. "/")) do
      table.insert(parts, ___match___)
    end
    return parts
  end
  local function _35_(self)
    opts.bufnr = ((self and self.bufnr) or opts.bufnr)
    local name = opts.buf_name(opts.bufnr)
    local unique_path = ""
    local current = nil
    for _, value in ipairs((vim.t.bufs or {})) do
      if ((name == opts.buf_name(value)) and (value ~= opts.bufnr)) then
        if not current then
          current = path_parts(opts.bufnr)
        else
        end
        local other = path_parts(value)
        for i = (#current - 1), 1, ( - 1) do
          if (current[i] ~= other[i]) then
            unique_path = (current[i] .. "/")
            break
          else
          end
        end
      else
      end
    end
    return status_utils.stylize(((((opts.max_length > 0) and (#unique_path > opts.max_length)) and (string.sub(unique_path, 1, (opts.max_length - 2)) .. get_icon("Ellipsis") .. "/")) or unique_path), opts)
  end
  return _35_
end
M.file_modified = function(opts)
  opts = extend_tbl({icon = {kind = "FileModified"}, show_empty = true, str = ""}, opts)
  local function _39_(self)
    return status_utils.stylize(((condition.file_modified(((self or {})).bufnr) and opts.str) or nil), opts)
  end
  return _39_
end
M.file_read_only = function(opts)
  opts = extend_tbl({icon = {kind = "FileReadOnly"}, show_empty = true, str = ""}, opts)
  local function _40_(self)
    return status_utils.stylize(((condition.file_read_only(((self or {})).bufnr) and opts.str) or nil), opts)
  end
  return _40_
end
M.file_icon = function(opts)
  local function _41_(self)
    local devicons_avail, devicons = pcall(require, "nvim-web-devicons")
    if not devicons_avail then
      return ""
    else
    end
    local bufnr = ((self and self.bufnr) or 0)
    local ft_icon, _ = devicons.get_icon(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t"))
    if not ft_icon then
      ft_icon, _ = devicons.get_icon_by_filetype(vim.bo[bufnr].filetype, {default = true})
    else
    end
    return status_utils.stylize(ft_icon, opts)
  end
  return _41_
end
M.git_branch = function(opts)
  local function _44_(self)
    return status_utils.stylize(((vim.b[((self and self.bufnr) or 0)]).gitsigns_head or ""), opts)
  end
  return _44_
end
M.git_diff = function(opts)
  if (not opts or not opts.type) then
    return 
  else
  end
  local function _46_(self)
    local status = (vim.b[((self and self.bufnr) or 0)]).gitsigns_status_dict
    return status_utils.stylize(((((status and status[opts.type]) and (status[opts.type] > 0)) and tostring(status[opts.type])) or ""), opts)
  end
  return _46_
end
M.diagnostics = function(opts)
  if (not opts or not opts.severity) then
    return 
  else
  end
  local function _48_(self)
    local bufnr = ((self and self.bufnr) or 0)
    local count = #vim.diagnostic.get(bufnr, (opts.severity and {severity = vim.diagnostic.severity[opts.severity]}))
    return status_utils.stylize((((count ~= 0) and tostring(count)) or ""), opts)
  end
  return _48_
end
M.lsp_progress = function(opts)
  local spinner = (utils.get_spinner("LSPLoading", 1) or {""})
  local function _49_()
    local _, Lsp = next(_G.my.astro.lsp.progress)
    return status_utils.stylize((Lsp and (spinner[((math.floor((luv.hrtime() / 120000000)) % #spinner) + 1)] .. table.concat({(Lsp.title or ""), (Lsp.message or ""), ((Lsp.percentage and ("(" .. Lsp.percentage .. "%)")) or "")}, " "))), opts)
  end
  return _49_
end
M.lsp_client_names = function(opts)
  opts = extend_tbl({expand_null_ls = true, truncate = 0.25}, opts)
  local function _50_(self)
    local buf_client_names = {}
    for _, client in pairs(vim.lsp.get_active_clients({bufnr = ((self and self.bufnr) or 0)})) do
      if ((client.name == "null-ls") and opts.expand_null_ls) then
        local null_ls_sources = {}
        for _0, type in ipairs({"FORMATTING", "DIAGNOSTICS"}) do
          for _1, source in ipairs(status_utils.null_ls_sources(vim.bo.filetype, type)) do
            null_ls_sources[source] = true
          end
        end
        vim.list_extend(buf_client_names, vim.tbl_keys(null_ls_sources))
      else
        table.insert(buf_client_names, client.name)
      end
    end
    local str = table.concat(buf_client_names, ", ")
    if (type(opts.truncate) == "number") then
      local max_width = math.floor((status_utils.width() * opts.truncate))
      if (#str > max_width) then
        str = (string.sub(str, 0, max_width) .. "\226\128\166")
      else
      end
    else
    end
    return status_utils.stylize(str, opts)
  end
  return _50_
end
M.treesitter_status = function(opts)
  local function _54_()
    return status_utils.stylize((((require("nvim-treesitter.parser")).has_parser() and "TS") or ""), opts)
  end
  return _54_
end
M.str = function(opts)
  opts = extend_tbl({str = " "}, opts)
  return status_utils.stylize(opts.str, opts)
end
return M
