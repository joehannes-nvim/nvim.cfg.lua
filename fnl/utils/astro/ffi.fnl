;; ### AstroNvim C Extensions
(local ffi (require :ffi))
(ffi.cdef "\ttypedef struct {} Error;
\ttypedef struct {} win_T;
\ttypedef struct {
\t\tint start;  // line number where deepest fold starts
\t\tint level;  // fold level, when zero other fields are N/A
\t\tint llevel; // lowest level that starts in v:lnum
\t\tint lines;  // number of lines from v:lnum to end of closed fold
\t} foldinfo_T;
\tfoldinfo_T fold_info(win_T* wp, int lnum);
\twin_T *find_window_by_handle(int Window, Error *err);
\tint compute_foldcolumn(win_T *wp, int col);
")
ffi
