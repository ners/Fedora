match Error /\%96v.\+/

let b:ale_fixers = ['clang-format']
let b:ale_linters = ['clang', 'clangtidy']
let g:ale_c_parse_compile_commands=1
let g:ale_cpp_clangtidy_checks = []
let g:ale_cpp_clangtidy_executable = 'clang-tidy'
let g:ale_cpp_clangtidy_extra_options = ''
let g:ale_cpp_clangtidy_options = ''
let g:ale_linters_explicit=1
let g:ale_set_balloons=1

let g:ale_fix_on_save = 1

let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
