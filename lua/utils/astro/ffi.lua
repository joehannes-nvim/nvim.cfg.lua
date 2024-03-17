-- [nfnl] Compiled from fnl/utils/astro/ffi.fnl by https://github.com/Olical/nfnl, do not edit.
local ffi = require("ffi")
ffi.cdef("\9typedef struct {} Error;\n\9typedef struct {} win_T;\n\9typedef struct {\n\9\9int start;  // line number where deepest fold starts\n\9\9int level;  // fold level, when zero other fields are N/A\n\9\9int llevel; // lowest level that starts in v:lnum\n\9\9int lines;  // number of lines from v:lnum to end of closed fold\n\9} foldinfo_T;\n\9foldinfo_T fold_info(win_T* wp, int lnum);\n\9win_T *find_window_by_handle(int Window, Error *err);\n\9int compute_foldcolumn(win_T *wp, int col);\n")
return ffi
